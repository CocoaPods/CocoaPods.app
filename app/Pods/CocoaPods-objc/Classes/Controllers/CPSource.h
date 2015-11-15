//
//  CPSource.h
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 02/03/13.
//  Copyright (c) 2013 CocoaPods. MIT License.
//

#import <Foundation/Foundation.h>

/**
 Provides the information about the Pods of a given repo. This class mimics
 the Pod::Source class.
 */
@interface CPSource : NSObject

///-----------------------------------------------------------------------------
/// @name Initialization & Configuration
///-----------------------------------------------------------------------------

/**
 The path of this source.
 */
@property (readonly) NSString *repoPath;

/**
 The designated initializer.
 */
- (instancetype)initWithRepoPath:(NSString*)repoPath;

///-----------------------------------------------------------------------------
/// @name Pods information
///-----------------------------------------------------------------------------

/**
 The name of the source.
 */
-(NSString*)name;

/**
 The list of the names of all the Pods known to CocoaPods.
 */
- (NSArray*)pods;

/**
 The list of the versions for the Pod with the given name.
 */
- (NSArray*)versionsForPod:(NSString*)name;

///-----------------------------------------------------------------------------
/// @name Specifications
///-----------------------------------------------------------------------------

/**
 The path of the specification for the Pod with the given name.
 */
- (NSString*)specificationPathForPod:(NSString*)pod withVersion:(NSString*)version;

///-----------------------------------------------------------------------------
/// @name CocoaPods versions
///-----------------------------------------------------------------------------

/**
*/
- (NSString*)lastKnownVersion;

/**
*/
- (NSString*)minimunRequiredVersion;

@end
