//
//  DSUnixTaskLauncher.m
//  Demo
//
//  Created by Fabio Pelosin on 04/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. MIT License.
//


#import "DSUnixTask.h"
#import "DSUnixTask+ManagerInterface.h"
#import "DSUnixTaskAbstractManager+TaskInterface.h"

@interface DSUnixTask ()
@property (readwrite) NSMutableArray* standardInputQueue;
@property (readwrite) NSMutableString* standardOutput;
@property (readwrite) NSMutableString* standardError;
@property (readwrite) int processIdentifier;
@property (readwrite) BOOL launched;
@property (readwrite) BOOL terminated;
@property (readwrite) int terminationStatus;
@end

@implementation DSUnixTask

//------------------------------------------------------------------------------
#pragma mark Initialization & Configuration
//------------------------------------------------------------------------------

- (id)init
{
  return [self initWithManager:nil];
}

- (instancetype)initWithManager:(DSUnixTaskAbstractManager*)manager;
{
  self = [super init];

  if (!manager) {
    [NSException exceptionWithName:NSInvalidArgumentException reason:@"The DSUnixTask needs to be initalized with a manager" userInfo:nil];
  }

  if (self) {
    _arguments = @[];
    _minimumAcceptedTerminationStatus = 0;
    _stringEncoding = NSUTF8StringEncoding;
    _environment = @{};
    _standardInputQueue = [NSMutableArray new];
    if (manager) {
      _manager = manager;
    }
  }
  return self;
}

- (void)setCommand:(NSString *)command;
{
  NSArray *componets = [command componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  NSString *launchPath = [componets objectAtIndex:0];
  NSMutableArray *arguments = [componets mutableCopy];
  [arguments removeObjectAtIndex:0];
  self.launchPath = launchPath;
  self.arguments = arguments;
}

- (NSString*)name
{
  if (_name) {
    return _name;
  } else {
    return [[self.launchPath componentsSeparatedByString:@"/"] lastObject];
  }
}

//------------------------------------------------------------------------------
#pragma mark Launching Tasks
//------------------------------------------------------------------------------

- (void)launch;
{
  self.standardOutput = [NSMutableString new];
  self.standardError  = [NSMutableString new];
  if (self.launched) {
    [NSException raise:@"Attempt to relaunch task" format:nil];
  }
  [self.manager launchTask:self];
  self.launched = TRUE;
}

- (void)writeStringToStandardInput:(NSString*)string;
{
  if ([self.manager prepareToWriteToStandardInput:self]) {
    [self.manager writeDataToStandardInput:[self _stringToData:string]
                                              ofTask:self];
  } else {
    [self.standardInputQueue addObject:string];
  }
}

- (void)sendEOFToStandardInput;
{
  [self.manager sendEOFToStandardInputOfTask:self];
}

//------------------------------------------------------------------------------
#pragma mark Subclasses hooks
//------------------------------------------------------------------------------

- (NSString *)effectiveLaunchPath;
{
  return self.launchPath;
}

- (NSArray *)effectiveArguments;
{
  return self.arguments;
}

- (NSDictionary *)effectiveEnvironment;
{
  return self.environment;
}

- (NSString *)effectiveWorkingDirectory;
{
  return self.workingDirectory;
}


//------------------------------------------------------------------------------
#pragma mark Private helpers
//------------------------------------------------------------------------------

- (NSString*)_dataToString:(NSData*) data
{
  return [[NSString alloc] initWithData:data encoding:self.stringEncoding];
}

- (NSData*)_stringToData:(NSString*)string
{
  return [string dataUsingEncoding:self.stringEncoding];
}

//------------------------------------------------------------------------------
#pragma mark NSObject
//------------------------------------------------------------------------------

- (NSString*)description
{
  NSMutableString *desc = [NSMutableString new];
  [desc appendFormat:@"Task with launchPath:%@", [self effectiveLaunchPath]];
  [desc appendFormat:@" arguments:'%@'", [[self effectiveArguments] componentsJoinedByString:@"' '"]];
  if ([self effectiveWorkingDirectory]) {
    [desc appendFormat:@" workingDirectory:%@", [self effectiveWorkingDirectory]];
  }
  return desc;
}

@end

//------------------------------------------------------------------------------
// ManagerInterface
//------------------------------------------------------------------------------

@implementation DSUnixTask (ManagerInterface)

- (void)taskDidLaunchWithProcessIdentifier:(int)processIdentifier;
{
  self.launched = TRUE;
  self.processIdentifier = processIdentifier;
  if (self.launchHandler) {
    dispatch_async(dispatch_get_main_queue(), ^{
      self.launchHandler(self);
    });
  }
}

- (void)taskDidFailToLaunchWithReason:(NSString*) failureReason;
{
  self.terminated = TRUE;
  if (self.failureHandler) {
    dispatch_async(dispatch_get_main_queue(), ^{
      self.launchFailureHandler(self, failureReason);
    });
  }
}

- (void)taskDidTerminateWithStatus:(int)terminationStatus;
{
  self.terminationStatus = terminationStatus;
  self.terminated = TRUE;
  if (terminationStatus <= self.minimumAcceptedTerminationStatus) {
    if (self.terminationHandler) {
      dispatch_async(dispatch_get_main_queue(), ^{
        self.terminationHandler(self);
      });
    }
  } else {
    if (self.failureHandler) {
      dispatch_async(dispatch_get_main_queue(), ^{
        self.failureHandler(self);
      });
    }
  }
}

- (void)taskDidReceiveStandardOutputData:(NSData*)data;
{
  NSString *newOutput = [self _dataToString:data];
  [self.standardOutput appendString:newOutput];
  if (self.standardOutputHandler) {
    dispatch_async(dispatch_get_main_queue(), ^{
      self.standardOutputHandler(self, newOutput);
    });
  }
}

- (void)taskDidReceiveStandardErrorData:(NSData*)data;
{
  NSString *newOutput = [self _dataToString:data];
  [self.standardError appendString:newOutput];
  if (self.standardErrorHandler) {
    dispatch_async(dispatch_get_main_queue(), ^{
      self.standardErrorHandler(self, newOutput);
    });
  }
}

- (NSArray*)dequeueStandardInput;
{
  NSMutableArray *queue = [NSMutableArray new];
  for (NSString *string in self.standardInputQueue) {
    [queue addObject:[self _stringToData:string]];
  }
  self.standardInputQueue = [NSMutableArray new];
  return queue;
}

@end
