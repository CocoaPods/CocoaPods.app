//
//  DSUnixTaskService.h
//
//  Created by Fabio Pelosin on 04/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. MIT License.
//

#import <Foundation/Foundation.h>
#import "DSUnixTaskInterfaces.h"

/**
 The object exported in the XPC connection by the server. It is responsible of 
 creating the task runners and dispatching the messages to them as well as 
 forwarding their messages.
 */
@interface DSUnixTaskService : NSObject  <DSUnixTaskServiceInterface>

@property id<DSUnixTaskClientInterface> clientProxy;

@end
