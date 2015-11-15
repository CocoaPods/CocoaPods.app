//
//  File generated programmatically by a Rake task.

#import "CPProtoTargetDefinition.h"
#import "CPDictionaryBackedObject+Private.h"

NSString * const kCPTargetDefinitionNameAttributeKey = @"name";
NSString * const kCPTargetDefinitionPlatformAttributeKey = @"platform";
NSString * const kCPTargetDefinitionPodspecsAttributeKey = @"podspecs";
NSString * const kCPTargetDefinitionExclusiveAttributeKey = @"exclusive";
NSString * const kCPTargetDefinitionLinkWithAttributeKey = @"link_with";
NSString * const kCPTargetDefinitionLinkWithFirstTargetAttributeKey = @"link_with_first_target";
NSString * const kCPTargetDefinitionInhibitWarningsAttributeKey = @"inhibit_warnings";
NSString * const kCPTargetDefinitionUserProjectPathAttributeKey = @"user_project_path";
NSString * const kCPTargetDefinitionBuildConfigurationsAttributeKey = @"build_configurations";
NSString * const kCPTargetDefinitionDependenciesAttributeKey = @"dependencies";
NSString * const kCPTargetDefinitionChildrenAttributeKey = @"children";
NSString * const kCPTargetDefinitionConfigurationPodWhitelistAttributeKey = @"configuration_pod_whitelist";
NSString * const kCPTargetDefinitionUsesFrameworksAttributeKey = @"uses_frameworks";

@implementation CPProtoTargetDefinition

- (NSString*)name; {
  return [self backingStoreValueForKey:@"name"];
}

- (void)setName:(NSString*)name; {
  [self setBackingStoreValue:name forKey:@"name"];
}

- (NSString*)platform; {
  return [self backingStoreValueForKey:@"platform"];
}

- (void)setPlatform:(NSString*)platform; {
  [self setBackingStoreValue:platform forKey:@"platform"];
}

- (NSArray*)podspecs; {
  id value = [self backingStoreValueForKey:@"podspecs"];
  return CPCoherceToArray(value);
}

- (void)setPodspecs:(NSArray*)podspecs; {
  [self setBackingStoreValue:podspecs forKey:@"podspecs"];
}

- (BOOL)exclusive; {
  id value = [self backingStoreValueForKey:@"exclusive"];
  return [value boolValue];
}

- (void)setExclusive:(BOOL)exclusive; {
  [self setBackingStoreValue:[NSNumber numberWithBool:exclusive] forKey:@"exclusive"];
}

- (NSString*)linkWith; {
  return [self backingStoreValueForKey:@"link_with"];
}

- (void)setLinkWith:(NSString*)linkWith; {
  [self setBackingStoreValue:linkWith forKey:@"link_with"];
}

- (NSString*)linkWithFirstTarget; {
  return [self backingStoreValueForKey:@"link_with_first_target"];
}

- (void)setLinkWithFirstTarget:(NSString*)linkWithFirstTarget; {
  [self setBackingStoreValue:linkWithFirstTarget forKey:@"link_with_first_target"];
}

- (NSString*)inhibitWarnings; {
  return [self backingStoreValueForKey:@"inhibit_warnings"];
}

- (void)setInhibitWarnings:(NSString*)inhibitWarnings; {
  [self setBackingStoreValue:inhibitWarnings forKey:@"inhibit_warnings"];
}

- (NSString*)userProjectPath; {
  return [self backingStoreValueForKey:@"user_project_path"];
}

- (void)setUserProjectPath:(NSString*)userProjectPath; {
  [self setBackingStoreValue:userProjectPath forKey:@"user_project_path"];
}

- (NSDictionary*)buildConfigurations; {
  id value = [self backingStoreValueForKey:@"build_configurations"];
  return CPCoherceToDictionary(value);
}

- (void)setBuildConfigurations:(NSDictionary*)buildConfigurations; {
  [self setBackingStoreValue:buildConfigurations forKey:@"build_configurations"];
}

- (NSArray*)dependencies; {
  id value = [self backingStoreValueForKey:@"dependencies"];
  return CPCoherceToArray(value);
}

- (void)setDependencies:(NSArray*)dependencies; {
  [self setBackingStoreValue:dependencies forKey:@"dependencies"];
}

- (NSArray*)children; {
  id value = [self backingStoreValueForKey:@"children"];
  return CPCoherceToArray(value);
}

- (void)setChildren:(NSArray*)children; {
  [self setBackingStoreValue:children forKey:@"children"];
}

- (NSString*)configurationPodWhitelist; {
  return [self backingStoreValueForKey:@"configuration_pod_whitelist"];
}

- (void)setConfigurationPodWhitelist:(NSString*)configurationPodWhitelist; {
  [self setBackingStoreValue:configurationPodWhitelist forKey:@"configuration_pod_whitelist"];
}

- (NSString*)usesFrameworks; {
  return [self backingStoreValueForKey:@"uses_frameworks"];
}

- (void)setUsesFrameworks:(NSString*)usesFrameworks; {
  [self setBackingStoreValue:usesFrameworks forKey:@"uses_frameworks"];
}

@end

