//
//  CPSplashRecentDocumentsController.h
//  CocoaPods
//
//  Created by Orta Therox on 05/09/2015.
//  Copyright (c) 2015 CocoaPods. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

/// Handles the getting the recent documents from
/// the shared NSDocumentController

@interface CPSplashRecentDocumentsController : NSObject

/// Used in NSTableView via IB bindings
@property (readwrite, nonatomic, copy) NSArray *recentDocuments;

/// To register for control events
@property (weak) IBOutlet NSTableView *tableView;


@end
