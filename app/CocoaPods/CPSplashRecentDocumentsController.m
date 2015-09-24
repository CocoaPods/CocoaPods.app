//
//  CPSplashRecentDocumentsController.m
//  CocoaPods
//
//  Created by Orta Therox on 05/09/2015.
//  Copyright (c) 2015 CocoaPods. All rights reserved.
//

#import "CPSplashRecentDocumentsController.h"


@interface _CPSplashDocument : NSObject <NSCopying>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSURL *podfileURL;
@property (nonatomic, copy) NSImage *image;
@property (nonatomic, copy) NSString *folderPath;
@end

@implementation _CPSplashDocument

// Needed for using Cocoa Bindings

- (instancetype)copyWithZone:(NSZone *)zone
{
  _CPSplashDocument *copy = [[[self class] alloc] init];
  if (copy) {
    [copy setName:[self.name copyWithZone:zone]];
    [copy setPodfileURL:[self.podfileURL copyWithZone:zone]];
    [copy setImage:[self.image copyWithZone:zone]];
    [copy setFolderPath:[self.folderPath copyWithZone:zone]];
  }
  
  return copy;
}

@end

@implementation CPSplashRecentDocumentsController

- (void)awakeFromNib
{
  [super awakeFromNib];
    
  [self.tableView setTarget:self];
  [self.tableView setDoubleAction:@selector(didDoubleTapOnRecentItem:)];
  [self setupRecentDocuments];
}

- (void)setupRecentDocuments
{
  NSDocumentController *controller = [NSDocumentController sharedDocumentController];
  NSMutableArray *documents = [NSMutableArray arrayWithCapacity:controller.recentDocumentURLs.count];
  for (NSURL *url in controller.recentDocumentURLs) {
    [documents addObject:[self projectDetailsAtURL:url]];
  }
  
  self.recentDocuments = documents;
}

- (_CPSplashDocument *)projectDetailsAtURL:(NSURL *)url
{
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSArray *dirFiles = [fileManager contentsOfDirectoryAtURL:[url URLByDeletingLastPathComponent] includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsSubdirectoryDescendants error:nil];
  NSURL *workspaceURL = [[dirFiles filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.absoluteString ENDSWITH '.xcworkspace/'"]] firstObject];
  NSURL *projectURL = [[dirFiles filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.absoluteString ENDSWITH '.xcodeproj/'"]] firstObject];
  NSURL *bestURL = workspaceURL ?: projectURL ?: url;
  
  _CPSplashDocument *document = [_CPSplashDocument new];
  document.name = [bestURL lastPathComponent];
  document.folderPath = [[bestURL pathComponents] componentsJoinedByString:@"/"];
  document.image = [[NSWorkspace sharedWorkspace] iconForFile:bestURL.absoluteString];
  document.podfileURL = url;
  return document;
}

- (void)didDoubleTapOnRecentItem:(NSTableView *)sender {
  NSInteger row = [sender clickedRow];
  _CPSplashDocument *item = self.recentDocuments[row];
  
  NSDocumentController *controller = [NSDocumentController sharedDocumentController];
  [controller openDocumentWithContentsOfURL:item.podfileURL display:YES completionHandler:^(NSDocument *document, BOOL documentWasAlreadyOpen, NSError *error) {
    // nothing for now
  }];
}

@end
