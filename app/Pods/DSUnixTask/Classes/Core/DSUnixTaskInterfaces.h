//
//  DSUnixTaskInterfaces.h
//
//  Created by Fabio Pelosin on 04/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. MIT License.
//

//------------------------------------------------------------------------------
// Client
//------------------------------------------------------------------------------

/**
 The interface for the client.
 */
@protocol DSUnixTaskClientInterface <NSObject>

@required

/**
 Called when the process terminates.
 */
- (void)taskWithIdentifier:(int)processIdentifier didTerminateWithStatus:(int)terminationStatus;

/**
 Called when the process receives standard output.
 @param standardOutput The fragment of standard output received.
 */
- (void)taskWithIdentifier:(int)processIdentifier didReceiveStandardOutputData:(NSData*)data;

/**
 Called when the process receives standard error.
 @param standardError The fragment of standard error received.
 */
- (void)taskWithIdentifier:(int)processIdentifier didReceiveStandardErrorData:(NSData*)data;

@end

//------------------------------------------------------------------------------
// Service
//------------------------------------------------------------------------------

/**
 The interface for the service providing the task. The service can be located
 in the same application or in another context like an XPC Service.
 */
@protocol DSUnixTaskServiceInterface <NSObject>

@required

/**
 Launches the process with the given path.
 
 @param launchPath The launch path of the process.
 @param arguments The arguments to pass to the process.
 @param workingDirectory The working directory for the process.
 @param environment The environment to add to the process.
 @param result A block which yields one argument the process identifier. If the process failed to launch the process identifier is set to 0 (this pid is reserved in Unix systems and thus it can't be allocated to the launching task).
 */
- (void)launchProccessWithPath:(NSString*)launchPath
                     arguments:(NSArray *)arguments
              workingDirectory:(NSString *)workingDirectory
                   environment:(NSDictionary*)environment
                        result:(void (^)(int processIdentifier, NSString* lauchExceptionReason))result;

/**
 Sends data to the standard input of the process.

 @param data The data to pass.
 @param processIdentifier The identifier of the process which should receive the data.
 */
- (void)writeDataToStandardInput:(NSData *)data ofProcessWithIdentifier:(int)processIdentifier;

/**
 Closes the standard input file handle.

 @param processIdentifier The identifier of the process which should receive the data.
 */
- (void)sendEOFToStandardInputofProcessWithIdentifier:(int)processIdentifier;

@end
