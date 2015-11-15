//
//  CPVersion.m
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 01/03/13.
//  Copyright (c) 2013 CocoaPods. MIT License.
//

#import "CPVersion.h"

@implementation CPVersion

- (id)initWithString:(NSString*)string {
  self = [super init];
  if (self) {
    _string = string;
    _segments = [self segmentsFromString:string];
  }
  return self;
}

- (NSComparisonResult)compare:(CPVersion *)other {
  if ([self.string isEqualToString:other.string]) {
    return NSOrderedSame;
  }

  __block NSComparisonResult result = NSOrderedSame;
  [self.segments enumerateObjectsUsingBlock:^(NSString *segment, NSUInteger idx, BOOL *stop) {
    if ([other.segments count] > idx) {

      NSString *otherSegment = other.segments[idx];
      result = [segment compare:otherSegment options:NSNumericSearch];
      if (result != NSOrderedSame ) {
        *stop
        = true;
      }
    } else {
      *stop = true;
    }
  }];

  return result;
}

//------------------------------------------------------------------------------
#pragma mark - Private Helpers
//------------------------------------------------------------------------------

- (NSArray*)segmentsFromString:(NSString*)string {
  NSArray *stringSegments = [self scanString:string withPattern:@"[0-9]+|[A-Za-z]+"];
  return stringSegments;
}

- (NSArray*)scanString:(NSString*)string withPattern:(NSString*)pattern {
  NSMutableArray *result = [NSMutableArray array];
  NSError *error;
  NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:&error];
  if(error) {
    return @[];
  } else {
    NSRange range =  NSMakeRange(0, string.length);
    NSArray *textCheckingResults = [regex matchesInString:string options:0 range:range];
    for(NSTextCheckingResult *textCheckingResult in textCheckingResults) {
      [result addObject:[string substringWithRange:textCheckingResult.range]];
    }
    return [NSArray arrayWithArray:result];
  }
}

//------------------------------------------------------------------------------
#pragma mark - NSObject
//------------------------------------------------------------------------------

- (NSString *)description {
  return [NSString stringWithFormat:@"<%@: %@>", NSStringFromClass([self class]), self.string];
}

- (BOOL)isEqual:(id)object {
  if ([object isKindOfClass:[self class]]) {
    return [self.string isEqualTo:[object string]];
  }
  return false;
}

@end
