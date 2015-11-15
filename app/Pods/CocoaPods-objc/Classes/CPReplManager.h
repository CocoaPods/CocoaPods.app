//
//  CPReplManager.h
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 06/03/13.
//  Copyright (c) 2013 CocoaPods. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CPSpecification;
@class CPPodfile;

/**
 Interfaces with the CocoaPods REPL to allow to cosume the Ruby DSL 
 serialization format of the CocoaPods models.
 
 This class spins up a persistent session of the CocoaPods REPL. The session
 is kept alive for performance as it might take a couple of seconds to launch
 the shell, Ruby and then the CocoaPods gem.
 
 The repl is serial and as new requests are performed they are queued for 
 processing.
 */
@interface CPReplManager : NSObject

///-----------------------------------------------------------------------------
/// @name Initialization & Configuration
///-----------------------------------------------------------------------------

/**
 The path to the CocoaPods binary to use. If the sell option is not used an 
 absolute path is required.
 
 Defaults to `pod`.
 */
@property NSString *launchPath;

/**
 Whether CocoaPods should run whithin the user shell. This allows to use
 Ruby version managers like RVM. This the recomended approach if CocoaPods is 
 not bundled in the client app.
 
 Defaults to true.
 */
@property BOOL useShell;


///-----------------------------------------------------------------------------
/// @name Launching the REPL
///-----------------------------------------------------------------------------

/**
 Launches the REPL. If the launch is sucessfull it reasonable to assume that the
 CocoaPods installation is functional.
 
 TODO: Currently CocoaPods will auto setup if needed. This should be presented
       to the user as a question. Moreover as the master repo doesn't exits
       the rest of the library should be notified.
 */
- (void)launch;

/**
 The version of CocoaPods as reported by the REPL during the launch process.
 */
@property (readonly) NSString *cocoaPodsVersion;

///-----------------------------------------------------------------------------
/// @name Fetching information
///-----------------------------------------------------------------------------

/**
 Asks the REPL for the search information and populates the search related
 properties of the sets. It is necessary to use the REPL because a specification
 might be written in the Ruby DSL.
 
 This operation can take some seconds to complete.
 */
- (void)loadSearchInformationWithblock:(void (^)(NSDictionary *searchDataByName))block;

/**
 Reads the specification with the given path through the REPL which can handle 
 the Ruby DSL.
 */
- (void)loadSpecificationWithPath:(NSString*)path block:(void (^)(CPSpecification *spec))block;

/**
 Reads the Podfile with the given path through the REPL which can handle the
 Ruby DSL.
 */
- (void)loadPodfileWithPath:(NSString*)path block:(void (^)(CPPodfile *podfile))block;

///-----------------------------------------------------------------------------
/// @name Handlers
///-----------------------------------------------------------------------------


/**
 Called if the REPL fails to launch. Generally clients app should present an
 error to the user explaining the issue.
 */
@property (copy) void (^launchSuceeded)(NSString *cocoaPodsVersion);

/**
 Called if the REPL fails to launch. Generally clients app should present an
 error to the user explaining the issue.
 */
@property (copy) void (^launchFailureHandler)(NSString *failureReason);

/**
 Called when the REPL is terminated.
 */
@property (copy) void (^terminationHandler)(int processExitCode);

@end
