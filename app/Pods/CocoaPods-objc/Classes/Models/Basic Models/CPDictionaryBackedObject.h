//
//  CPBaseModel.h
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 28/02/13.
//  Copyright (c) 2013 CocoaPods. MIT License.
//

#import <Foundation/Foundation.h>

/**
 Provides support for working with YAML representations.

 This class stores the attributes in a dictionary (instead of in ivars) and
 for this reason is robusts against unknown attributes (they are left intact in
 the original dictionary). As a consequence the properties related to attributes
 should never use an instance variable but query the dictioonray store.

 *IMPORTANT*

 In the models of CocoaPods the keys are important and should never be discarded
 because they carry information. For example the platform attribute of the
 specification could be nil, could contain only a string (indicating only the
 name of the platform), or could contain a dictionary (the names as the key and
 the deployment targets as the values). The internal storage model
 */
@interface CPDictionaryBackedObject : NSObject

/**
 The designated initializer.

 @param dictionary
        The dictionary which contains the representation of the
        object.
 */
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

/**
 Convenience method to initialize the object from a YAML string.

 @param yamlString
        A string which contains the dictionary the representation of the
        object.
 */
- (instancetype)initWithYAML:(NSString*)yamlString;

/**
 Returns the dictionary representation of the object.
 */
- (NSDictionary*)dictionaryRepresentation;

/**
 Convenience method to serialize the object to a YAML string.
 */
- (NSData*)toYAML;

@end
