//
//  CPSource.m
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 02/03/13.
//  Copyright (c) 2013 CocoaPods. MIT License.
//

#import "CPSource.h"
#import "CPHelpers.h"

@implementation CPSource {
  NSDictionary* _versionDictionary;
}

//------------------------------------------------------------------------------
#pragma mark - Initialization
//------------------------------------------------------------------------------

- (instancetype)initWithRepoPath:(NSString *)repoPath {
  self = [super init];
  if (self) {
    _repoPath = repoPath;
  }
  return self;
}

-(NSString *)name {
  return [self.repoPath lastPathComponent];
}

//------------------------------------------------------------------------------
#pragma mark - Pods Information
//------------------------------------------------------------------------------

- (NSArray*)pods {
  return CPDirsInPath(self.repoPath);
}

- (NSArray*)versionsForPod:(NSString*)name {
  NSString *podPath = [self.repoPath stringByAppendingPathComponent:name];
  return CPDirsInPath(podPath);
}

//------------------------------------------------------------------------------
#pragma mark - Specifications
//------------------------------------------------------------------------------

- (NSString*)specificationPathForPod:(NSString*)pod withVersion:(NSString*)version {
  NSString *podPath = [self.repoPath stringByAppendingPathComponent:pod];
  NSString *versionPath = [podPath stringByAppendingPathComponent:version];
  NSString *specBaseNamePath = [versionPath stringByAppendingPathComponent:pod];
  NSString *specPath = [specBaseNamePath stringByAppendingString:@".podspec"];
  NSString *yamlPodspec = [specPath stringByAppendingString:@".yaml"];

  if ([[NSFileManager defaultManager] fileExistsAtPath:yamlPodspec]) {
    return yamlPodspec;
  } else {
    return specPath;
  }
}

//------------------------------------------------------------------------------
#pragma mark - CocoaPods versions
//------------------------------------------------------------------------------

- (NSString*)lastKnownVersion {
  return [self versionDictionary][@"last"];
}

- (NSString*)minimunRequiredVersion {
  return [self versionDictionary][@"min"];
}

//------------------------------------------------------------------------------
#pragma mark - Private helpers
//------------------------------------------------------------------------------

/**
 Returns the contents of the `CocoaPods-version.yml` file.
*/
- (NSDictionary*)versionDictionary {
  if (!_versionDictionary) {
    NSString *versionFile = @"CocoaPods-version.yml";
    NSString *path = [self.repoPath stringByAppendingPathComponent:versionFile];
    NSMutableArray *versionData = CPReadYAMLFile(path);
    _versionDictionary = versionData[0];
  }
  return _versionDictionary;
}


@end
