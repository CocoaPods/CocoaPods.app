#import "CPPodfileIPCTask.h"
#import <CocoaPods_objc/CPPodfile.h>
#import <YAML_Framework/YAMLSerialization.h>

@interface CPPodfileIPCTask ()
@property (nonatomic, copy) void (^completionBlock)(CPPodfile *podfile);
@end

@implementation CPPodfileIPCTask

- (instancetype)initWithUserProject:(CPUserProject *)userProject
                         completion:(void (^)(CPPodfile *podfile))completionBlock;
{
  self = [super initWithUserProject:userProject
                            command:@"ipc podfile Podfile"
                           delegate:self
                   qualityOfService:NSQualityOfServiceUtility];
  if (self) {
    self.completionBlock = completionBlock;
  }

  return self;
}

- (void)taskDidFinish:(NSAttributedString *)output {
  NSDictionary *podfileDictionary = [YAMLSerialization objectWithYAMLString:output.string
                                                                    options:kYAMLReadOptionStringScalars
                                                                      error:nil];

  CPPodfile *podfile = [[CPPodfile alloc] initWithDictionary:podfileDictionary];

  if (self.completionBlock) {
    self.completionBlock(podfile);
  }
}

@end
