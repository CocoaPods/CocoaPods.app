//
//  File generated programmatically by a Rake task.

#import "CPDictionaryBackedObject.h"

extern NSString * const kCPPodfileWorkspaceAttributeKey;
extern NSString * const kCPPodfileSourcesAttributeKey;
extern NSString * const kCPPodfilePluginsAttributeKey;
extern NSString * const kCPPodfileSetArcCompatibilityFlagAttributeKey;
extern NSString * const kCPPodfileGenerateBridgeSupportAttributeKey;
extern NSString * const kCPPodfileTargetDefinitionsAttributeKey;

@interface CPProtoPodfile : CPDictionaryBackedObject

/**
  The workspace attribute.
*/
- (NSString*)workspace;
- (void)setWorkspace:(NSString*)workspace;

/**
  The sources attribute.
*/
- (NSString*)sources;
- (void)setSources:(NSString*)sources;

/**
  The plugins attribute.
*/
- (NSString*)plugins;
- (void)setPlugins:(NSString*)plugins;

/**
  The set_arc_compatibility_flag attribute.
*/
- (BOOL)setArcCompatibilityFlag;
- (void)setSetArcCompatibilityFlag:(BOOL)setArcCompatibilityFlag;

/**
  The generate_bridge_support attribute.
*/
- (BOOL)generateBridgeSupport;
- (void)setGenerateBridgeSupport:(BOOL)generateBridgeSupport;

/**
  The target_definitions attribute.
*/
- (NSArray*)targetDefinitions;
- (void)setTargetDefinitions:(NSArray*)targetDefinitions;

@end

