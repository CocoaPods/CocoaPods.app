//
//  CPTargetDefinition.m
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 28/02/13.
//  Copyright (c) 2013 CocoaPods. MIT License.
//

#import "CPTargetDefinition.h"
#import "CPDictionaryBackedObject+Private.h"
#import "CPDependency.h"

@interface CPTargetDefinition ()
@property (readwrite) NSMutableArray* children;
@property (readwrite) NSMutableArray* dependencies;
@end

//------------------------------------------------------------------------------

@implementation CPTargetDefinition

//------------------------------------------------------------------------------
#pragma mark - CPDictionaryBackedObject
//------------------------------------------------------------------------------

/**
 Converts the target definition to their object representation and stores them
 in a mutable array. The information is removed from the backing store and
 merged back when needed.
 */
- (instancetype)initWithBackingStore:(NSMutableDictionary *)backingStore {
  self = [super initWithBackingStore:backingStore];

  NSArray *childDictionaries = [self backingStoreValueForKey:kCPTargetDefinitionChildrenAttributeKey];
  NSMutableArray *children = [NSMutableArray new];
  [childDictionaries enumerateObjectsUsingBlock:^(NSDictionary *targetDefinition, NSUInteger idx, BOOL *stop) {
    [children addObject:[[CPTargetDefinition alloc] initWithDictionary:targetDefinition]];
  }];
  [self setChildren:children];
  [self setBackingStoreValue:nil forKey:kCPTargetDefinitionChildrenAttributeKey];

  NSArray *dependencyArrays = [self backingStoreValueForKey:kCPTargetDefinitionDependenciesAttributeKey];
  NSMutableArray <CPDependency *>*dependencies = [NSMutableArray new];
  [dependencyArrays enumerateObjectsUsingBlock:^(id value, NSUInteger idx, BOOL *stop) {
      [dependencies addObject:[CPDependency fromYAMLValue:value]];
  }];
  [self setDependencies:dependencies];
  [self setBackingStoreValue:nil forKey:kCPTargetDefinitionDependenciesAttributeKey];

  return self;
}

- (NSDictionary *)dictionaryRepresentation {
  NSMutableArray *childDictionaries = [NSMutableArray new];
  [self.children enumerateObjectsUsingBlock:^(CPTargetDefinition *child, NSUInteger idx, BOOL *stop) {
    [childDictionaries addObject:[child dictionaryRepresentation]];
  }];
  [self setBackingStoreValue:childDictionaries forKey:kCPTargetDefinitionDependenciesAttributeKey];

  NSMutableArray *dependencyArrays = [NSMutableArray new];
  [self.dependencies enumerateObjectsUsingBlock:^(CPDependency *dependency, NSUInteger idx, BOOL *stop) {
    [dependencyArrays addObject:dependency.requirements];
  }];
  [self setBackingStoreValue:dependencyArrays forKey:kCPTargetDefinitionDependenciesAttributeKey];

  return [super dictionaryRepresentation];
}

//------------------------------------------------------------------------------
#pragma mark - Attributes Support
//------------------------------------------------------------------------------

- (NSString*)platformName;
{
  id rawValue = [self backingStoreValueForKey:@"platform"];
  if ([rawValue isKindOfClass:[NSString class]]) {
    return rawValue;
  } else {
    return [[rawValue allKeys] objectAtIndex:0];
  }
}

- (NSString*)deploymentTarget;
{
  id rawValue = [self backingStoreValueForKey:@"platform"];
  if ([rawValue isKindOfClass:[NSDictionary class]]) {
    return [[rawValue allValues] objectAtIndex:0];
  } else {
    return nil;
  }
}

- (void)setPlatformWithName:(NSString*)platform deploymentTarget:(NSString*)deploymentTarget;
{
  if (deploymentTarget) {
    [self setBackingStoreValue:@{ platform: deploymentTarget } forKey:@"platform"];
  } else {
    [self setBackingStoreValue:@{ platform: [NSNull null] } forKey:@"platform"];
  }
}

//------------------------------------------------------------------------------
#pragma mark - NSObject
//------------------------------------------------------------------------------

- (NSString *)description {
  return [NSString stringWithFormat:@"<%@: %@>", NSStringFromClass([self class]), self.name];
}

@end

