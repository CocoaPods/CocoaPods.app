//
//  DSUnixTaskAbstractManager.m
//  DSUnixTask
//
//  Created by Fabio Pelosin on 05/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. All rights reserved.
//

#import "DSUnixTaskAbstractManager.h"
#import "DSUnixTaskAbstractManager+SubclassesInterface.h"

// This is not implemented on purpose.
@interface DSUnixTaskAbstractManager (ConcreteStub) <DSUnixTaskManagerConcreteInstance> @end

@implementation DSUnixTaskAbstractManager

//------------------------------------------------------------------------------
#pragma mark Initialization & Configuration
//------------------------------------------------------------------------------

+ (instancetype)sharedManager;
{
  static id _sharedInstance;
  if (_sharedInstance == nil) {
    _sharedInstance = [[self alloc] init];
  }
  return _sharedInstance;
}

- (id)init
{
  self = [super init];
  if (self) {
    _taskByProcessIdentifier = [NSMutableDictionary new];
  }
  return self;
}

//------------------------------------------------------------------------------
#pragma mark Creating Tasks
//------------------------------------------------------------------------------

- (DSUnixTask*)task;
{
  return [[DSUnixTask alloc] initWithManager:self];
}

+ (DSUnixTask*)task;
{
  return [[DSUnixTask alloc] initWithManager:[self sharedManager]];
}

- (DSUnixShellTask*)shellTask;
{
  return [[DSUnixShellTask alloc] initWithManager:self];
}

+ (DSUnixShellTask*)shellTask;
{
  return [[DSUnixShellTask alloc] initWithManager:[self sharedManager]];
}

//------------------------------------------------------------------------------
#pragma mark Tasks Interface
//------------------------------------------------------------------------------

- (void)taskWithIdentifier:(int)processIdentifier didTerminateWithStatus:(int)terminationStatus;
{
  DSUnixTask *task = [self taskWithProcessIdentifier:processIdentifier];
  [self log:@"%@ * Did terminate: %d", [self taskToLog:task], processIdentifier];
  [task taskDidTerminateWithStatus:terminationStatus];
  [self.taskByProcessIdentifier removeObjectForKey:[NSNumber numberWithInt:processIdentifier]];
}

- (void)taskWithIdentifier:(int)processIdentifier didReceiveStandardOutputData:(NSData*)data;
{
  DSUnixTask *task = [self taskWithProcessIdentifier:processIdentifier];
  [self log:@"%@ > Standard output: %@", [self taskToLog:task], [self dataToString:data]];
  [task taskDidReceiveStandardOutputData:data];
}

- (void)taskWithIdentifier:(int)processIdentifier didReceiveStandardErrorData:(NSData*)data;
{
  DSUnixTask *task = [self taskWithProcessIdentifier:processIdentifier];
  [self log:@"%@ ! Standard error: %@", [self taskToLog:task], [self dataToString:data]];
  [task taskDidReceiveStandardErrorData:data];
}

//------------------------------------------------------------------------------
#pragma mark Private Helpers
//------------------------------------------------------------------------------

/**
 Returns the task with the given process identifier.
 */
- (DSUnixTask*)taskWithProcessIdentifier:(int)processIdentifier;
{
  NSString *key = [self keyForProcessIdentifier:processIdentifier];
  return self.taskByProcessIdentifier[key];
}

@end

//------------------------------------------------------------------------------
// PrivateInterface
//------------------------------------------------------------------------------

@implementation DSUnixTaskAbstractManager (SubclassesInterface)

- (void)log:(NSString*)format, ... NS_FORMAT_FUNCTION(1,2);
{
  if (self.loggingEnabled) {
    va_list argList;
    va_start(argList, format);
    NSString *log = [[NSString alloc] initWithFormat:format arguments:argList];
    NSLog(@"%@", log);
  }
}

/*
 Just toying around.
 */
- (void)logGood:(NSString*)format, ... NS_FORMAT_FUNCTION(1,2);
{
  va_list argList;
  va_start(argList, format);
  NSString *log = [[NSString alloc] initWithFormat:format arguments:argList];
  [self log:@"✅ %@", log];
}

/*
 Just toying around.
 */
- (void)logBad:(NSString*)format, ... NS_FORMAT_FUNCTION(1,2);
{
  va_list argList;
  va_start(argList, format);
  NSString *log = [[NSString alloc] initWithFormat:format arguments:argList];
  [self log:@"⛔ %@", log];
}

/*
 Example: [irb:19722]
 */
- (NSString*)taskToLog:(DSUnixTask *)task;
{
  return [NSString stringWithFormat:@"[%@:%d]", task.name, task.processIdentifier];
}

/*
 Assumes NSUTF8StringEncoding.
 */
- (NSString*)dataToString:(NSData *)data;
{
  return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

/*
 Convets a process identifier to string.
 */
- (NSString*)keyForProcessIdentifier:(int)processIdentifier
{
  return [NSString stringWithFormat:@"%d", processIdentifier];
}

@end

//------------------------------------------------------------------------------
// TaskInterface
//------------------------------------------------------------------------------

@implementation DSUnixTaskAbstractManager (TaskInterface)

- (void)launchTask:(DSUnixTask*)task;
{
  [self log:@"Launching %@", [task description]];
  [self concreteLaunchTask:task];
}

- (BOOL)prepareToWriteToStandardInput:(DSUnixTask*)task;
{
  return [self concretePrepareToWriteToStandardInput:task];
}

- (void)writeDataToStandardInput:(NSData*)data ofTask:(DSUnixTask*)task;
{
  [self log:@" %@ < Standard input: %@", [self taskToLog:task], [self dataToString:data]];
  [self concreteWriteDataToStandardInput:data ofTask:task];
}

- (void)sendEOFToStandardInputOfTask:(DSUnixTask*)task;
{
  [self log:@" %@ < EOF (^D) Sent to standard input", [self taskToLog:task]];
  [self concreteSendEOFToStandardInputOfTask:task];
}


@end



