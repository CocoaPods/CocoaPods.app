//
//  DSDSUnixTaskLocalManager.m
//  DSUnixTask
//
//  Created by Fabio Pelosin on 05/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. All rights reserved.
//

#import "DSUnixTaskSubProcessManager.h"
#import "DSUnixTaskAbstractManager+SubclassesInterface.h"
#import "DSUnixTaskRunner.h"

@interface DSUnixTaskSubProcessManager () <DSUnixTaskManagerConcreteInstance, DSUnixTaskRunnerDelegate>

@property NSMutableDictionary *taskRunnersByIdentifier;

@end

@implementation DSUnixTaskSubProcessManager

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
    _taskRunnersByIdentifier = [NSMutableDictionary new];
  }
  return self;
}

//------------------------------------------------------------------------------
#pragma mark DSUnixTaskManagerConcreteInstance
//------------------------------------------------------------------------------

- (void)concreteLaunchTask:(DSUnixTask*)task;
{
  DSUnixTaskRunner *taskRunner = [[DSUnixTaskRunner alloc] initWithLaunchPath:[task effectiveLaunchPath] arguments:[task effectiveArguments]];
  [taskRunner setWorkingDirectory: [task effectiveWorkingDirectory]];
  [taskRunner setEnvironment: [task effectiveEnvironment]];
  [taskRunner setDelegate:self];
  int processIdentifier = [taskRunner launch];
  if (processIdentifier) {
    [task taskDidLaunchWithProcessIdentifier:processIdentifier];
    NSString *key = [self keyForProcessIdentifier:processIdentifier];
    self.taskByProcessIdentifier[key] = task;
    [self logGood:@"%@ Did launch (Local)", [self taskToLog:task]];
    self.taskRunnersByIdentifier[[NSNumber numberWithInt:processIdentifier]] = taskRunner;
  } else {
    [task taskDidFailToLaunchWithReason:taskRunner.launchExceptionReason];
    [self logBad:@"%@ Did fail to launch (Local) - %@", [self taskToLog:task], taskRunner.launchExceptionReason];
  }
}

- (void)concreteWriteDataToStandardInput:(NSData *)data ofTask:(DSUnixTask *)task
{
  DSUnixTaskRunner *taskRunner = self.taskRunnersByIdentifier[[NSNumber numberWithInt:task.processIdentifier]];
  [taskRunner writeDataToStandardInput:data];
}

- (void)concreteSendEOFToStandardInputOfTask:(DSUnixTask*)task;
{
  DSUnixTaskRunner *taskRunner = self.taskRunnersByIdentifier[[NSNumber numberWithInt:task.processIdentifier]];
  [taskRunner sendEOFToStandardInput];
}

- (BOOL)concretePrepareToWriteToStandardInput:(DSUnixTask*)task;
{
  return YES;
}

//------------------------------------------------------------------------------
#pragma mark DSUnixTaskRunnerDelegate
//------------------------------------------------------------------------------

- (void)taskRunner:(DSUnixTaskRunner*)taskRunner didReceiveStandardOutputData:(NSData*)data;
{
  [self taskWithIdentifier:taskRunner.processIdentifier didReceiveStandardOutputData:data];
}

- (void)taskRunner:(DSUnixTaskRunner*)taskRunner didReceiveStandardErrorData:(NSData*)data;
{
  [self taskWithIdentifier:taskRunner.processIdentifier didReceiveStandardErrorData:data];
}

- (void)taskRunnerDidTerminate:(DSUnixTaskRunner *)taskRunner withStatus:(int)terminationStatus;
{
  [self taskWithIdentifier:taskRunner.processIdentifier didTerminateWithStatus:terminationStatus];
}


@end
