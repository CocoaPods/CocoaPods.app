//
//  DSDSUnixTaskLocalManager.h
//  DSUnixTask
//
//  Created by Fabio Pelosin on 05/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. All rights reserved.
//

#import "DSUnixTaskAbstractManager.h"

/**
 Run tasks as subprocesses of the calling application.
 
 This class interfaces directly with `DSUnixTaskRunner` and thush serves only 
 as a messages displatcher.
 */
@interface DSUnixTaskSubProcessManager : DSUnixTaskAbstractManager

+ (instancetype)sharedManager;

@end
