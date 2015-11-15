//
//  CPSourceAggreagate.h
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 02/03/13.
//  Copyright (c) 2013 CocoaPods. MIT License.
//

#import <Foundation/Foundation.h>

@class CPSource;

/**
 Manages a collection of sources which reside in the same path.
*/
@interface CPSourceAggregate : NSObject

///-----------------------------------------------------------------------------
/// @name Initialization & Configuration
///-----------------------------------------------------------------------------

/**
 The path which contains the repos of the sources.
*/
@property (readonly) NSString *path;

/**
 The designated initializer.
*/
- (instancetype)initWithPath:(NSString*)path;

///-----------------------------------------------------------------------------
/// @name Sources Information
///-----------------------------------------------------------------------------

/**
 The list of all the known sources.
*/
@property (readonly) NSArray* sources;

/**
 All the sets which contain the information for each Pod.
*/
- (NSArray*)sets;

/**
 Returns the instance for the source with the given name.
*/
- (CPSource*)sourceWithName:(NSString*)name;

@end
