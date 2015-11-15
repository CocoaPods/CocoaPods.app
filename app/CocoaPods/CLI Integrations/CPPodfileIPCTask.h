#import "CPCLITask.h"

@class CPPodfile;

/**
 Task that wraps calling `pod ipc podfile Podfile`, which is
 used to generate the YAML description of a Podfile.
 */
@interface CPPodfileIPCTask : CPCLITask <CPCLITaskDelegate>

- (instancetype)initWithUserProject:(CPUserProject *)userProject
                         completion:(void (^)(CPPodfile *podfile))completionBlock;

@end
