//
//  DSUnixTaskAbstractManager+Private.h
//  DSUnixTask
//
//  Created by Fabio Pelosin on 05/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. All rights reserved.
//

#import "DSUnixTaskAbstractManager.h"
#import "DSUnixTask+ManagerInterface.h"
#import "DSUnixTaskAbstractManager+TaskInterface.h"

/**
 The private interface available for concrete subclasses.
 */
@interface DSUnixTaskAbstractManager (SubclassesInterface)

- (void)log:(NSString*)format, ... NS_FORMAT_FUNCTION(1,2);

- (void)logGood:(NSString*)format, ... NS_FORMAT_FUNCTION(1,2);

- (void)logBad:(NSString*)format, ... NS_FORMAT_FUNCTION(1,2);

- (NSString*)taskToLog:(DSUnixTask *)task;

- (NSString*)dataToString:(NSData *)data;

- (NSString*)keyForProcessIdentifier:(int)processIdentifier;

@end

/**
 Subclasses need to adopt it.
 */
@protocol DSUnixTaskManagerConcreteInstance <NSObject>

- (void)concreteWriteDataToStandardInput:(NSData*)data ofTask:(DSUnixTask*)task;

- (void)concreteSendEOFToStandardInputOfTask:(DSUnixTask*)task;

- (void)concreteLaunchTask:(DSUnixTask*)task;

- (BOOL)concretePrepareToWriteToStandardInput:(DSUnixTask*)task;

@end
