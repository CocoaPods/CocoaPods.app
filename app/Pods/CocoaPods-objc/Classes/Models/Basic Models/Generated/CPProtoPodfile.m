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

- (NSString*)sources; {
  return [self backingStoreValueForKey:@"sources"];
}

- (void)setSources:(NSString*)sources; {
  [self setBackingStoreValue:sources forKey:@"sources"];
}

- (NSString*)plugins; {
  return [self backingStoreValueForKey:@"plugins"];
}

- (void)setPlugins:(NSString*)plugins; {
  [self setBackingStoreValue:plugins forKey:@"plugins"];
}

- (BOOL)setArcCompatibilityFlag; {
  id value = [self backingStoreValueForKey:@"set_arc_compatibility_flag"];
  return [value boolValue];
}

- (void)setSetArcCompatibilityFlag:(BOOL)setArcCompatibilityFlag; {
  [self setBackingStoreValue:[NSNumber numberWithBool:setArcCompatibilityFlag] forKey:@"set_arc_compatibility_flag"];
}

- (BOOL)generateBridgeSupport; {
  id value = [self backingStoreValueForKey:@"generate_bridge_support"];
  return [value boolValue];
}

- (void)setGenerateBridgeSupport:(BOOL)generateBridgeSupport; {
  [self setBackingStoreValue:[NSNumber numberWithBool:generateBridgeSupport] forKey:@"generate_bridge_support"];
}

- (NSArray*)targetDefinitions; {
  id value = [self backingStoreValueForKey:@"target_definitions"];
  return CPCoherceToArray(value);
}

- (void)setTargetDefinitions:(NSArray*)targetDefinitions; {
  [self setBackingStoreValue:targetDefinitions forKey:@"target_definitions"];
}

@end

