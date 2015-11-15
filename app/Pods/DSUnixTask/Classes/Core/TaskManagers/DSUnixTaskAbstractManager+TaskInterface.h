//
//  DSUnixTaskAbstractManager+TaskInterface.h
//  DSUnixTask
//
//  Created by Fabio Pelosin on 06/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. All rights reserved.
//

#import "DSUnixTaskAbstractManager.h"

@interface DSUnixTaskAbstractManager (TaskInterface)

/**
 Spins up the XPC service if needed and launches the task runner. Once the services
 responds the task is appropriately notified.

 Called by a task passing itself as an argument.
 */
- (void)launchTask:(DSUnixTask*)task;

/**
 Tells the manager that the task has standard input data. The manager returns
 whether it is ready or not. If the manager is not ready the task should
 queue the data. As soon manager will be ready it will
 Whether given task can write to standard input or it should queue the data.
 */
- (BOOL)prepareToWriteToStandardInput:(DSUnixTask*)task;

/**
 Sends standard input to the task.

 Called by a task forwarding the data that it needs to send to standard input.
 */
- (void)writeDataToStandardInput:(NSData*)data ofTask:(DSUnixTask*)task;

/**
 Sends the EOF to the five with the given standard input.
 */
- (void)sendEOFToStandardInputOfTask:(DSUnixTask*)task;

@end
