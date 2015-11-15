//
//  CPSourceAggreagate.m
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 02/03/13.
//  Copyright (c) 2013 CocoaPods. MIT License.
//

#import "CPSourceAggregate.h"
#import "CPHelpers.h"
#import "CPSet.h"
#import "CPSource.h"

@implementation CPSourceAggregate {
  NSArray* _sources;
}

- (instancetype)initWithPath:(NSString*)path {
  self = [super init];
  if (self) {
    _path = path;
  }
  return self;
}

- (NSArray*)sources {
  if (!_sources) {
    NSMutableArray *result = [NSMutableArray new];
    NSArray *repos = CPDirsInPath(self.path);
    [repos enumerateObjectsUsingBlock:^(NSString *repo, NSUInteger idx, BOOL *stop) {
      NSString *repoPath = [self.path stringByAppendingPathComponent:repo];
      CPSource *source = [[CPSource alloc] initWithRepoPath:repoPath];
      [result addObject:source];
    }];
    _sources = [result copy];
  }
  return _sources;
}

- (NSArray*)sets {
  NSMutableArray *result = [NSMutableArray new];
  NSArray *pods = [self pods];
  [pods enumerateObjectsUsingBlock:^(NSString* pod, NSUInteger idx, BOOL *stop) {
    CPSet *set = [[CPSet alloc] initWithName:pod sources:self.sources];
    [result addObject:set];
  }];
  return result;
}

- (CPSource*)sourceWithName:(NSString*)name {
  NSUInteger index = [self.sources indexOfObjectPassingTest:^BOOL(CPSource *source, NSUInteger idx, BOOL *stop) {
    return [source.name isEqualToString:name];
  }];
  if (index == NSNotFound) {
    return nil;
  } else {
    return self.sources[index];
  }
}

//------------------------------------------------------------------------------
#pragma mark - Private Helpers
//------------------------------------------------------------------------------

/**
 Returns the names of the Pods known to all the sources.
*/
- (NSArray*)pods {
  NSMutableArray *result = [NSMutableArray new];
  NSArray *sources = [self sources];
  [sources enumerateObjectsUsingBlock:^(CPSource *source, NSUInteger idx, BOOL *stop) {
    NSArray *pods = [source pods];
    [result addObjectsFromArray:pods];
  }];
  return [result valueForKeyPath:@"@distinctUnionOfObjects.self"];
}

@end
