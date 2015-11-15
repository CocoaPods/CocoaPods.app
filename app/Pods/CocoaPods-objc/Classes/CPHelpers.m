//
//  PODHelpers.m
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 02/03/13.
//  Copyright (c) 2013 CocoaPods. MIT License.
//

#import "CPHelpers.h"
#import <YAML-Framework/YAMLSerialization.h>

NSArray* CPDirsInPath(NSString* path) {
  NSMutableArray *result = [NSMutableArray new];
  NSArray *children =[[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
  [children enumerateObjectsUsingBlock:^(NSString *child, NSUInteger idx, BOOL *stop) {
    BOOL isDir;
    NSString *childPath = [path stringByAppendingPathComponent:child];
    [[NSFileManager defaultManager] fileExistsAtPath:childPath isDirectory:&isDir];
    BOOL isHidden = [child hasPrefix:@"."];
    if (isDir && !isHidden) {
      [result addObject:child];
    }
  }];
  return result;
}

NSData* CPEncodeToYAML(NSDictionary* dictionary) {
  NSError *error;
  NSData *data = [YAMLSerialization dataFromYAML:dictionary options:kYAMLWriteOptionSingleDocument error:&error];
  return data;
}

NSMutableArray* CPDecodeYAMLString(NSString* yamlString) {
  NSData* data = [yamlString dataUsingEncoding:NSUTF8StringEncoding];
  NSError *error;
  NSMutableArray *result = [YAMLSerialization YAMLWithData:data options:kYAMLReadOptionStringScalars|kYAMLReadOptionImmutable error:&error];
  if (error) {
    NSLog(@"%@", error);
  }
  return result;
}

NSMutableArray* CPReadYAMLFile(NSString* path) {
  NSData *data = [NSData dataWithContentsOfFile:path];
  NSError *error;
  NSMutableArray *result = [YAMLSerialization YAMLWithData:data options:kYAMLReadOptionStringScalars|kYAMLReadOptionImmutable error:&error];
  if (error) {
    NSLog(@"%@", error);
  }
  return result;
}

//@implementation NSArray (BlockRockinBeats)
//
//- (NSArray*)mappedWithBlock:(id (^)(id obj, NSUInteger idx))block {
//  NSMutableArray* result = [NSMutableArray arrayWithCapacity:self.count];
//  [self enumerateObjectsUsingBlock:^(id currentObject, NSUInteger index, BOOL *stop) {
//    id mappedCurrentObject = block(currentObject, index);
//    if (mappedCurrentObject)
//    {
//      [result addObject:mappedCurrentObject];
//    }
//  }];
//  return result;
//}
//
//@end

