//
//  CPSet.m
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 28/02/13.
//  Copyright (c) 2013 CocoaPods. MIT License.
//

#import "CPSet.h"
#import "CPVersion.h"
#import "CPSource.h"

@implementation CPSet

///-----------------------------------------------------------------------------
#pragma mark - Initialization & Configuration
///-----------------------------------------------------------------------------

- (id)initWithName:(NSString *)name sources:(NSArray *)sources;
{
  self = [super init];
  if (self) {
    _name = name;
    _sources = sources;
  }
  return self;
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"<PODSet name:%@>", self.name];
}

///-----------------------------------------------------------------------------
#pragma mark - Version information
///-----------------------------------------------------------------------------

- (NSArray*)versions {
  NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: YES];
  NSArray *sortDescriptors = [NSArray arrayWithObject:sortOrder];
  NSArray *versionObjects = [self versionsAsObjects];
  return [versionObjects sortedArrayUsingDescriptors:sortDescriptors];
}

- (NSString *)highestVersion {
  return [[[self versions] lastObject] string];
}

- (NSString*)sourceNameForVersion:(NSString*)version {
  NSMutableArray *sourceNames = [NSMutableArray new];
  [[self versionsBySource] enumerateKeysAndObjectsUsingBlock:^(NSString *name, NSArray *versions, BOOL *stop) {
    if ([versions indexOfObject:version] != NSNotFound) {
      [sourceNames addObject:name];
    }
  }];
  NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: YES];
  NSArray *sortDescriptors = [NSArray arrayWithObject:sortOrder];
  return [[sourceNames sortedArrayUsingDescriptors:sortDescriptors] objectAtIndex:0];
}

- (NSString*)highestVersionSourceName {
  return [self sourceNameForVersion:[self highestVersion]];
}

///-----------------------------------------------------------------------------
/// @name Specifications
///-----------------------------------------------------------------------------

- (NSString*)specificationPathForVersion:(NSString*)version {
  NSString *sourceName = [self sourceNameForVersion:version];
  CPSource *source = [self sourceWithName:sourceName];
  NSString *specPath = [source specificationPathForPod:self.name withVersion:version];
  return specPath;
}

- (NSString*)representativeSpecificationPath {
  return [self specificationPathForVersion:[self highestVersion]];
}


///-----------------------------------------------------------------------------
#pragma mark - Private Helpers
///-----------------------------------------------------------------------------

/**
 Returns a dictionary where the keys are the names of the sources and the values
 are the version of the Pod which that source has.
 */
- (NSDictionary*)versionsBySource {
  NSMutableDictionary *result = [NSMutableDictionary new];
  [self.sources enumerateObjectsUsingBlock:^(CPSource *source, NSUInteger idx, BOOL *stop) {
    result[source.name] = [source versionsForPod:self.name];
  }];
  return result;
}

/**
 Returns the version as objects so they can be properly sorted.
 */
- (NSArray*)versionsAsObjects {
  NSMutableArray *result = [NSMutableArray new];
  [[self uniqueVersionStrings] enumerateObjectsUsingBlock:^(NSString *version, NSUInteger idx, BOOL *stop) {
    CPVersion *obj = [[CPVersion alloc] initWithString:version];
    [result addObject:obj];
  }];
  return result;
}

/**
 Returns the unique version as strings.
 */
- (NSArray*)uniqueVersionStrings {
  NSMutableArray *result = [NSMutableArray new];
  [self.versionsBySource enumerateKeysAndObjectsUsingBlock:^(CPSource *source, NSArray *versions, BOOL *stop) {
    [result addObjectsFromArray:versions];
  }];
  return [result valueForKeyPath:@"@distinctUnionOfObjects.self"];
}

- (CPSource*)sourceWithName:(NSString*)name {
  NSUInteger index = [self.sources indexOfObjectPassingTest:^BOOL(CPSource *source, NSUInteger idx, BOOL *stop) {
    return [source.name isEqualToString:name];
  }];
  if (index == NSNotFound) {
    return nil;
  } else {
    return self.sources[index];
  }
}


@end
