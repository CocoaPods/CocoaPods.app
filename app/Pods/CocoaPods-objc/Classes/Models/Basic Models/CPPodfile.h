//
//  CPPodfile.h
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 28/02/13.
//  Copyright (c) 2013 CocoaPods. MIT License.
//

#import "CPProtoPodfile.h"

/**
 The Podfile is a specification which describes the dependencies of one or more
 Target definitions.

 This class refines the behavior of it super class which is generated
 automatically from the CocoaPods gem. Don't miss the attributes that it
 exposes.
 
 See http://docs.cocoapods.org/podfile.html
 */
@interface CPPodfile : CPProtoPodfile

/**
 The targets definitions (CPTargetDefinition) of the Podfile. 
 
 The collection is mutable and clients can add, remove or sort target 
 definitions.
 */
@property (readonly) NSMutableArray* targetDefinitions;

@end

