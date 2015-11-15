//
//  File generated programmatically by a Rake task.

#import "CPDictionaryBackedObject.h"

extern NSString * const kCPTargetDefinitionNameAttributeKey;
extern NSString * const kCPTargetDefinitionPlatformAttributeKey;
extern NSString * const kCPTargetDefinitionPodspecsAttributeKey;
extern NSString * const kCPTargetDefinitionExclusiveAttributeKey;
extern NSString * const kCPTargetDefinitionLinkWithAttributeKey;
extern NSString * const kCPTargetDefinitionLinkWithFirstTargetAttributeKey;
extern NSString * const kCPTargetDefinitionInhibitWarningsAttributeKey;
extern NSString * const kCPTargetDefinitionUserProjectPathAttributeKey;
extern NSString * const kCPTargetDefinitionBuildConfigurationsAttributeKey;
extern NSString * const kCPTargetDefinitionDependenciesAttributeKey;
extern NSString * const kCPTargetDefinitionChildrenAttributeKey;
extern NSString * const kCPTargetDefinitionConfigurationPodWhitelistAttributeKey;
extern NSString * const kCPTargetDefinitionUsesFrameworksAttributeKey;

@interface CPProtoTargetDefinition : CPDictionaryBackedObject

/**
  The name attribute.
*/
- (NSString*)name;
- (void)setName:(NSString*)name;

/**
  The platform attribute.
*/
- (NSString*)platform;
- (void)setPlatform:(NSString*)platform;

/**
  The podspecs attribute.
*/
- (NSArray*)podspecs;
- (void)setPodspecs:(NSArray*)podspecs;

/**
  The exclusive attribute.
*/
- (BOOL)exclusive;
- (void)setExclusive:(BOOL)exclusive;

/**
  The link_with attribute.
*/
- (NSString*)linkWith;
- (void)setLinkWith:(NSString*)linkWith;

/**
  The link_with_first_target attribute.
*/
- (NSString*)linkWithFirstTarget;
- (void)setLinkWithFirstTarget:(NSString*)linkWithFirstTarget;

/**
  The inhibit_warnings attribute.
*/
- (NSString*)inhibitWarnings;
- (void)setInhibitWarnings:(NSString*)inhibitWarnings;

/**
  The user_project_path attribute.
*/
- (NSString*)userProjectPath;
- (void)setUserProjectPath:(NSString*)userProjectPath;

/**
  The build_configurations attribute.
*/
- (NSDictionary*)buildConfigurations;
- (void)setBuildConfigurations:(NSDictionary*)buildConfigurations;

/**
  The dependencies attribute.
*/
- (NSArray*)dependencies;
- (void)setDependencies:(NSArray*)dependencies;

/**
  The children attribute.
*/
- (NSArray*)children;
- (void)setChildren:(NSArray*)children;

/**
  The configuration_pod_whitelist attribute.
*/
- (NSString*)configurationPodWhitelist;
- (void)setConfigurationPodWhitelist:(NSString*)configurationPodWhitelist;

/**
  The uses_frameworks attribute.
*/
- (NSString*)usesFrameworks;
- (void)setUsesFrameworks:(NSString*)usesFrameworks;

/**
  The name attribute.
*/
- (NSString*)name;
- (void)setName:(NSString*)name;

/**
  The link_with_first_target attribute.
*/
- (NSString*)linkWithFirstTarget;
- (void)setLinkWithFirstTarget:(NSString*)linkWithFirstTarget;

@end

