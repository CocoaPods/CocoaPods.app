//
//  DSUnixTaskPrivate.h
//  DSUnixTask
//
//  Created by Fabio Pelosin on 06/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. All rights reserved.
//

/**
 The protocol that the task class needs to adopt to receive the notification
 originating from the Task Manager.
 */
@interface DSUnixTask (ManagerInterface)

/**
 Informs the receiver that it launched successfully.
 */
- (void)taskDidLaunchWithProcessIdentifier:(int)processIdentifier;

/**
 Informs the receiver that it failed to launch.
 */
- (void)taskDidFailToLaunchWithReason:(NSString*) failureReason;

/**
 Informs the receiver that it was terminated.
 */
- (void)taskDidTerminateWithStatus:(int)terminationStatus;

/**
 Informs the receiver that it received standard output data.
 */
- (void)taskDidReceiveStandardOutputData:(NSData*)data;

/**
 Informs the receiver that it received standard error data.
 */
- (void)taskDidReceiveStandardErrorData:(NSData*)data;

/*
 Returns the standard input queue (as NSData) from the receiver and clears it.
 */
- (NSArray*)dequeueStandardInput;

@end
