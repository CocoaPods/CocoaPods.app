#import "CPAppDelegate.h"
#import "CPCLIToolInstallationController.h"
#import "CPSplashWindowController.h"

NSString * const kCPCLIToolSuggestedDestination = @"/usr/local/bin/pod";

@interface CPAppDelegate ()
@property (nonatomic, strong, readonly) CPSplashWindowController *splashWindowController;
@end

@implementation CPAppDelegate

#pragma mark - NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification;
{
#ifdef DEBUG
  //[[NSUserDefaults standardUserDefaults] removeObjectForKey:kCPRequestCLIToolInstallationAgainKey];
  //[[NSUserDefaults standardUserDefaults] removeObjectForKey:kCPCLIToolInstalledToDestinationsKey];
  //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CPShowVerboseCommandOutput"];
  //NSLog(@"%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
#endif

  _splashWindowController = [[CPSplashWindowController alloc] initWithWindowNibName:@"CPSplashWindowController"];
  [self.splashWindowController showWindow:self];
}

#pragma mark - Actions

- (IBAction)openGuides:(id)sender;
{
  [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://guides.cocoapods.org/"]];
}

- (IBAction)openPodspecReference:(id)sender;
{
  NSURL *URL = [NSURL URLWithString:@"http://guides.cocoapods.org/syntax/podspec.html"];
  [[NSWorkspace sharedWorkspace] openURL:URL];
}

- (IBAction)openPodfileReference:(id)sender;
{
  NSURL *URL = [NSURL URLWithString:@"http://guides.cocoapods.org/syntax/podfile.html"];
  [[NSWorkspace sharedWorkspace] openURL:URL];
}

- (IBAction)installBinstubIfNecessary:(id)sender;
{
  [[self CLIToolInstallationController] installBinstub];
}

#pragma mark - Private

- (CPCLIToolInstallationController *)CLIToolInstallationController;
{
  NSURL *destinationURL = [NSURL fileURLWithPath:kCPCLIToolSuggestedDestination];
  return [CPCLIToolInstallationController controllerWithSuggestedDestinationURL:destinationURL];
}

@end
