//
//  CPPodfile.m
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 28/02/13.
//  Copyright (c) 2013 CocoaPods. MIT License.
//

#import "CPPodfile.h"
#import "CPDictionaryBackedObject+Private.h"
#import "CPTargetDefinition.h"

@interface CPPodfile ()
@property (readwrite) NSMutableArray* targetDefinitions;
@end

//------------------------------------------------------------------------------

@implementation CPPodfile

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

  NSArray *targetDefinitionDictionaries = [self backingStoreValueForKey:kCPPodfileTargetDefinitionsAttributeKey];
  NSMutableArray *targetDefinitions = [NSMutableArray new];
  [targetDefinitionDictionaries enumerateObjectsUsingBlock:^(NSDictionary *targetDefinition, NSUInteger idx, BOOL *stop) {
    [targetDefinitions addObject:[[CPTargetDefinition alloc] initWithDictionary:targetDefinition]];
  }];
  [self setTargetDefinitions:targetDefinitions];
  [self setBackingStoreValue:nil forKey:kCPPodfileTargetDefinitionsAttributeKey];

  return self;
}

- (NSDictionary *)dictionaryRepresentation {
  NSMutableArray *targetDefinitionDictionaries = [NSMutableArray new];
  [self.targetDefinitions enumerateObjectsUsingBlock:^(CPTargetDefinition *targetDefinition, NSUInteger idx, BOOL *stop) {
    [targetDefinitionDictionaries addObject:[targetDefinition dictionaryRepresentation]];
  }];
  [self setBackingStoreValue:targetDefinitionDictionaries forKey:kCPPodfileTargetDefinitionsAttributeKey];
  return [super dictionaryRepresentation];
}

@end
