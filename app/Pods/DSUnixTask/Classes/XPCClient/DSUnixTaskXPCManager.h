//
//  DSUnixTaskConnectionManager.h
//  DSUnixTask
//
//  Created by Fabio Pelosin on 05/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. MIT License.
//

#import "DSUnixTaskAbstractManager.h"
#import "DSUnixTaskInterfaces.h"
#import "DSUnixTaskClient.h"

/**
 Manages the connection with XPC Services opening and resuming it when needed.
 It also is responsible of dispatching the messages from the connection to the
 appropriate DSUnixTask instance.
 */
@interface DSUnixTaskXPCManager : DSUnixTaskAbstractManager

///-----------------------------------------------------------------------------
/// @name Initialization & Configuration
///-----------------------------------------------------------------------------

/**
 The shared instance.
 */
+ (instancetype)sharedManager;

///-----------------------------------------------------------------------------
/// @name Connection
///-----------------------------------------------------------------------------

/**
 The bundle identifier of the XPC service. To be set before launching the first task.
 */
@property NSString * serviceBundleIdentifier;

- (void)openConnection;

/**
 The XPC connection.
 */
@property NSXPCConnection * connection;

/**
 The proxy of the XPC service.
 */
@property id<DSUnixTaskServiceInterface> serviceProxy;

/**
 The object exported to the XPC connection
 */
@property DSUnixTaskClient * connectionClient;

@end



