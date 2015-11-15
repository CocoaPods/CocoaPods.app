//
//  CPSpecification.h
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 28/02/13.
//  Copyright (c) 2013 CocoaPods. MIT License.
//

#import "CPProtoSpecification.h"

/**
  A specification describes a version of Pod library. It includes
  details about where the source should be fetched from, what files to use, the
  build settings to apply, and other general metadata such as its name, version,
  and description.
 
  This class refines the behavior of it super class which is generated
  automatically from the CocoaPods gem. Don't miss the attributes that it
  exposes.

  See http://docs.cocoapods.org/specification.html
*/
@interface CPSpecification : CPProtoSpecification

/**
  The file in which the specification is stored.
*/
@property NSString *definedInFile;

/**
 Returns the type of the license.
 */
- (NSString*)licenseType;

/**
 The targets definitions (CPTargetDefinition) of the Podfile.

 The collection is mutable and clients can add, remove or sort target
 definitions.
 */
@property (readonly) NSMutableArray* subspecs;

/**
 The iOS specific values (This is a stub).
 */
-(NSDictionary *)iosAttributes;

/**
 The iOS specific values (This is a stub).
 */
-(NSDictionary *)osxAttributes;

@end



