//
//  CPConfig.m
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 03/03/13.
//  Copyright (c) 2013 CocoaPods. All rights reserved.
//

#import "CPConfig.h"
#import "CPSourceAggregate.h"

@implementation CPConfig

NSString *const kCPMinimumRequiredCocoaPodsBinaryVersion = @"0.17.0.rc2";

- (id)init
{
  self = [super init];
  if (self) {
    _launchPath = @"pod";
    _useShell = true;
    _reposDir = [NSHomeDirectory() stringByAppendingPathComponent:@".cocoapods"];
    _minimumSupportedCocoaPodsVersion  = kCPMinimumRequiredCocoaPodsBinaryVersion;
    _sourceAggregate = [[CPSourceAggregate alloc] initWithPath:_reposDir];
  }
  return self;
}

- (CPSource*)masterRepo {
  return [self.sourceAggregate sourceWithName:@"master"];
}

@end
