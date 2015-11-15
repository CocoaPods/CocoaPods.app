//
//  CPConfig.h
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 03/03/13.
//  Copyright (c) 2013 CocoaPods. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CPSourceAggregate;
@class CPSource;

@interface CPConfig : NSObject

///-----------------------------------------------------------------------------
/// @name Binary
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

/**
 The minimum version of the CocoaPods binary compatible with this library.
 */
@property (readonly) NSString *minimumSupportedCocoaPodsVersion;

///-----------------------------------------------------------------------------
/// @name Repos
///-----------------------------------------------------------------------------

/**
 The directory where the repos are stored. Defaults to `~/.cocoapods`
*/
@property (readonly) NSString *reposDir;

/**
 The source aggreagate from the repos dir.
*/
@property (readonly) CPSourceAggregate *sourceAggregate;

/**
 The master repo.
*/
- (CPSource*)masterRepo;

///-----------------------------------------------------------------------------
/// @name
///-----------------------------------------------------------------------------

@end
