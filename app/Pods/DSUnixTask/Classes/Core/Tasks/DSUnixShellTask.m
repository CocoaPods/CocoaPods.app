//
//  DSShellTaskLauncher.m
//  Demo
//
//  Created by Fabio Pelosin on 04/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. MIT License.
//

#import "DSUnixShellTask.h"

@implementation DSUnixShellTask

//------------------------------------------------------------------------------
#pragma mark Subclasses hooks
//------------------------------------------------------------------------------

/*
 The path of the user shell
 */
- (NSString *)effectiveLaunchPath;
{
  NSString *shell = _userShell();
  if (!shell) {
    [[NSException exceptionWithName:@"DSShellTaskException" reason:@"Unable to find an user shell" userInfo:nil] raise];
  }
  return shell;}

/*
 The arguments to pass to the shell. The arguments instruct the shell to run
 the launch path of the task with its arguments (for this reason they are
 merged in a single string).
 */
- (NSArray *)effectiveArguments;
{
  NSMutableArray *arguments = [NSMutableArray new];
  NSMutableArray *shellExecutionArguments = [NSMutableArray new];
  [shellExecutionArguments addObject:self.launchPath];
  [shellExecutionArguments addObjectsFromArray:self.arguments];
  [arguments addObjectsFromArray:[self _shellDefaultAguments]];
  [arguments addObject:[shellExecutionArguments componentsJoinedByString:@" "]];
  return arguments;}

//------------------------------------------------------------------------------
#pragma mark Private helpers
//------------------------------------------------------------------------------

/*
 The absolute path of the user login shell.
 */
static NSString* _userShell() {
  NSDictionary *environmentDict = [[NSProcessInfo processInfo] environment];
  return [environmentDict objectForKey:@"SHELL"];
}

/*
 The default arguments to pass to the shell.

 * `-i` source initialization files like `zshrc` which are used by
 RVM.
 * `-c` take next argument as a command to execute.

 For more information about shell initialization see:

 - https://github.com/sstephenson/rbenv/wiki/Unix-shell-initialization
 - http://zsh.sourceforge.net/Guide/zshguide02.html
 */
- (NSArray*)_shellDefaultAguments {
  return @[@"-i", @"-c"];
}



@end
