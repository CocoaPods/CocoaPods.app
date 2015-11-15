//
//  PODHelpers.h
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 02/03/13.
//  Copyright (c) 2013 CocoaPods. MIT License.
//

#import <Foundation/Foundation.h>

/**
 Returns the name of the directories in the given path ignoring hidden files.
*/
NSArray* CPDirsInPath(NSString* path);

/**
 Encodes a dictionary to YAML.
*/
NSData* CPEncodeToYAML(NSDictionary* dictionary);

/**
 Descodes a YAML string.
*/
NSMutableArray* CPDecodeYAMLString(NSString* yamlString);


/**
 Reads and decodes YAML file.
*/
NSMutableArray* CPReadYAMLFile(NSString* path);
