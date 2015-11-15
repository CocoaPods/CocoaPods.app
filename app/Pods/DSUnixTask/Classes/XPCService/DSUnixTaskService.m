//
//  DSUnixTaskService.m
//
//  Created by Fabio Pelosin on 04/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. MIT License.
//

#import "DSUnixTaskService.h"
#import "DSUnixTaskRunner.h"

@interface DSUnixTaskService () <DSUnixTaskRunnerDelegate>

@property NSMutableDictionary *taskRunnersByIdentifier;

@end

@implementation DSUnixTaskService

//------------------------------------------------------------------------------
#pragma mark Initialization & Configuration
//------------------------------------------------------------------------------

- (id)init
{
  self = [super init];
  if (self) {
    _taskRunnersByIdentifier = [NSMutableDictionary new];
  }
  return self;
}

//------------------------------------------------------------------------------
#pragma mark DSUnixTaskServiceInterface
//------------------------------------------------------------------------------

/*
 Creates a new launcher for every task.
 */
- (void)launchProccessWithPath:(NSString*)launchPath
                     arguments:(NSArray *)arguments
              workingDirectory:(NSString *)workingDirectory
                   environment:(NSDictionary*)environment
                        result:(void (^)(int processIdentifier, NSString* lauchExceptionReason))result;
{
  DSUnixTaskRunner *taskRunner = [[DSUnixTaskRunner alloc] initWithLaunchPath:launchPath arguments:arguments];
  [taskRunner setWorkingDirectory: workingDirectory];
  [taskRunner setEnvironment: environment];
  [taskRunner setDelegate:self];
  int processIdentifier = [taskRunner launch];
  if (processIdentifier) {
    self.taskRunnersByIdentifier[[NSNumber numberWithInt:processIdentifier]] = taskRunner;
    result(processIdentifier, nil);
  } else {
    result(0, taskRunner.launchExceptionReason);
  }
}

- (void)writeDataToStandardInput:(NSData *)data ofProcessWithIdentifier:(int)processIdentifier;
{
  DSUnixTaskRunner *taskRunner = self.taskRunnersByIdentifier[[NSNumber numberWithInt:processIdentifier]];
  [taskRunner writeDataToStandardInput:data];
}

- (void)sendEOFToStandardInputofProcessWithIdentifier:(int)processIdentifier;
{
  DSUnixTaskRunner *taskRunner = self.taskRunnersByIdentifier[[NSNumber numberWithInt:processIdentifier]];
  [taskRunner sendEOFToStandardInput];
}

//------------------------------------------------------------------------------
#pragma mark DSUnixTaskRunnerDelegate
//------------------------------------------------------------------------------

- (void)taskRunner:(DSUnixTaskRunner*)taskRunner didReceiveStandardOutputData:(NSData*)data;
{
  [self.clientProxy taskWithIdentifier:taskRunner.processIdentifier didReceiveStandardOutputData:data];
}

- (void)taskRunner:(DSUnixTaskRunner*)taskRunner didReceiveStandardErrorData:(NSData*)data;
{
  [self.clientProxy taskWithIdentifier:taskRunner.processIdentifier didReceiveStandardErrorData:data];
}

- (void)taskRunnerDidTerminate:(DSUnixTaskRunner *)taskRunner withStatus:(int)terminationStatus;
{
  [self.clientProxy taskWithIdentifier:taskRunner.processIdentifier didTerminateWithStatus:terminationStatus];
  [self.taskRunnersByIdentifier removeObjectForKey:[NSNumber numberWithInt:taskRunner.processIdentifier]];
}

@end
