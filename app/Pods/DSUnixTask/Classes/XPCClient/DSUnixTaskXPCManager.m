//
//  DSUnixTaskConnectionManager.m
//  DSUnixTask
//
//  Created by Fabio Pelosin on 05/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. MIT License.
//

#import "DSUnixTaskXPCManager.h"
#import "DSUnixTaskAbstractManager+SubclassesInterface.h"

@interface DSUnixTaskXPCManager () <DSUnixTaskManagerConcreteInstance>

/*
 Whether the connection was interrupted.
 */
@property BOOL connectionInterrupted;

@end

@implementation DSUnixTaskXPCManager

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

//------------------------------------------------------------------------------
#pragma mark DSUnixTaskManagerConcreteInstance
//------------------------------------------------------------------------------

- (void)concreteLaunchTask:(DSUnixTask*)task;
{
  [self _openConnectionIfNeeded];
  [self.serviceProxy launchProccessWithPath:[task effectiveLaunchPath]
                                  arguments:[task effectiveArguments]
                           workingDirectory:[task effectiveWorkingDirectory]
                                environment:[task effectiveEnvironment]
                                     result:^(int processIdentifier, NSString *lauchExceptionReason)
   {
     if (processIdentifier) {
       int oldProcessIdentifier = task.processIdentifier;
       [task taskDidLaunchWithProcessIdentifier:processIdentifier];
       NSString *key = [self keyForProcessIdentifier:processIdentifier];
       self.taskByProcessIdentifier[key] = task;
       [self logGood:@"%@ Did launch (XPC)", [self taskToLog:task]];
       if (oldProcessIdentifier) {
         [self _sendPendingInputForTask:task];
         NSString *oldKey = [self keyForProcessIdentifier:oldProcessIdentifier];
         [self.taskByProcessIdentifier removeObjectForKey:oldKey];
       }
     } else {
       [task taskDidFailToLaunchWithReason:lauchExceptionReason];
       [self logBad:@"%@ Did fail to launch (XPC)- %@", [self taskToLog:task], lauchExceptionReason];
     }
   }];
}

- (void)concreteWriteDataToStandardInput:(NSData *)data ofTask:(DSUnixTask *)task
{
  [self.serviceProxy writeDataToStandardInput:data ofProcessWithIdentifier:task.processIdentifier];
}

- (void)concreteSendEOFToStandardInputOfTask:(DSUnixTask*)task;
{
  [self.serviceProxy sendEOFToStandardInputofProcessWithIdentifier:task.processIdentifier];
}


- (BOOL)concretePrepareToWriteToStandardInput:(DSUnixTask *)task
{
  if (!task.processIdentifier) {
    return FALSE;
  } else if (self.connectionInterrupted) {
    [self _reEstablishConnection];
    return FALSE;
  }
  return TRUE;
}

//------------------------------------------------------------------------------
#pragma mark Connection
//------------------------------------------------------------------------------

- (void)openConnection;
{
  self.connectionClient = [DSUnixTaskClient new];
  [self.connectionClient setDelegate:self];

  NSXPCInterface *serviceInterface = [NSXPCInterface interfaceWithProtocol:@protocol(DSUnixTaskServiceInterface)];
  self.connection = [[NSXPCConnection alloc] initWithServiceName:self.serviceBundleIdentifier];
  self.connection.remoteObjectInterface = serviceInterface;
  self.connection.exportedInterface = [NSXPCInterface interfaceWithProtocol:@protocol(DSUnixTaskClientInterface)];
  self.connection.exportedObject = self.connectionClient;

  __weak DSUnixTaskXPCManager* weakSelf = self;
  self.connection.invalidationHandler = ^{
    [weakSelf logBad:@"Connection invalidated - cannot be re-established."];
  };

  self.connection.interruptionHandler = ^{
    [weakSelf setConnectionInterrupted:TRUE];
    [weakSelf logBad:@"Connection interrupted - should be re-established whe needed."];
  };

  [self.connection resume];
  self.serviceProxy = [self.connection remoteObjectProxy];
}

//------------------------------------------------------------------------------
#pragma mark Private Helpers
//------------------------------------------------------------------------------

- (void)_openConnectionIfNeeded;
{
  if (!self.connection) {
    [self openConnection];
  }
}

/*
 The XPC service might be terminated by the system or crash.

 A connection can be reinitialized just sending a message. However the process
 would have been killed so it is necessary to relaunch them. This behaviour is
 intended for tools which are used as daemons which receive standard input and
 process it.

 Task which need to keep state are not suitable for the XPC architecture as
 state can be lost at any time.
 */
- (void)_reEstablishConnection;
{
  if (self.connectionInterrupted) {
    for (DSUnixTask *task in [self.taskByProcessIdentifier allValues]) {
      [self launchTask:task];
    }
    self.connectionInterrupted = FALSE;
  }
}

/*
 Clears the standard input queue for the given task and sends it.
 */
- (void)_sendPendingInputForTask:(DSUnixTask*)task
{
  NSArray *queue = [task dequeueStandardInput];
  for (NSData *data in queue) {
    [self writeDataToStandardInput:data ofTask:task];
  };
}


@end
