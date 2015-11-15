//
//  DSUnixTaskClient.h
//
//  Created by Fabio Pelosin on 04/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. MIT License.
//

#import <Foundation/Foundation.h>
#import "DSUnixTaskInterfaces.h"

@protocol DSUnixTaskClientDelegate;

/**
 This class is the exported object of the XPC Client and simply forwards the
 messages to its delegate.
 */
@interface DSUnixTaskClient : NSObject <DSUnixTaskClientInterface>

@property (weak) id<DSUnixTaskClientInterface> delegate;

@end
