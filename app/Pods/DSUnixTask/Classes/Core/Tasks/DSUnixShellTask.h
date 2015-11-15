//
//  DSShellTaskLauncher.h
//  Demo
//
//  Created by Fabio Pelosin on 04/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. MIT License.
//

#import "DSUnixTask.h"

/**
 Executes a task with the user shell. The shell is instructed to launch as
 interactive to source all the user files. This allows setups like the one of
 the Ruby Version Manager (RVM) to function properly.

 If the task fails to locate the user shell it raises.
 */
@interface DSUnixShellTask : DSUnixTask

@end
