//
//  CPDependency.m
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 07/03/13.
//  Copyright (c) 2013 CocoaPods. All rights reserved.
//

#import "CPDependency.h"

@interface CPDependency ()
@property (readwrite) NSMutableArray *requirements;
@end

@implementation CPDependency

- (instancetype)initWithName:(NSString*)name requirements:(NSArray*)requirements; {
  self = [super init];
  if (self) {
    _name = name;
    _requirements = [(requirements?:@[]) mutableCopy];
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
  if ([object isKindOfClass:[self class]]) {
    return [self.name isEqualTo:[object name]] && [self.requirements isEqualTo:[object requirements]];
  }
  return false;
}

@end
