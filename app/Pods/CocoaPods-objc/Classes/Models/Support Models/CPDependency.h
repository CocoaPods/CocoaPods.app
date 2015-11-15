//
//  CPDependency.h
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 07/03/13.
//  Copyright (c) 2013 CocoaPods. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPDependency : NSObject

/**
 *  Helper initializer that will parse a name, requirements, and attributes
 *  from the object that we get from parsing a YAML representation of a
 *  Podfile.
 *
 *  @param value the YAML object
 *
 *  @return a CPDependency if we had a valid YAML value, else `nil`
 */
+ (instancetype)fromYAMLValue:(id)value;

/**
 *  Initialize a Dependency.
 *
 *  @param name       the name of the dependency, e.g. `AFNetworking`
 *  @param requirements   an array of version requirement strings
 *  @param attributes a dictionary of attributes (e.g. for git/branch dependencies)
 *
 *  @return an initialized `CPDependency`
 */
- (instancetype)initWithName:(NSString*)name requirements:(NSArray*)requirements attributes:(NSDictionary*)attributes;

@property (readonly) NSString *name;
@property (readonly) NSArray<NSString *> *requirements;
@property (readonly) NSDictionary<NSString *, NSString *> *attributes;

@end
