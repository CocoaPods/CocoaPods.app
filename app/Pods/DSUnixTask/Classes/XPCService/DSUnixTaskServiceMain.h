//
//  DSUnixTaskServiceMain.h
//
//  Created by Fabio Pelosin on 04/03/13.
//  Copyright (c) 2013 Discontinuity s.r.l. unipersonale. MIT License.
//

#import <Foundation/Foundation.h>

//------------------------------------------------------------------------------
// Main
//------------------------------------------------------------------------------

/**
 Helper function to be called in the main() function of the XPC Service. (It would
 suffice as the whole body of the function).
*/
void runUnixTaskXPCService();

//------------------------------------------------------------------------------
// DSUnixTaskXPCListenerDelegate
//------------------------------------------------------------------------------

/**
 The delegate of the executable XPC service.
 */
@interface DSUnixTaskXPCListenerDelegate : NSObject <NSXPCListenerDelegate>

@end
