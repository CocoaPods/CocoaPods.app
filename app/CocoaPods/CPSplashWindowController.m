//
//  CPSplashWindowController.m
//  CocoaPods
//
//  Created by Orta Therox on 05/09/2015.
//  Copyright (c) 2015 CocoaPods. All rights reserved.
//

#import "CPSplashWindowController.h"

@interface CPSplashWindowController ()
@property (weak) IBOutlet NSTextField *cocoapodsVersionTextField;
@end

@implementation CPSplashWindowController

- (void)windowDidLoad {
  [super windowDidLoad];
  NSString *versionNumber = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
  self.cocoapodsVersionTextField.stringValue = versionNumber;
}


@end
