//
//  CPDependency.m
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 07/03/13.
//  Copyright (c) 2013 CocoaPods. All rights reserved.
//

#import "CPDependency.h"

@interface CPDependency ()
@property (readwrite) NSMutableArray<NSString *> *requirements;
@property (readwrite) NSMutableDictionary<NSString *, NSString *> *attributes;
@end

@implementation CPDependency

+ (instancetype)fromYAMLValue:(id)value {
  NSString *name;
  if ([value isKindOfClass:[NSString class]]) {
    return [[[self class] alloc] initWithName:value requirements:@[] attributes:@{}];
  } else if ([value isKindOfClass:[NSDictionary class]]) {
    name = [value allKeys][0];
    if ([value[name] isKindOfClass:[NSString class]]) {
      // a single requirement
      return [[[self class] alloc] initWithName:name requirements:@[ value[name] ] attributes:@{}];
    } else if ([value[name] isKindOfClass:[NSArray class]]) {
      if ([value[name][0] isKindOfClass:[NSDictionary class]]) {
        // dictionary of attributes for git/branch/etc
        return [[[self class] alloc] initWithName:name requirements:@[] attributes:value[name][0]];
      }
      // multiple requirement strings
      return [[[self class] alloc] initWithName:name requirements:value[name] attributes:@{}];
    }
  }
  return nil;
}

- (instancetype)initWithName:(NSString*)name
                requirements:(NSArray*)requirements
                  attributes:(NSDictionary *)attributes
{
  self = [super init];
  if (self) {
    _name = name;
    _requirements = [(requirements?:@[]) mutableCopy];
    _attributes = [(attributes?:@{}) mutableCopy];

    if (_attributes.count == 0 && _requirements.count == 0) {
      _requirements = @[ @">= 0" ];
    }
  }
  return self;
}

//------------------------------------------------------------------------------
#pragma mark - NSObject
//------------------------------------------------------------------------------

- (NSString *)description {
  return [NSString stringWithFormat:@"<%@ %@ ('%@')>", NSStringFromClass([self class]), self.name, [self.requirements componentsJoinedByString:@"', '"]];
}

- (BOOL)isEqual:(id)object {
  if (![object isKindOfClass:[self class]]) {
    return NO;
  }
  CPDependency *otherDependency = (CPDependency *)object;
  return [self.name isEqualTo:otherDependency.name] &&
         [self.requirements isEqualTo:otherDependency.requirements] &&
         [self.attributes isEqualTo:otherDependency.attributes];
}

@end
