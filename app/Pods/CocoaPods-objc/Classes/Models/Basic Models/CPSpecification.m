//
//  CPSpecification.m
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 28/02/13.
//  Copyright (c) 2013 CocoaPods. MIT License.
//

#import "CPSpecification.h"
#import "CPDictionaryBackedObject+Private.h"

@interface CPSpecification ()
@property (readwrite) NSMutableArray* targetDefinitions;
@end

NSString * const kCPSpecificationSubspecsKey = @"subspecs";

//------------------------------------------------------------------------------

@implementation CPSpecification

//------------------------------------------------------------------------------
#pragma mark - CPDictionaryBackedObject
//------------------------------------------------------------------------------

/**
 Convets the target definition to their object representation and stores them
 in a mutable array. The information is removed from the backing store and
 merged back when needed.
 */
- (instancetype)initWithBackingStore:(NSMutableDictionary *)backingStore {
  self = [super initWithBackingStore:backingStore];

  NSArray *subspecDictionaries = [self backingStoreValueForKey:kCPSpecificationSubspecsKey];
  NSMutableArray *subspec = [NSMutableArray new];
  [subspecDictionaries enumerateObjectsUsingBlock:^(NSDictionary *dictionary, NSUInteger idx, BOOL *stop) {
    [subspec addObject:[[CPSpecification alloc] initWithDictionary:dictionary]];
  }];
  [self setTargetDefinitions:subspec];
  [self setBackingStoreValue:nil forKey:kCPSpecificationSubspecsKey];

  return self;
}

/**
 Convert the subspecs back to a dictionary.
 */
- (NSDictionary *)dictionaryRepresentation {
  NSMutableArray *subspecsDictionaries = [NSMutableArray new];
  [self.targetDefinitions enumerateObjectsUsingBlock:^(CPSpecification *subspecs, NSUInteger idx, BOOL *stop) {
    [subspecsDictionaries addObject:[subspecs dictionaryRepresentation]];
  }];
  [self setBackingStoreValue:subspecsDictionaries forKey:kCPSpecificationSubspecsKey];
  return [super dictionaryRepresentation];
}

//------------------------------------------------------------------------------
#pragma mark - Attributes Support
//------------------------------------------------------------------------------

/**
 Normalizes the license which can expressed as a string.
 */
- (NSDictionary*)license; {
  id rawValue = [self backingStoreValueForKey:@"license"];
  if ([rawValue isKindOfClass:[NSString class]]) {
    return @{@"type": rawValue};
  } else {
    return rawValue;
  }
}

- (NSString*)licenseType; {
  return [self license][@"type"];
}

-(NSDictionary *)iosAttributes {
  return [self backingStoreValueForKey:@"ios"];
}

-(NSDictionary *)osxAttributes {
  return [self backingStoreValueForKey:@"osx"];
}

//------------------------------------------------------------------------------
#pragma mark - NSObject
//------------------------------------------------------------------------------

- (NSString *)description {
  return [NSString stringWithFormat:@"<%@: %@ (%@)>", NSStringFromClass([self class]), self.name, self.version];
}

@end

