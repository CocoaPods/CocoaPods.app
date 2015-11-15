//
//  CPCocoaPodsManager.m
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 07/03/13.
//  Copyright (c) 2013 CocoaPods. All rights reserved.
//

#import "CPManager.h"
#import "CPReplManager.h"
#import "DSUnixTaskSubProcessManager.h"
#import "CPHelpers.h"
#import "CPVersion.h"
#import "CPConfig.h"
#import "CPSet.h"
#import "CPSourceAggregate.h"

@interface CPManager ()

/*
 The REPL instance keept alive for performant queries.
 */
@property CPReplManager *repl;

@property NSArray *sets;

@end

//------------------------------------------------------------------------------

@implementation CPManager

//------------------------------------------------------------------------------
#pragma mark - Initialization & Configuration
//------------------------------------------------------------------------------

+ (instancetype)sharedManager;
{
  static id _sharedInstance;
  if (_sharedInstance == nil) {
    _sharedInstance = [[self alloc] init];
  }
  return _sharedInstance;
}

- (id)init
{
  self = [super init];
  if (self) {
    _config = [CPConfig new];
  }
  return self;
}

//------------------------------------------------------------------------------
#pragma mark - Running
//------------------------------------------------------------------------------

- (void)handShakeWithSuccess:(void (^)(NSString *executableVersion))success
                     failure:(void (^)(NSError *error))failure;
{
  CPReplManager *repl = [CPReplManager new];
  [repl setLaunchPath:self.config.launchPath];
  [self setRepl:repl];
  
  [repl setLaunchSuceeded:^(NSString *cocoaPodsVersion) {
    CPVersion *replVersion = [[CPVersion alloc] initWithString:cocoaPodsVersion];
    CPVersion *minVersion = [[CPVersion alloc] initWithString:self.config.minimumSupportedCocoaPodsVersion];
    NSComparisonResult comparison = [replVersion compare:minVersion];
    if (comparison == NSOrderedAscending) {
      NSMutableDictionary *userInfo = [NSMutableDictionary new];
      userInfo[NSLocalizedDescriptionKey] = [NSString stringWithFormat:@"Unsupported CocoaPods version: %@", cocoaPodsVersion];
      NSError *error = [NSError errorWithDomain:@"UnableTo" code:1 userInfo:userInfo];
      failure(error);
    } else {
      success(cocoaPodsVersion);
    }
  }];

  [repl setLaunchFailureHandler:^(NSString *reason) {
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    userInfo[NSLocalizedDescriptionKey] = [NSString stringWithFormat:@"Unable to launch the CocoaPods executable: %@", reason];
    NSError *error = [NSError errorWithDomain:@"UnableTo" code:1 userInfo:userInfo];
    failure(error);
  }];
  
  [repl launch];
}

//------------------------------------------------------------------------------
#pragma mark - Repos
//------------------------------------------------------------------------------

- (NSArray *)loadSets;
{
  CPSourceAggregate *aggregate = [self.config sourceAggregate];
  NSArray* sets = [aggregate sets];
  [self setSets:sets];
  return sets;
}

/*
 This doesn't uses the REPL becaue it would block it while processing. Using
 another task allows this opernation to be run in paralle.
 */
- (void)loadSearchInformation;
{
  if (!self.sets) {
    [self loadSets];
  }

  DSUnixTask *pod = [self createTask];
  [pod setArguments:@[@"ipc list"]];

  NSArray* sets = [self sets];
  [pod setTerminationHandler:^(DSUnixTask *task) {
    NSDictionary *searchDataByName = [CPDecodeYAMLString(task.standardOutput) objectAtIndex:0];
    [sets enumerateObjectsUsingBlock:^(CPSet *set, NSUInteger idx, BOOL *stop) {
      NSDictionary *setData = searchDataByName[set.name];
      if (setData) {
        [set setSetDescription:setData[@"description"]];
        [set setAuthors:setData[@"authors"]];
        [set setSummary:setData[@"summary"]];
      }
    }];
  }];

  [pod launch];
}

//------------------------------------------------------------------------------
#pragma mark - Models
//------------------------------------------------------------------------------

- (void)loadSpecificationWithPath:(NSString*)path block:(void (^)(CPSpecification *spec))block;
{
  [self.repl loadSpecificationWithPath:path block:^(CPSpecification *spec) {
    block(spec);
  }];
}

- (void)loadPodfileWithPath:(NSString*)path block:(void (^)(CPPodfile *podfile))block;
{
  [self.repl loadPodfileWithPath:path block:^(CPPodfile *podfile) {
    block(podfile);
  }];
}

//------------------------------------------------------------------------------
#pragma mark - Working with installations
//------------------------------------------------------------------------------

- (void)analyzeDirectory:(NSString*)path;
{
  
}

- (void)runInstallInDirectory:(NSString*)path
                   standardOutput:(void (^)(DSUnixTask *task, NSString *fragment))standardOutputHandler
                    standardError:(void (^)(DSUnixTask *task, NSString *fragment))standardErrorHandler
                          success:(void (^)(void))success
                          failure:(void (^)(NSError *error))failure;
{
  DSUnixTask *pod = [self createTask];
  [pod setArguments:@[@"install"]];
  [pod setWorkingDirectory:path];

  [pod setTerminationHandler:^(DSUnixTask *task) {
    if (task.terminationStatus == 0) {
      // TODO: pass the full log?
      success();
    } else {
      NSMutableDictionary *userInfo = [NSMutableDictionary new];
      userInfo[NSLocalizedDescriptionKey] = [NSString stringWithFormat:@"Unable to complete the installation in: %@", path];
      // TODO: add the error printed by CocoaPods.
      // TODO: add the full log.
      NSError *error = [NSError errorWithDomain:@"UnableTo" code:1 userInfo:userInfo];
      failure(error);
    }
  }];

  [pod setStandardOutputHandler:standardOutputHandler];
  [pod setStandardOutputHandler:standardErrorHandler];
  [pod launch];
}

- (void)runUpdateInDirectory:(NSString*)path
                  standardOutput:(void (^)(DSUnixTask *task, NSString *fragment))standardOutputHandler
                   standardError:(void (^)(DSUnixTask *task, NSString *fragment))standardErrorHandler
                         success:(void (^)(void))success
                         failure:(void (^)(NSError *error))failure;
{
  DSUnixTask *pod = [self createTask];
  [pod setArguments:@[@"update"]];
  [pod setWorkingDirectory:path];

  [pod setTerminationHandler:^(DSUnixTask *task) {
    if (task.terminationStatus == 0) {
      // TODO: pass the full log?
      success();
    } else {
      NSMutableDictionary *userInfo = [NSMutableDictionary new];
      userInfo[NSLocalizedDescriptionKey] = [NSString stringWithFormat:@"Unable to complete the installation in: %@", path];
      // TODO: add the error printed by CocoaPods.
      // TODO: add the full log.
      NSError *error = [NSError errorWithDomain:@"UnableTo" code:1 userInfo:userInfo];
      failure(error);
    }
  }];

  [pod setStandardOutputHandler:standardOutputHandler];
  [pod setStandardOutputHandler:standardErrorHandler];
  [pod launch];
}

//------------------------------------------------------------------------------
#pragma mark - Runnings tasks
//------------------------------------------------------------------------------

- (DSUnixTask *)createTask;
{
  DSUnixTask *task;
  if (self.config.useShell) {
    task = [DSUnixTaskSubProcessManager shellTask];
  } else {
    task = [DSUnixTaskSubProcessManager task];
  }
  [task setLaunchPath:self.config.launchPath];
  return task;
}

@end
