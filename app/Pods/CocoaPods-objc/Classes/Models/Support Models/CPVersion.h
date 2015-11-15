//
//  CPVersion.h
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 01/03/13.
//  Copyright (c) 2013 CocoaPods. MIT License.
//

#import <Foundation/Foundation.h>

/**
 Describes a semantic version. See Pod::Version.
 */
@interface CPVersion : NSObject

///-----------------------------------------------------------------------------
/// @name Initialization & Configuration
///-----------------------------------------------------------------------------

/**
 The string presentation of the version
 */
@property NSString *string;

/**
 The designated initializer.
 */
- (id)initWithString:(NSString*)string;

///-----------------------------------------------------------------------------
/// @name Sorting
///-----------------------------------------------------------------------------

/**
 Allows to sort versions taking into account the segments.
 */
- (NSComparisonResult)compare:(CPVersion *)other;

/**
 The segments which compose the version. Each segment can be either an integer value or a string. Integer values sorted numerically while strings are sorted alphabetically.
 */
@property NSArray *segments;

@end
