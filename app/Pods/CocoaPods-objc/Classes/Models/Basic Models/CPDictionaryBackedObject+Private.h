//
//  CPBaseModel+Hooks.h
//  CocoaPods-Core
//
//  Created by Fabio Pelosin on 28/02/13.
//  Copyright (c) 2013 CocoaPods. MIT License.
//

#import "CPDictionaryBackedObject.h"

/**
 This is a private header file intended for concrete classes of CPBaseModel.
*/
@interface CPDictionaryBackedObject ()

///-----------------------------------------------------------------------------
/// @name Backing Store
///-----------------------------------------------------------------------------

/**
 The backing store. The attributes are stored in a dictionary, instead of in
 instance variable because in this way the information of unknow attributes
 (to this library) is preserved.
 */
@property (strong) NSMutableDictionary* backingStore;

/**
 The designated initializer. Subclasses should convert the collection to mutable
 overriding this method.
 
 It also allows to share the same mutable dictionary for attributes exposed as
 objects as they can pass the same instace stored in the backing store of the
 owner.
 */
- (instancetype)initWithBackingStore:(NSMutableDictionary *)backingStore;

/**
 Sets a value in the baking store for the attribute with the given name.
 Subclasses should use this method to store attribute related information.
 */
- (void)setBackingStoreValue:(id)value forKey:(NSString *)key;

/**
 Returns the value from the baking store for the attribute with the given name.
 Subclasses should use this method to retrieve attribute related information
 */
- (id)backingStoreValueForKey:(NSString*)key;


///-----------------------------------------------------------------------------
/// @name Subclasses helpers
///-----------------------------------------------------------------------------

/**
 Wraps the given value in a dictionary if needed. If an object or a an array is 
 passed the object(s) are used as the keys pointing to NSNull as the keys carry
 information.
 */
NSDictionary* CPCoerceToDictionary(id value);

/**
 Wraps the given value to an array if needed.
*/
NSArray* CPCoerceToArray(id value);

/**
 Wraps the given value in a boolean NSNumber.
 */
NSNumber* CPCoerceToBoolean(id value);

@end
