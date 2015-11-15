//
//  CPReplManager.m
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 06/03/13.
//  Copyright (c) 2013 CocoaPods. All rights reserved.
//

#import <DSUnixTaskSubProcessManager.h>
#import "CPReplManager.h"
#import "CPHelpers.h"
#import "CPSpecification.h"
#import "CPPodfile.h"

NSString * const kReplReadyString = @"\n\r";

typedef NS_ENUM(NSUInteger, CPReplCommand) {
  CPNullReplComman = 0,
  CPVersionReplCommand,
  CPListReplCommand,
  CPSpecificiationReplCommand,
  CPPodfileReplCommand,
};

//------------------------------------------------------------------------------

@interface CPReplManager ()

/*
 The task of the CocoaPods REPL process.
 */
@property DSUnixTask *replTask;

/*
 The queue of the requests stored as dictionaries.
 */
@property NSMutableArray *requestsQueue;

/*
 The current request.
 */
@property NSDictionary *currentRequest;

/*
 The output since the last request.
 */
@property NSMutableString *outputCurrentReadingOperation;

@property (readwrite) NSString *cocoaPodsVersion;

@end

//------------------------------------------------------------------------------

@implementation CPReplManager

//------------------------------------------------------------------------------
#pragma mark - Initialization & Configuration
//------------------------------------------------------------------------------

// TODO: Change to init with task
- (id)init
{
  self = [super init];
  if (self) {
    _launchPath = @"pod";
    _useShell = true;
    _requestsQueue = [NSMutableArray new];
  }
  return self;
}

//------------------------------------------------------------------------------
#pragma mark - Launching the REPL
//------------------------------------------------------------------------------

- (void)launch;
{
  DSUnixTask *repl;
  if (self.useShell) {
    repl = [DSUnixTaskSubProcessManager shellTask];
  } else {
    repl = [DSUnixTaskSubProcessManager task];
  }

  __weak CPReplManager *weakSelf = self;
  NSString *command = [NSString stringWithFormat:@"%@ ipc repl", self.launchPath];
  [repl setCommand:command];

  [repl setStandardOutputHandler:^(DSUnixTask *task, NSString *output) {
    [weakSelf readReplOutput:output];
  }];

  [repl setLaunchFailureHandler:^(DSUnixTask *task, NSString *reason) {
    NSAlert *alert = [NSAlert new];
    [alert setMessageText:reason];
    [alert runModal];
  }];

  [repl setFailureHandler:^(DSUnixTask *task) {
    NSAlert *alert = [NSAlert new];
    [alert setMessageText:@"The repl failed"];
    [alert runModal];
  }];

  NSMutableDictionary *dictionary = [NSMutableDictionary new];
  dictionary[@"readingState"] = [NSNumber numberWithInteger:CPVersionReplCommand];
  [self setCurrentRequest:dictionary];

  [self setReplTask:repl];
  [self.replTask launch];
}

//------------------------------------------------------------------------------
#pragma mark -
//------------------------------------------------------------------------------

- (void)loadSearchInformationWithblock:(void (^)(NSDictionary *searchDataByName))block;
{
  NSString *replCommand = [NSString stringWithFormat:@"list"];
  [self enqueuRequestWithCommand:replCommand withReadingState:CPListReplCommand block:block];
}

- (void)loadSpecificationWithPath:(NSString*)path block:(void (^)(CPSpecification *spec))block;
{
  NSString *replCommand = [NSString stringWithFormat:@"spec %@", path];
  [self enqueuRequestWithCommand:replCommand withReadingState:CPSpecificiationReplCommand block:block];
}

- (void)loadPodfileWithPath:(NSString*)path block:(void (^)(CPPodfile *podfile))block;
{
  NSString *replCommand = [NSString stringWithFormat:@"podfile %@", path];
  [self enqueuRequestWithCommand:replCommand withReadingState:CPPodfileReplCommand block:block];
}


//------------------------------------------------------------------------------
#pragma mark - Private Helpers
//------------------------------------------------------------------------------

- (NSDictionary*)dictionaryForRequestWithCommand:(NSString*)command withReadingState:(CPReplCommand)readingState block:(void (^)(id returnvalue))block;
{
  NSMutableDictionary *dictionary = [NSMutableDictionary new];
  dictionary[@"command"] = command;
  dictionary[@"readingState"] = [NSNumber numberWithInteger:readingState];
  dictionary[@"block"] = block;
  return dictionary;
}

- (void)enqueuRequestWithCommand:(NSString*)command withReadingState:(CPReplCommand)readingState block:(void (^)(id returnvalue))block;
{
  NSDictionary *dictionary = [self dictionaryForRequestWithCommand:command withReadingState:readingState block:block];
  [self.requestsQueue addObject:dictionary];
  [self dequeueNextRequest];
}

/*
 If the REPL task has not been set yet the request needs to be queued. After
 it gets the version the request will be performed.
 */
- (void)dequeueNextRequest;
{
  if (!self.currentRequest && [self.requestsQueue count] != 0 && self.replTask) {
    NSDictionary *request = [self.requestsQueue objectAtIndex:0];
    [self.requestsQueue removeObjectAtIndex:0];
    [self setCurrentRequest:request];
    [self __executeCurrentRequest];
  }
}

/*
 This should be called only by dequeueNextRequest;
 */
- (void)__executeCurrentRequest;
{
  NSString *command = [NSString stringWithFormat:@"%@\n", self.currentRequest[@"command"]];
  [self.replTask writeStringToStandardInput:command];
}

/*
 Accumulates the output from the REPL unitl it finds the string indicating that
 the REPL it is ready. In this case it sends the appropriate callbacks and 
 dequeues the next request.
 */
- (void)readReplOutput:(NSString*)output;
{
  if (!self.outputCurrentReadingOperation) {
    [self setOutputCurrentReadingOperation:[NSMutableString new]];
  }
  [self.outputCurrentReadingOperation appendString:output];
  if ([self.outputCurrentReadingOperation rangeOfString:kReplReadyString].location != NSNotFound) {
    [self processOutput];
    [self setCurrentRequest:nil];
    [self dequeueNextRequest];
  }
}

/*
 Reads the YAML data returned by the REPL, converts it to the apporpriate object,
 and calls the currentCallback.
 */
- (void)processOutput;
{
  NSMutableString *yaml = self.outputCurrentReadingOperation;
  NSRange range = NSMakeRange(0, yaml.length);
  self.outputCurrentReadingOperation = nil;
  NSString *stringToReplace = [NSString stringWithFormat:@"\n%@", kReplReadyString];
  [yaml replaceOccurrencesOfString:stringToReplace withString:@"" options:0 range:range];
  NSDictionary *yamlData = [CPDecodeYAMLString(yaml) objectAtIndex:0];

  CPReplCommand readingState = [self.currentRequest[@"readingState"] longValue];
  void (^block)(id returnvalue) = self.currentRequest[@"block"];
  
  //NSLog(@"yamlData: %@", yamlData);
  switch (readingState) {
    case CPVersionReplCommand: {
      NSString *version = yamlData[@"version"];
      [self setCocoaPodsVersion: version];
      break;
    }

    case CPSpecificiationReplCommand: {
      CPSpecification *spec = [[CPSpecification alloc] initWithDictionary:yamlData];
      block(spec);
      break;
    }

    case CPPodfileReplCommand: {
      CPPodfile *podfile = [[CPPodfile alloc] initWithDictionary:yamlData];
      block(podfile);
      break;
    }

    case CPListReplCommand: {
      block(yamlData);
      break;
    }

    case CPNullReplComman: {
      NSException *exception = [NSException exceptionWithName:@"CPInconsistentState" reason:@"A bug!" userInfo:nil];
      [exception raise];
      break;
    }
  }
}

@end
