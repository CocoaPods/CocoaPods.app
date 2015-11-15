# DSUnixTask

DSUnixTask is a library for Mac OS X which allows to launch and interact with awesome looking UNIX tasks.

Features:

- Simple interface based on blocks.
- Process standard output and standard error in real-time.
- Easily send messages to standard input.
- Execute tasks either as sub-processes or through an XPC service.
- Execute throughout the user shell.
- Logging.


## Running a task as a sub-processes

##### Podfile:

```ruby
pod 'DSUnixTask/Core'
```

##### Usage:


```objective-c
#import <DSUnixTaskSubProcessManager.h>

- (void)runTasfk {
  [[DSUnixTaskSubProcessManager sharedManager] setLoggingEnabled:TRUE];
  DSUnixTask *task = [DSUnixTaskSubProcessManager shellTask];
  [task setCommand:@"/bin/cat"];
  [task setStandardOutputHandler:^(DSUnixTask *task, NSString *output) {
    NSLog(@"%@", output);
  }];
  [task launch];
  [task writeStringToStandardInput:@"Hi!"];
}
```

## XPC

##### XPC Service:

To create the target for the XPC service:

1. Use the XPC Service template.
2. Add a `Copy Files` build phase to the application.
  - Destination: `Wrapper`.
  - SubPath: `Contents/XPCServices`.
  - Copy the XPC service product
3. Add a dependency to your application’s build phases on the XPC Service.


##### Podfile:

```ruby
target 'MyApp' do
  pod 'DSUnixTask/XPCClient'
end

target 'XPCservice' do
  pod 'DSUnixTask/XPCService'
end
```

##### Usage:

###### Client:


```objective-c
#import <DSUnixTaskXPCManager.h>

- (void)runTask {
  [[DSUnixTaskXPCManager sharedManager] setServiceBundleIdentifier:@"com.compary.xpc-bundle-name"];
  [[DSUnixTaskXPCManager sharedManager] setLoggingEnabled:TRUE];
  DSUnixTask *task = [DSUnixTaskSubProcessManager shellTask];
  [task setCommand:@"/bin/cat"];
  [task setStandardOutputHandler:^(DSUnixTask *task, NSString *output) {
    NSLog(@"%@", output);
  }];
  [task launch];
  [task writeStringToStandardInput:@"Hi!"];
}
```

###### Service:

```objective-c
#include <Foundation/Foundation.h>
#import "DSUnixTaskServiceMain.h"

int main(int argc, const char *argv[]) {
  runUnixTaskXPCService();
}
```
