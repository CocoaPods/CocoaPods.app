//
//  CPBaseModel.m
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 28/02/13.
//  Copyright (c) 2013 CocoaPods. MIT License.
//

#import "CPDictionaryBackedObject.h"
#import "CPDictionaryBackedObject+Private.h"
#import "CPHelpers.h"

@implementation CPDictionaryBackedObject {
  NSMutableDictionary *_backingStore;
}

//------------------------------------------------------------------------------
#pragma mark - Exposed methods
//------------------------------------------------------------------------------

- (id)init {
  return [self initWithBackingStore:nil];
}

- (instancetype)initWithDictionary:(NSDictionary*)dictionary {
  return [self initWithBackingStore:[dictionary mutableCopy]];
}

/**
 The designated serializer. Subclasse rely on this behaviour.
 */
- (NSDictionary*)dictionaryRepresentation {
  return [self.backingStore copy];
}

- (instancetype)initWithYAML:(NSString*)yamlString {
  NSDictionary *dictionary = [CPDecodeYAMLString(yamlString) objectAtIndex:0];
  return [self initWithDictionary:dictionary];
}

- (NSData*)toYAML {
  return CPEncodeToYAML([self dictionaryRepresentation]);
}

//------------------------------------------------------------------------------
# pragma mark BackingStore
//------------------------------------------------------------------------------

/**
 Subclasses rely on this being the designated initializer!
 */
- (instancetype)initWithBackingStore:(NSMutableDictionary *)backingStore {
  self = [super init];
  if (self) {
    if (backingStore) {
      _backingStore = backingStore;
    } else {
      _backingStore = [NSMutableDictionary new];
    }
  }
  return self;
}

- (void)setBackingStoreValue:(id)value forKey:(NSString *)key; {
  if (value) {
    [self.backingStore setObject:value forKey:key];
  } else {
    [self.backingStore removeObjectForKey:key];
  }
}

- (id)backingStoreValueForKey:(NSString*)key; {
  return [self.backingStore objectForKey:key];
}

//------------------------------------------------------------------------------
#pragma mark - Subclasses helpers
//------------------------------------------------------------------------------

NSNumber* CPCoerceToBoolean(id value) {
  if ([value isEqualTo:@"true"]) {
    return @true;
  } else {
    return @false;
  }
}

NSArray* CPCoerceToArray(id value) {
  if ([value isKindOfClass:[NSArray class]]) {
    return value;
  } else {
    if (value) {
      return @[value];
    } else {
      return nil;
    }
  }
}

NSDictionary* CPCoerceToDictionary(id value) {
  if ([value isKindOfClass:[NSDictionary class]]) {
    return value;
  } else if ([value isKindOfClass:[NSArray class]]) {
    NSMutableDictionary *result = [NSMutableDictionary new];
    [value enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      result[obj] = [NSNull null];
    }];
    return result;
  } else if (value) {
    return @{value: [NSNull null]};
  } else {
    return nil;
  }
}

//------------------------------------------------------------------------------
#pragma mark - NSObject
//------------------------------------------------------------------------------

- (BOOL)isEqual:(id)object {
  if ([object isKindOfClass:[self class]]) {
    return [self.dictionaryRepresentation isEqualTo:[object dictionaryRepresentation]];
  }
  return false;
}

@end

