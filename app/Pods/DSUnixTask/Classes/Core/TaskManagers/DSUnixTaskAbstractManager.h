//
//  DSUnixTaskAbstractManager.h
//  DSUnixTask
//
//  Created by Fabio Pelosin on 05/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSUnixTaskInterfaces.h"
#import "DSUnixTask.h"
#import "DSUnixShellTask.h"

@interface DSUnixTaskAbstractManager : NSObject <DSUnixTaskClientInterface>

/**
 Whether logging is enabled.
 */
@property BOOL loggingEnabled;

///-----------------------------------------------------------------------------
/// @name Tasks
///-----------------------------------------------------------------------------

/**
 Makes a new task passing self as the manager.
 */
- (DSUnixTask*)task;

/**
 Makes a new task passing the shared instance as the manager.
 */
+ (DSUnixTask*)task;

/**
 Makes a new task passing self as the manager.
 */
- (DSUnixShellTask*)shellTask;

/**
 Makes a new task passing the shared instance as the manager.
 */
+ (DSUnixShellTask*)shellTask;

/*
 The task instances stored by process identifier.
 */
@property NSMutableDictionary *taskByProcessIdentifier;

@end

