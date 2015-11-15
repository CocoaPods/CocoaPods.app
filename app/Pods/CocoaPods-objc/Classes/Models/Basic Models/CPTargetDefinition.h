//
//  CPTargetDefinition.h
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 28/02/13.
//  Copyright (c) 2013 CocoaPods. MIT License.
//

#import "CPProtoTargetDefinition.h"

@class CPDependency;

/**
 A target definition describes a the dependencies of Pod library which can be
 linked with one or more user targets.
 
 This class refines the behavior of it super class which is generated 
 automatically from the CocoaPods gem. Don't miss the attributes that it 
 exposes.
 
 See http://docs.cocoapods.org/podfile.html
 */
@interface CPTargetDefinition : CPProtoTargetDefinition

/**
 The descendant target definitions. Dunring an installation the target 
 definitions inherits the dependencies of the parent by default.

 The returned collection is mutable and clients can add, remove or sort target
 definitions.
 */
@property (readonly) NSMutableArray <CPTargetDefinition *>* children;

/**
 The dependencies of this target definition.

 The returned collection is mutable and clients can add, remove or sort 
 dependencies.
 */
@property (readonly) NSMutableArray <CPDependency *>* dependencies;

/**
 The name of the platform with which this target definition should link with
 (either `ios` or `osx`).
 */
- (NSString*)platformName;

/**
 The deployment target whith which this target definition should link with.
 */
- (NSString*)deploymentTarget;

/**
 Stores the platform and the deployment target for this library.
 */
- (void)setPlatformWithName:(NSString*)platform deploymentTarget:(NSString*)deploymentTarget;

@end

