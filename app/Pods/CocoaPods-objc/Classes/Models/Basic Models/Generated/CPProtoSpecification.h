//
//  File generated programmatically by a Rake task.

#import "CPDictionaryBackedObject.h"

extern NSString * const kCPSpecificationXcconfigAttributeKey;
extern NSString * const kCPSpecificationNameAttributeKey;
extern NSString * const kCPSpecificationVersionAttributeKey;
extern NSString * const kCPSpecificationCocoapodsVersionAttributeKey;
extern NSString * const kCPSpecificationAuthorsAttributeKey;
extern NSString * const kCPSpecificationSocialMediaUrlAttributeKey;
extern NSString * const kCPSpecificationDocsetUrlAttributeKey;
extern NSString * const kCPSpecificationLicenseAttributeKey;
extern NSString * const kCPSpecificationHomepageAttributeKey;
extern NSString * const kCPSpecificationSourceAttributeKey;
extern NSString * const kCPSpecificationSummaryAttributeKey;
extern NSString * const kCPSpecificationDescriptionAttributeKey;
extern NSString * const kCPSpecificationScreenshotsAttributeKey;
extern NSString * const kCPSpecificationDocumentationUrlAttributeKey;
extern NSString * const kCPSpecificationPrepareCommandAttributeKey;
extern NSString * const kCPSpecificationDeprecatedAttributeKey;
extern NSString * const kCPSpecificationDeprecatedInFavorOfAttributeKey;
extern NSString * const kCPSpecificationPlatformsAttributeKey;
extern NSString * const kCPSpecificationDependenciesAttributeKey;
extern NSString * const kCPSpecificationRequiresArcAttributeKey;
extern NSString * const kCPSpecificationFrameworksAttributeKey;
extern NSString * const kCPSpecificationWeakFrameworksAttributeKey;
extern NSString * const kCPSpecificationLibrariesAttributeKey;
extern NSString * const kCPSpecificationCompilerFlagsAttributeKey;
extern NSString * const kCPSpecificationPodTargetXcconfigAttributeKey;
extern NSString * const kCPSpecificationUserTargetXcconfigAttributeKey;
extern NSString * const kCPSpecificationPrefixHeaderContentsAttributeKey;
extern NSString * const kCPSpecificationPrefixHeaderFileAttributeKey;
extern NSString * const kCPSpecificationModuleNameAttributeKey;
extern NSString * const kCPSpecificationHeaderDirAttributeKey;
extern NSString * const kCPSpecificationHeaderMappingsDirAttributeKey;
extern NSString * const kCPSpecificationSourceFilesAttributeKey;
extern NSString * const kCPSpecificationPublicHeaderFilesAttributeKey;
extern NSString * const kCPSpecificationPrivateHeaderFilesAttributeKey;
extern NSString * const kCPSpecificationVendoredFrameworksAttributeKey;
extern NSString * const kCPSpecificationVendoredLibrariesAttributeKey;
extern NSString * const kCPSpecificationResourceBundlesAttributeKey;
extern NSString * const kCPSpecificationResourcesAttributeKey;
extern NSString * const kCPSpecificationExcludeFilesAttributeKey;
extern NSString * const kCPSpecificationPreservePathsAttributeKey;
extern NSString * const kCPSpecificationModuleMapAttributeKey;
extern NSString * const kCPSpecificationDefaultSubspecsAttributeKey;

@interface CPProtoSpecification : CPDictionaryBackedObject

/**
  The xcconfig attribute.
*/
- (NSDictionary*)xcconfig;
- (void)setXcconfig:(NSDictionary*)xcconfig;

/**
  The name attribute.
*/
- (NSString*)name;
- (void)setName:(NSString*)name;

/**
  The version attribute.
*/
- (NSString*)version;
- (void)setVersion:(NSString*)version;

/**
  The cocoapods_version attribute.
*/
- (NSString*)cocoapodsVersion;
- (void)setCocoapodsVersion:(NSString*)cocoapodsVersion;

/**
  The authors attribute.
*/
- (NSDictionary*)authors;
- (void)setAuthors:(NSDictionary*)authors;

/**
  The social_media_url attribute.
*/
- (NSString*)socialMediaUrl;
- (void)setSocialMediaUrl:(NSString*)socialMediaUrl;

/**
  The docset_url attribute.
*/
- (NSString*)docsetUrl;
- (void)setDocsetUrl:(NSString*)docsetUrl;

/**
  The license attribute.
*/
- (NSDictionary*)license;
- (void)setLicense:(NSDictionary*)license;

/**
  The homepage attribute.
*/
- (NSString*)homepage;
- (void)setHomepage:(NSString*)homepage;

/**
  The source attribute.
*/
- (NSDictionary*)source;
- (void)setSource:(NSDictionary*)source;

/**
  The summary attribute.
*/
- (NSString*)summary;
- (void)setSummary:(NSString*)summary;

/**
  The description attribute.
*/
- (NSString*)descriptionAttr;
- (void)setDescriptionAttr:(NSString*)descriptionAttr;

/**
  The screenshots attribute.
*/
- (NSArray*)screenshots;
- (void)setScreenshots:(NSArray*)screenshots;

/**
  The documentation_url attribute.
*/
- (NSString*)documentationUrl;
- (void)setDocumentationUrl:(NSString*)documentationUrl;

/**
  The prepare_command attribute.
*/
- (NSString*)prepareCommand;
- (void)setPrepareCommand:(NSString*)prepareCommand;

/**
  The deprecated attribute.
*/
- (BOOL)deprecated;
- (void)setDeprecated:(BOOL)deprecated;

/**
  The deprecated_in_favor_of attribute.
*/
- (NSString*)deprecatedInFavorOf;
- (void)setDeprecatedInFavorOf:(NSString*)deprecatedInFavorOf;

/**
  The platforms attribute.
*/
- (NSDictionary*)platforms;
- (void)setPlatforms:(NSDictionary*)platforms;

/**
  The dependencies attribute.
*/
- (NSDictionary*)dependencies;
- (void)setDependencies:(NSDictionary*)dependencies;

/**
  The requires_arc attribute.
*/
- (NSString*)requiresArc;
- (void)setRequiresArc:(NSString*)requiresArc;

/**
  The frameworks attribute.
*/
- (NSArray*)frameworks;
- (void)setFrameworks:(NSArray*)frameworks;

/**
  The weak_frameworks attribute.
*/
- (NSArray*)weakFrameworks;
- (void)setWeakFrameworks:(NSArray*)weakFrameworks;

/**
  The libraries attribute.
*/
- (NSArray*)libraries;
- (void)setLibraries:(NSArray*)libraries;

/**
  The compiler_flags attribute.
*/
- (NSArray*)compilerFlags;
- (void)setCompilerFlags:(NSArray*)compilerFlags;

/**
  The pod_target_xcconfig attribute.
*/
- (NSDictionary*)podTargetXcconfig;
- (void)setPodTargetXcconfig:(NSDictionary*)podTargetXcconfig;

/**
  The user_target_xcconfig attribute.
*/
- (NSDictionary*)userTargetXcconfig;
- (void)setUserTargetXcconfig:(NSDictionary*)userTargetXcconfig;

/**
  The prefix_header_contents attribute.
*/
- (NSString*)prefixHeaderContents;
- (void)setPrefixHeaderContents:(NSString*)prefixHeaderContents;

/**
  The prefix_header_file attribute.
*/
- (NSString*)prefixHeaderFile;
- (void)setPrefixHeaderFile:(NSString*)prefixHeaderFile;

/**
  The module_name attribute.
*/
- (NSString*)moduleName;
- (void)setModuleName:(NSString*)moduleName;

/**
  The header_dir attribute.
*/
- (NSString*)headerDir;
- (void)setHeaderDir:(NSString*)headerDir;

/**
  The header_mappings_dir attribute.
*/
- (NSString*)headerMappingsDir;
- (void)setHeaderMappingsDir:(NSString*)headerMappingsDir;

/**
  The source_files attribute.
*/
- (NSArray*)sourceFiles;
- (void)setSourceFiles:(NSArray*)sourceFiles;

/**
  The public_header_files attribute.
*/
- (NSArray*)publicHeaderFiles;
- (void)setPublicHeaderFiles:(NSArray*)publicHeaderFiles;

/**
  The private_header_files attribute.
*/
- (NSArray*)privateHeaderFiles;
- (void)setPrivateHeaderFiles:(NSArray*)privateHeaderFiles;

/**
  The vendored_frameworks attribute.
*/
- (NSArray*)vendoredFrameworks;
- (void)setVendoredFrameworks:(NSArray*)vendoredFrameworks;

/**
  The vendored_libraries attribute.
*/
- (NSArray*)vendoredLibraries;
- (void)setVendoredLibraries:(NSArray*)vendoredLibraries;

/**
  The resource_bundles attribute.
*/
- (NSDictionary*)resourceBundles;
- (void)setResourceBundles:(NSDictionary*)resourceBundles;

/**
  The resources attribute.
*/
- (NSArray*)resources;
- (void)setResources:(NSArray*)resources;

/**
  The exclude_files attribute.
*/
- (NSArray*)excludeFiles;
- (void)setExcludeFiles:(NSArray*)excludeFiles;

/**
  The preserve_paths attribute.
*/
- (NSArray*)preservePaths;
- (void)setPreservePaths:(NSArray*)preservePaths;

/**
  The module_map attribute.
*/
- (NSString*)moduleMap;
- (void)setModuleMap:(NSString*)moduleMap;

/**
  The default_subspecs attribute.
*/
- (NSArray*)defaultSubspecs;
- (void)setDefaultSubspecs:(NSArray*)defaultSubspecs;

@end

