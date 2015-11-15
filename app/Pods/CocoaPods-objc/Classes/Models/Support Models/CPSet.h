//
//  CPSet.h
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 28/02/13.
//  Copyright (c) 2013 CocoaPods. MIT License.
//

#import <Foundation/Foundation.h>

/**
 Describes a Pod. See Pod::Set.
 */
@interface CPSet : NSObject

///-----------------------------------------------------------------------------
/// @name Initialization & Configuration
///-----------------------------------------------------------------------------

/**
 The name of the Pod.
 */
@property (readonly) NSString *name;

/**
 The sources which contain the information for this set.
*/
@property (readonly) NSArray *sources;

/**
 The designated initializer.
 */
- (instancetype)initWithName:(NSString*)name sources:(NSArray*)sources;

///-----------------------------------------------------------------------------
/// @name Version information
///-----------------------------------------------------------------------------

/**
 All the versions of the Pod returned as objects and sorted from smallest to biggest.
 */
- (NSArray*)versions;

/**
 The source for the highest version. If more than one source contains the version the first one in alphabetical order wins.
 */
- (NSString*)sourceNameForVersion:(NSString*)version;

/**
 The highest version.
 */
- (NSString*)highestVersion;

/**
 The source for the highest version. If more than one source contains the version the first one in alphabetical order wins.
 */
- (NSString*)highestVersionSourceName;

///-----------------------------------------------------------------------------
/// @name Specifications
///-----------------------------------------------------------------------------

/**
 Returns the path of the specification for the given version.
*/
- (NSString*)specificationPathForVersion:(NSString*)version;

/**
 Returns the path of the most representative specification.
 */
- (NSString*)representativeSpecificationPath;

///-----------------------------------------------------------------------------
/// @name Search Information
///-----------------------------------------------------------------------------

/**
 The authors fo the Pod. See [CPSpecification authors].
 This information should be loaded either by `pod ipc list` or from the 
 representative specfication.
 */
@property NSArray *authors;

/**
*/
@property NSString *summary;

/**
*/
@property NSString *setDescription;

@end
