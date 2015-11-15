//
//  DSUnixTaskClient.m
//
//  Created by Fabio Pelosin on 04/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. MIT License.
//

#import "DSUnixTaskClient.h"

@implementation DSUnixTaskClient

//------------------------------------------------------------------------------
#pragma mark DSUnixTaskClientInterface
//------------------------------------------------------------------------------

- (void)taskWithIdentifier:(int)processIdentifier didReceiveStandardOutputData:(NSData*)data;
{
  [self.delegate taskWithIdentifier:processIdentifier didReceiveStandardOutputData:data];
}

- (void)taskWithIdentifier:(int)processIdentifier didReceiveStandardErrorData:(NSData*)data;
{
  [self.delegate taskWithIdentifier:processIdentifier didReceiveStandardErrorData:data];
}

- (void)taskWithIdentifier:(int)processIdentifier didTerminateWithStatus:(int)terminationStatus;
{
  [self.delegate taskWithIdentifier:processIdentifier didTerminateWithStatus:terminationStatus];
}


@end
