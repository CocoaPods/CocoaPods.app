//
//  CPCocoaPodsManager.h
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 07/03/13.
//  Copyright (c) 2013 CocoaPods. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CPConfig;
@class CPPodfile;
@class CPSpecification;
@class DSUnixTask;

@interface CPManager : NSObject

///-----------------------------------------------------------------------------
/// @name Initialization & Configuration
///-----------------------------------------------------------------------------

/**
 Returns the shared instance.
 */
+ (instancetype)sharedManager;

/**
 The configuration to use.
 */
@property CPConfig *config;

///-----------------------------------------------------------------------------
/// @name Running
///-----------------------------------------------------------------------------

/**
 Launches a persistent session of the CocoaPods REPL. Once the REPL is launched
 its version is checked for compatibility. If this method succeeds the CocoaPods
 installation can be considered funtional to be used with this library.
 */
- (void)handShakeWithSuccess:(void (^)(NSString *executableVersion))success
                     failure:(void (^)(NSError *error))failure;

/**
 Whether the master repo is available.
 */
//- (BOOL)needsSetup;

/**
 Runs `pod setup` to checkout the local copy of the master repo.
 */
//- (void)runSetup;

///-----------------------------------------------------------------------------
/// @name Repos
///-----------------------------------------------------------------------------

/**
 Loads the list of all the sets. This process is fairly quick as is done in
 ObjC and only needs to read the dir structure.
 */
- (NSArray *)loadSets;

/**
 Populates the search information of the loaded sets. This process can take up 
 to 10s becaues it needs to read the most representative specification of all 
 the set.
 */
- (void)loadSearchInformation;

/**
 The sets available to the installation of CocoaPods as detected by loadSets.
 */
@property (readonly) NSArray *sets;


/**
 Runs `pod repo update` to update the repositories against their remotes.
 */
//- (void)updateRepositories;

///-----------------------------------------------------------------------------
/// @name Models
///-----------------------------------------------------------------------------

/**
 Loads the Specification with the given path. If the Specification is stored in the YAML
 format it loads sincronously and the callback is called immediately. If the
 Specification is specified with the Ruby DSL the CocoaPods repl is used.

 @param path
 @param block
 */
- (void)loadSpecificationWithPath:(NSString*)path block:(void (^)(CPSpecification *spec))block;

/**
 Loads the Podfile with the given path. If the Podfile is stored in the YAML 
 format it loads sincronously and the callback is called immediately. If the 
 Podfile is specified with the Ruby DSL the CocoaPods repl is used.

 @param path
 @param block
 */
- (void)loadPodfileWithPath:(NSString*)path block:(void (^)(CPPodfile *podfile))block;

///-----------------------------------------------------------------------------
/// @name Working with installations
///-----------------------------------------------------------------------------

/**
 Returns whether an installation is needed. In detail it provides information
 about:

 - whether the Podfile has changes.
 - whether the Sandbox is in synch with the Podfile.lock.
 - the list of the installed Pods from the lockfile Podfile.lock (i.e. the Pods which should be installed).
 - whether there are updates for any of the installed Pods.
 */
- (void)analyzeDirectory:(NSString*)path;

/**
 Runs `pod install` in the given directory using the settings specified in the 
 config.
 */
- (void)runInstallInDirectory:(NSString*)path
                   standardOutput:(void (^)(DSUnixTask *task, NSString *fragment))standardOutputHandler
                    standardError:(void (^)(DSUnixTask *task, NSString *fragment))standardErrorHandler
                          success:(void (^)(void))success
                          failure:(void (^)(NSError *error))failure;

/**
 Runs `pod update` in the given directory using the settings specified in the 
 config.
 */
- (void)runUpdateInDirectory:(NSString*)path
                  standardOutput:(void (^)(DSUnixTask *task, NSString *fragment))standardOutputHandler
                   standardError:(void (^)(DSUnixTask *task, NSString *fragment))standardErrorHandler
                         success:(void (^)(void))success
                         failure:(void (^)(NSError *error))failure;

///-----------------------------------------------------------------------------
/// @name Working with specifications
///-----------------------------------------------------------------------------

/**
 Runs `pod spec lint` for the specification with the given path.
 */
//- (void)runLintForSpecificationWithPath:(NSString*)path;


/**
 Runs `pod spec push` for the specification with the given path.
 */
//- (void)runPushForSpecificationWithPath:(NSString*)path;

///-----------------------------------------------------------------------------
/// @name Runnings tasks
///-----------------------------------------------------------------------------

/**
 Returns a task configured with the CocoaPods executable suitable for running
 arbitraty commands.
 */
- (DSUnixTask *)createTask;

@end
