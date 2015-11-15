//
//  File generated programmatically by a Rake task.

#import "CPProtoSpecification.h"
#import "CPDictionaryBackedObject+Private.h"

NSString * const kCPSpecificationXcconfigAttributeKey = @"xcconfig";
NSString * const kCPSpecificationNameAttributeKey = @"name";
NSString * const kCPSpecificationVersionAttributeKey = @"version";
NSString * const kCPSpecificationCocoapodsVersionAttributeKey = @"cocoapods_version";
NSString * const kCPSpecificationAuthorsAttributeKey = @"authors";
NSString * const kCPSpecificationSocialMediaUrlAttributeKey = @"social_media_url";
NSString * const kCPSpecificationDocsetUrlAttributeKey = @"docset_url";
NSString * const kCPSpecificationLicenseAttributeKey = @"license";
NSString * const kCPSpecificationHomepageAttributeKey = @"homepage";
NSString * const kCPSpecificationSourceAttributeKey = @"source";
NSString * const kCPSpecificationSummaryAttributeKey = @"summary";
NSString * const kCPSpecificationDescriptionAttributeKey = @"description";
NSString * const kCPSpecificationScreenshotsAttributeKey = @"screenshots";
NSString * const kCPSpecificationDocumentationUrlAttributeKey = @"documentation_url";
NSString * const kCPSpecificationPrepareCommandAttributeKey = @"prepare_command";
NSString * const kCPSpecificationDeprecatedAttributeKey = @"deprecated";
NSString * const kCPSpecificationDeprecatedInFavorOfAttributeKey = @"deprecated_in_favor_of";
NSString * const kCPSpecificationPlatformsAttributeKey = @"platforms";
NSString * const kCPSpecificationDependenciesAttributeKey = @"dependencies";
NSString * const kCPSpecificationRequiresArcAttributeKey = @"requires_arc";
NSString * const kCPSpecificationFrameworksAttributeKey = @"frameworks";
NSString * const kCPSpecificationWeakFrameworksAttributeKey = @"weak_frameworks";
NSString * const kCPSpecificationLibrariesAttributeKey = @"libraries";
NSString * const kCPSpecificationCompilerFlagsAttributeKey = @"compiler_flags";
NSString * const kCPSpecificationPodTargetXcconfigAttributeKey = @"pod_target_xcconfig";
NSString * const kCPSpecificationUserTargetXcconfigAttributeKey = @"user_target_xcconfig";
NSString * const kCPSpecificationPrefixHeaderContentsAttributeKey = @"prefix_header_contents";
NSString * const kCPSpecificationPrefixHeaderFileAttributeKey = @"prefix_header_file";
NSString * const kCPSpecificationModuleNameAttributeKey = @"module_name";
NSString * const kCPSpecificationHeaderDirAttributeKey = @"header_dir";
NSString * const kCPSpecificationHeaderMappingsDirAttributeKey = @"header_mappings_dir";
NSString * const kCPSpecificationSourceFilesAttributeKey = @"source_files";
NSString * const kCPSpecificationPublicHeaderFilesAttributeKey = @"public_header_files";
NSString * const kCPSpecificationPrivateHeaderFilesAttributeKey = @"private_header_files";
NSString * const kCPSpecificationVendoredFrameworksAttributeKey = @"vendored_frameworks";
NSString * const kCPSpecificationVendoredLibrariesAttributeKey = @"vendored_libraries";
NSString * const kCPSpecificationResourceBundlesAttributeKey = @"resource_bundles";
NSString * const kCPSpecificationResourcesAttributeKey = @"resources";
NSString * const kCPSpecificationExcludeFilesAttributeKey = @"exclude_files";
NSString * const kCPSpecificationPreservePathsAttributeKey = @"preserve_paths";
NSString * const kCPSpecificationModuleMapAttributeKey = @"module_map";
NSString * const kCPSpecificationDefaultSubspecsAttributeKey = @"default_subspecs";

@implementation CPProtoSpecification

- (NSDictionary*)xcconfig; {
  id value = [self backingStoreValueForKey:@"xcconfig"];
  return CPCoherceToDictionary(value);
}

- (void)setXcconfig:(NSDictionary*)xcconfig; {
  [self setBackingStoreValue:xcconfig forKey:@"xcconfig"];
}

- (NSString*)name; {
  return [self backingStoreValueForKey:@"name"];
}

- (void)setName:(NSString*)name; {
  [self setBackingStoreValue:name forKey:@"name"];
}

- (NSString*)version; {
  return [self backingStoreValueForKey:@"version"];
}

- (void)setVersion:(NSString*)version; {
  [self setBackingStoreValue:version forKey:@"version"];
}

- (NSString*)cocoapodsVersion; {
  return [self backingStoreValueForKey:@"cocoapods_version"];
}

- (void)setCocoapodsVersion:(NSString*)cocoapodsVersion; {
  [self setBackingStoreValue:cocoapodsVersion forKey:@"cocoapods_version"];
}

- (NSDictionary*)authors; {
  id value = [self backingStoreValueForKey:@"authors"];
  return CPCoherceToDictionary(value);
}

- (void)setAuthors:(NSDictionary*)authors; {
  [self setBackingStoreValue:authors forKey:@"authors"];
}

- (NSString*)socialMediaUrl; {
  return [self backingStoreValueForKey:@"social_media_url"];
}

- (void)setSocialMediaUrl:(NSString*)socialMediaUrl; {
  [self setBackingStoreValue:socialMediaUrl forKey:@"social_media_url"];
}

- (NSString*)docsetUrl; {
  return [self backingStoreValueForKey:@"docset_url"];
}

- (void)setDocsetUrl:(NSString*)docsetUrl; {
  [self setBackingStoreValue:docsetUrl forKey:@"docset_url"];
}

- (NSDictionary*)license; {
  id value = [self backingStoreValueForKey:@"license"];
  return CPCoherceToDictionary(value);
}

- (void)setLicense:(NSDictionary*)license; {
  [self setBackingStoreValue:license forKey:@"license"];
}

- (NSString*)homepage; {
  return [self backingStoreValueForKey:@"homepage"];
}

- (void)setHomepage:(NSString*)homepage; {
  [self setBackingStoreValue:homepage forKey:@"homepage"];
}

- (NSDictionary*)source; {
  id value = [self backingStoreValueForKey:@"source"];
  return CPCoherceToDictionary(value);
}

- (void)setSource:(NSDictionary*)source; {
  [self setBackingStoreValue:source forKey:@"source"];
}

- (NSString*)summary; {
  return [self backingStoreValueForKey:@"summary"];
}

- (void)setSummary:(NSString*)summary; {
  [self setBackingStoreValue:summary forKey:@"summary"];
}

- (NSString*)descriptionAttr; {
  return [self backingStoreValueForKey:@"description"];
}

- (void)setDescriptionAttr:(NSString*)descriptionAttr; {
  [self setBackingStoreValue:descriptionAttr forKey:@"description"];
}

- (NSArray*)screenshots; {
  id value = [self backingStoreValueForKey:@"screenshots"];
  return CPCoherceToArray(value);
}

- (void)setScreenshots:(NSArray*)screenshots; {
  [self setBackingStoreValue:screenshots forKey:@"screenshots"];
}

- (NSString*)documentationUrl; {
  return [self backingStoreValueForKey:@"documentation_url"];
}

- (void)setDocumentationUrl:(NSString*)documentationUrl; {
  [self setBackingStoreValue:documentationUrl forKey:@"documentation_url"];
}

- (NSString*)prepareCommand; {
  return [self backingStoreValueForKey:@"prepare_command"];
}

- (void)setPrepareCommand:(NSString*)prepareCommand; {
  [self setBackingStoreValue:prepareCommand forKey:@"prepare_command"];
}

- (BOOL)deprecated; {
  id value = [self backingStoreValueForKey:@"deprecated"];
  return [value boolValue];
}

- (void)setDeprecated:(BOOL)deprecated; {
  [self setBackingStoreValue:[NSNumber numberWithBool:deprecated] forKey:@"deprecated"];
}

- (NSString*)deprecatedInFavorOf; {
  return [self backingStoreValueForKey:@"deprecated_in_favor_of"];
}

- (void)setDeprecatedInFavorOf:(NSString*)deprecatedInFavorOf; {
  [self setBackingStoreValue:deprecatedInFavorOf forKey:@"deprecated_in_favor_of"];
}

- (NSDictionary*)platforms; {
  id value = [self backingStoreValueForKey:@"platforms"];
  return CPCoherceToDictionary(value);
}

- (void)setPlatforms:(NSDictionary*)platforms; {
  [self setBackingStoreValue:platforms forKey:@"platforms"];
}

- (NSDictionary*)dependencies; {
  id value = [self backingStoreValueForKey:@"dependencies"];
  return CPCoherceToDictionary(value);
}

- (void)setDependencies:(NSDictionary*)dependencies; {
  [self setBackingStoreValue:dependencies forKey:@"dependencies"];
}

- (NSString*)requiresArc; {
  return [self backingStoreValueForKey:@"requires_arc"];
}

- (void)setRequiresArc:(NSString*)requiresArc; {
  [self setBackingStoreValue:requiresArc forKey:@"requires_arc"];
}

- (NSArray*)frameworks; {
  id value = [self backingStoreValueForKey:@"frameworks"];
  return CPCoherceToArray(value);
}

- (void)setFrameworks:(NSArray*)frameworks; {
  [self setBackingStoreValue:frameworks forKey:@"frameworks"];
}

- (NSArray*)weakFrameworks; {
  id value = [self backingStoreValueForKey:@"weak_frameworks"];
  return CPCoherceToArray(value);
}

- (void)setWeakFrameworks:(NSArray*)weakFrameworks; {
  [self setBackingStoreValue:weakFrameworks forKey:@"weak_frameworks"];
}

- (NSArray*)libraries; {
  id value = [self backingStoreValueForKey:@"libraries"];
  return CPCoherceToArray(value);
}

- (void)setLibraries:(NSArray*)libraries; {
  [self setBackingStoreValue:libraries forKey:@"libraries"];
}

- (NSArray*)compilerFlags; {
  id value = [self backingStoreValueForKey:@"compiler_flags"];
  return CPCoherceToArray(value);
}

- (void)setCompilerFlags:(NSArray*)compilerFlags; {
  [self setBackingStoreValue:compilerFlags forKey:@"compiler_flags"];
}

- (NSDictionary*)podTargetXcconfig; {
  id value = [self backingStoreValueForKey:@"pod_target_xcconfig"];
  return CPCoherceToDictionary(value);
}

- (void)setPodTargetXcconfig:(NSDictionary*)podTargetXcconfig; {
  [self setBackingStoreValue:podTargetXcconfig forKey:@"pod_target_xcconfig"];
}

- (NSDictionary*)userTargetXcconfig; {
  id value = [self backingStoreValueForKey:@"user_target_xcconfig"];
  return CPCoherceToDictionary(value);
}

- (void)setUserTargetXcconfig:(NSDictionary*)userTargetXcconfig; {
  [self setBackingStoreValue:userTargetXcconfig forKey:@"user_target_xcconfig"];
}

- (NSString*)prefixHeaderContents; {
  return [self backingStoreValueForKey:@"prefix_header_contents"];
}

- (void)setPrefixHeaderContents:(NSString*)prefixHeaderContents; {
  [self setBackingStoreValue:prefixHeaderContents forKey:@"prefix_header_contents"];
}

- (NSString*)prefixHeaderFile; {
  return [self backingStoreValueForKey:@"prefix_header_file"];
}

- (void)setPrefixHeaderFile:(NSString*)prefixHeaderFile; {
  [self setBackingStoreValue:prefixHeaderFile forKey:@"prefix_header_file"];
}

- (NSString*)moduleName; {
  return [self backingStoreValueForKey:@"module_name"];
}

- (void)setModuleName:(NSString*)moduleName; {
  [self setBackingStoreValue:moduleName forKey:@"module_name"];
}

- (NSString*)headerDir; {
  return [self backingStoreValueForKey:@"header_dir"];
}

- (void)setHeaderDir:(NSString*)headerDir; {
  [self setBackingStoreValue:headerDir forKey:@"header_dir"];
}

- (NSString*)headerMappingsDir; {
  return [self backingStoreValueForKey:@"header_mappings_dir"];
}

- (void)setHeaderMappingsDir:(NSString*)headerMappingsDir; {
  [self setBackingStoreValue:headerMappingsDir forKey:@"header_mappings_dir"];
}

- (NSArray*)sourceFiles; {
  id value = [self backingStoreValueForKey:@"source_files"];
  return CPCoherceToArray(value);
}

- (void)setSourceFiles:(NSArray*)sourceFiles; {
  [self setBackingStoreValue:sourceFiles forKey:@"source_files"];
}

- (NSArray*)publicHeaderFiles; {
  id value = [self backingStoreValueForKey:@"public_header_files"];
  return CPCoherceToArray(value);
}

- (void)setPublicHeaderFiles:(NSArray*)publicHeaderFiles; {
  [self setBackingStoreValue:publicHeaderFiles forKey:@"public_header_files"];
}

- (NSArray*)privateHeaderFiles; {
  id value = [self backingStoreValueForKey:@"private_header_files"];
  return CPCoherceToArray(value);
}

- (void)setPrivateHeaderFiles:(NSArray*)privateHeaderFiles; {
  [self setBackingStoreValue:privateHeaderFiles forKey:@"private_header_files"];
}

- (NSArray*)vendoredFrameworks; {
  id value = [self backingStoreValueForKey:@"vendored_frameworks"];
  return CPCoherceToArray(value);
}

- (void)setVendoredFrameworks:(NSArray*)vendoredFrameworks; {
  [self setBackingStoreValue:vendoredFrameworks forKey:@"vendored_frameworks"];
}

- (NSArray*)vendoredLibraries; {
  id value = [self backingStoreValueForKey:@"vendored_libraries"];
  return CPCoherceToArray(value);
}

- (void)setVendoredLibraries:(NSArray*)vendoredLibraries; {
  [self setBackingStoreValue:vendoredLibraries forKey:@"vendored_libraries"];
}

- (NSDictionary*)resourceBundles; {
  id value = [self backingStoreValueForKey:@"resource_bundles"];
  return CPCoherceToDictionary(value);
}

- (void)setResourceBundles:(NSDictionary*)resourceBundles; {
  [self setBackingStoreValue:resourceBundles forKey:@"resource_bundles"];
}

- (NSArray*)resources; {
  id value = [self backingStoreValueForKey:@"resources"];
  return CPCoherceToArray(value);
}

- (void)setResources:(NSArray*)resources; {
  [self setBackingStoreValue:resources forKey:@"resources"];
}

- (NSArray*)excludeFiles; {
  id value = [self backingStoreValueForKey:@"exclude_files"];
  return CPCoherceToArray(value);
}

- (void)setExcludeFiles:(NSArray*)excludeFiles; {
  [self setBackingStoreValue:excludeFiles forKey:@"exclude_files"];
}

- (NSArray*)preservePaths; {
  id value = [self backingStoreValueForKey:@"preserve_paths"];
  return CPCoherceToArray(value);
}

- (void)setPreservePaths:(NSArray*)preservePaths; {
  [self setBackingStoreValue:preservePaths forKey:@"preserve_paths"];
}

- (NSString*)moduleMap; {
  return [self backingStoreValueForKey:@"module_map"];
}

- (void)setModuleMap:(NSString*)moduleMap; {
  [self setBackingStoreValue:moduleMap forKey:@"module_map"];
}

- (NSArray*)defaultSubspecs; {
  id value = [self backingStoreValueForKey:@"default_subspecs"];
  return CPCoherceToArray(value);
}

- (void)setDefaultSubspecs:(NSArray*)defaultSubspecs; {
  [self setBackingStoreValue:defaultSubspecs forKey:@"default_subspecs"];
}

@end

