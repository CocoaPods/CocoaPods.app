//
//  File generated programmatically by a Rake task.

#import "CPProtoPodfile.h"
#import "CPDictionaryBackedObject+Private.h"

NSString * const kCPPodfileWorkspaceAttributeKey = @"workspace";
NSString * const kCPPodfileSourcesAttributeKey = @"sources";
NSString * const kCPPodfilePluginsAttributeKey = @"plugins";
NSString * const kCPPodfileSetArcCompatibilityFlagAttributeKey = @"set_arc_compatibility_flag";
NSString * const kCPPodfileGenerateBridgeSupportAttributeKey = @"generate_bridge_support";
NSString * const kCPPodfileTargetDefinitionsAttributeKey = @"target_definitions";

@implementation CPProtoPodfile

- (NSString*)workspace; {
  return [self backingStoreValueForKey:@"workspace"];
}

- (void)setWorkspace:(NSString*)workspace; {
  [self setBackingStoreValue:workspace forKey:@"workspace"];
}

- (NSArray*)sources; {
  id value = [self backingStoreValueForKey:@"sources"];
  return CPCoerceToArray(value);
}

- (void)setSources:(NSArray*)sources; {
  [self setBackingStoreValue:sources forKey:@"sources"];
}

- (NSArray*)plugins; {
  id value = [self backingStoreValueForKey:@"plugins"];
  return CPCoerceToArray(value);
}

- (void)setPlugins:(NSArray*)plugins; {
  [self setBackingStoreValue:plugins forKey:@"plugins"];
}

- (BOOL)setArcCompatibilityFlag; {
  id value = [self backingStoreValueForKey:@"set_arc_compatibility_flag"];
  if (!value) {
    return YES;
  }
  return [value boolValue];
}

- (void)setSetArcCompatibilityFlag:(BOOL)setArcCompatibilityFlag; {
  [self setBackingStoreValue:[NSNumber numberWithBool:setArcCompatibilityFlag] forKey:@"set_arc_compatibility_flag"];
}

- (BOOL)generateBridgeSupport; {
  id value = [self backingStoreValueForKey:@"generate_bridge_support"];
  if (!value) {
    return YES;
  }
  return [value boolValue];
}

- (void)setGenerateBridgeSupport:(BOOL)generateBridgeSupport; {
  [self setBackingStoreValue:[NSNumber numberWithBool:generateBridgeSupport] forKey:@"generate_bridge_support"];
}

- (NSArray*)targetDefinitions; {
  id value = [self backingStoreValueForKey:@"target_definitions"];
  return CPCoerceToArray(value);
}

- (void)setTargetDefinitions:(NSArray*)targetDefinitions; {
  [self setBackingStoreValue:targetDefinitions forKey:@"target_definitions"];
}

@end

