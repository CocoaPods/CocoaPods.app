//
//  DSUnixTaskServiceMain.m
//
//  Created by Fabio Pelosin on 04/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. MIT License.
//

#import "DSUnixTaskServiceMain.h"
#import "DSUnixTaskInterfaces.h"
#import "DSUnixTaskService.h"

//------------------------------------------------------------------------------
#pragma mark Main
//------------------------------------------------------------------------------

/*
 The resume method never returns.
 */
void runUnixTaskXPCService() {
  NSXPCListener *listener = [NSXPCListener serviceListener];
  DSUnixTaskXPCListenerDelegate *delegate = [DSUnixTaskXPCListenerDelegate new];
  listener.delegate = delegate;
  [listener resume];
  exit(EXIT_FAILURE);
}

//------------------------------------------------------------------------------
#pragma mark Delegate
//------------------------------------------------------------------------------

@implementation DSUnixTaskXPCListenerDelegate

/*
 Creates a new exported object and sets its reference to the client proxy.
 */
- (BOOL)listener:(NSXPCListener *)listener shouldAcceptNewConnection:(NSXPCConnection *)newConnection;
{
  DSUnixTaskService *exportedObject = [DSUnixTaskService new];
  NSXPCInterface *interface = [NSXPCInterface interfaceWithProtocol:@protocol(DSUnixTaskServiceInterface)];
  NSXPCInterface *remoteIterface = [NSXPCInterface interfaceWithProtocol:@protocol(DSUnixTaskClientInterface)];
  [newConnection setExportedObject:exportedObject];
  [newConnection setExportedInterface:interface];
  [newConnection setRemoteObjectInterface: remoteIterface];
  [newConnection resume];
  exportedObject.clientProxy = [newConnection remoteObjectProxy];
  return YES;
};

@end
