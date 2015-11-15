//
//  DSUnixTaskRunner.m
//
//  Created by Fabio Pelosin on 02/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. MIT License.
//

#import "DSUnixTaskRunner.h"

@interface DSUnixTaskRunner ()

/*
 The task for this instance.
 */
@property NSTask *task;

/*
 Whether the task has been launched.
 */
@property BOOL launched;

@property (readwrite) NSString* launchExceptionReason;

@end

@implementation DSUnixTaskRunner

//------------------------------------------------------------------------------
#pragma mark Initialization & Configuration
//------------------------------------------------------------------------------

- (instancetype)initWithLaunchPath:(NSString*)launchPath arguments:(NSArray *)arguments;
{
  self = [super init];
  if (self) {
    _launchPath = launchPath;
    _arguments = arguments;
  }
  return self;
}

/*
 Use the designated initializer.
 */
- (id)init;
{
  [NSException raise:@"Unsupported initializer" format:nil];
  return nil;
}

//------------------------------------------------------------------------------
#pragma mark Executing Tasks
//------------------------------------------------------------------------------

/*
 NSTask is raise happy!
 */
- (int)launch;
{
  if (self.launched) {
    [NSException raise:@"Attempt to relaunch task" format:nil];
    return 0;
  }
  [self setLaunched:TRUE];
  [self setTask:[self _task]];
  int processIdentifier;
  @try {
    [self.task launch];
    [self _setupTaksHandles];
    processIdentifier = self.task.processIdentifier;
  }
  @catch (NSException *exception) {
    [self setTask:nil];
    processIdentifier = 0;
    self.launchExceptionReason = exception.reason;
  }
  return processIdentifier;
}

/*
 The task is nil if not launched so it returns 0.
 */
- (int)processIdentifier
{
  return self.task.processIdentifier;
}

/*
 The task is nil if not launched so it won't raise.
 */
- (void)interrupt;
{
  [self.task interrupt];
}

/*
 The task is nil if not launched so it won't raise.
 */
- (void)terminate;
{
  [self.task terminate];
}

- (void)writeDataToStandardInput:(NSData*)data;
{
  NSFileHandle *fileHandle = [self.task.standardInput fileHandleForWriting];
  [fileHandle writeData:data];
}

- (void)sendEOFToStandardInput;
{
  NSFileHandle *fileHandle = [self.task.standardInput fileHandleForWriting];
  [fileHandle closeFile];
}

//------------------------------------------------------------------------------
#pragma mark Private helpers
//------------------------------------------------------------------------------

/*
 Returns the configured task.
 */
- (NSTask *)_task;
{
  NSMutableDictionary *environment = [[[NSProcessInfo processInfo] environment] mutableCopy];
  [environment addEntriesFromDictionary:self.environment];

  NSTask *task = [[NSTask alloc] init];
  [task setLaunchPath:self.launchPath];
  [task setEnvironment: environment];
  [task setArguments:self.arguments];
  [task setStandardInput:[NSPipe pipe]];
  [task setStandardOutput:[NSPipe pipe]];
  [task setStandardError:[NSPipe pipe]];
  if (self.workingDirectory) {
    [task setCurrentDirectoryPath:[self.workingDirectory stringByStandardizingPath]];
  }
  return task;
}

/*
 Forward the task handles to the client proxy.
 */
- (void)_setupTaksHandles
{
  id<DSUnixTaskRunnerDelegate> delegate = self.delegate;
  __weak DSUnixTaskRunner* weakSelf = self;

  [self _observePipe:self.task.standardOutput usingBlock:^(NSData *data) {
    [delegate taskRunner:weakSelf didReceiveStandardOutputData:data];
  }];

  [self _observePipe:self.task.standardError usingBlock:^(NSData *data) {
    [delegate taskRunner:weakSelf didReceiveStandardErrorData:data];
  }];

  [self.task setTerminationHandler:^(NSTask *nsTask) {
    [delegate taskRunnerDidTerminate:weakSelf withStatus:nsTask.terminationStatus];
    [nsTask.standardOutput fileHandleForReading].readabilityHandler = nil;
    [nsTask.standardError fileHandleForReading].readabilityHandler = nil;
  }];
}

/*
 Sets the readability handle of the given pipe with the given block.
 */
- (void)_observePipe:(NSPipe*)pipe usingBlock:(void (^)(NSData *data))block;
{
  [[pipe fileHandleForReading] setReadabilityHandler:^(NSFileHandle *fileHandle) {
    NSData *data = [fileHandle availableData];
    if([data length] > 0) {
      block(data);
    }
  }];
}


@end
