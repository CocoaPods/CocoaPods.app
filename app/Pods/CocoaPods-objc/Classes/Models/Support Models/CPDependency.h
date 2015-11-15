//
//  CPDependency.h
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 07/03/13.
//  Copyright (c) 2013 CocoaPods. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPDependency : NSObject

- (instancetype)initWithName:(NSString*)name requirements:(NSArray*)segments;

@property NSString *name;

@property (readonly) NSMutableArray *requirements;

@end
