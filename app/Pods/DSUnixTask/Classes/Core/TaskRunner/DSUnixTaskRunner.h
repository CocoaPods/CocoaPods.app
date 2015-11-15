//
//  DSUnixTaskRunner.h
//
//  Created by Fabio Pelosin on 02/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. MIT License.
//

#import <Foundation/Foundation.h>
#import "DSUnixTaskInterfaces.h"

@protocol DSUnixTaskRunnerDelegate;

/**
  This class is responsible to launch a task and manage its pipes. The task
 is manages in an async fashion and when a notification is received it is 
 forwarded to the delegate.
*/
@interface DSUnixTaskRunner : NSObject

///-----------------------------------------------------------------------------
/// @name Initialization & Configuration
///-----------------------------------------------------------------------------

/**
 The launch path of the executable.
 */
@property NSString* launchPath;

/**
 The arguments to pass to the executable.
 */
@property NSArray* arguments;

/**
 The designated initializer.
 
 @param launchPath The launch path of the executable.
 @param arguments  The arguments to pass to the executable.
 */
- (instancetype)initWithLaunchPath:(NSString*)launchPath
                         arguments:(NSArray *)arguments;

/**
 The working directory of the executable.
 */
@property NSString* workingDirectory;

/**
 The environment to pass to the task.
 */
@property NSDictionary *environment;

/**
 The proxy for the XPC client.
 */
@property (weak) id<DSUnixTaskRunnerDelegate> delegate;

///-----------------------------------------------------------------------------
/// @name Running Tasks
///-----------------------------------------------------------------------------

/**
 Launches the task.
 */
- (int)launch;

/**
 The process identifier of the task. This value is zero if the process fails to launch or has not been launched yet.
 */
- (int)processIdentifier;

/**
 If the task fails to launch the property contains the exception.
 */
@property (readonly) NSString* launchExceptionReason;

/**
 Interrupts the task. Not always possible. Sends `SIGINT`.
 */
- (void)interrupt;

/**
 Terminates the task. Not always possible. Sends `SIGTERM`.
 */
- (void)terminate;

/**
 Sends standard input to the task.
 */
- (void)writeDataToStandardInput:(NSData*)data;

/**
 Closes the standard input pipe.
 */
- (void)sendEOFToStandardInput;

@end

///-----------------------------------------------------------------------------
/// @name Delegate
///-----------------------------------------------------------------------------

/**
 The protocol of the DSUnixTastRunner. This protocol takes into account the 
 constraints of XPC messaging.
 */
@protocol DSUnixTaskRunnerDelegate <NSObject>

@required

- (void)taskRunner:(DSUnixTaskRunner*)taskRunner didReceiveStandardOutputData:(NSData*)data;

- (void)taskRunner:(DSUnixTaskRunner*)taskRunner didReceiveStandardErrorData:(NSData*)data;

- (void)taskRunnerDidTerminate:(DSUnixTaskRunner *)task withStatus:(int)terminationStatus;

@end

