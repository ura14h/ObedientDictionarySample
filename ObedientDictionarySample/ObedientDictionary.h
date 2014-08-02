//
//  ObedientDictionary.h
//
//  Created by Hiroki Ishiura on 2014/08/02.
//  Copyright (c) 2014 Hiroki Ishiura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObedientDictionary : NSObject <NSCopying, NSMutableCopying, NSSecureCoding, NSFastEnumeration>

- (NSUInteger)count;
- (id)objectForKey:(id)aKey;
- (NSEnumerator *)keyEnumerator;

@end

@interface ObedientDictionary (DictionaryCreation)

+ (instancetype)dictionary;
//+ (instancetype)dictionaryWithObject:(id)object forKey:(id <NSCopying>)key;
//+ (instancetype)dictionaryWithObjects:(const id [])objects forKeys:(const id <NSCopying> [])keys count:(NSUInteger)cnt;
//+ (instancetype)dictionaryWithObjectsAndKeys:(id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;
//+ (instancetype)dictionaryWithDictionary:(NSDictionary *)dict;
//+ (instancetype)dictionaryWithObjects:(NSArray *)objects forKeys:(NSArray *)keys;
- (instancetype)init;
//- (instancetype)initWithObjects:(const id [])objects forKeys:(const id <NSCopying> [])keys count:(NSUInteger)cnt;
- (instancetype)initWithObjectsAndKeys:(id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;
//- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary;
//- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary copyItems:(BOOL)flag;
- (instancetype)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys;
//+ (id)dictionaryWithContentsOfFile:(NSString *)path;
//+ (id)dictionaryWithContentsOfURL:(NSURL *)url;
//- (id)initWithContentsOfFile:(NSString *)path;
//- (id)initWithContentsOfURL:(NSURL *)url;

@end

@interface ObedientDictionary (ExtendedDictionary)

- (NSArray *)allKeys;
- (NSArray *)allKeysForObject:(id)anObject;
- (NSArray *)allValues;
- (NSString *)description;
//- (NSString *)descriptionInStringsFileFormat;
//- (NSString *)descriptionWithLocale:(id)locale;
//- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level;
//- (BOOL)isEqualToDictionary:(NSDictionary *)otherDictionary;
//- (NSEnumerator *)objectEnumerator;
//- (NSArray *)objectsForKeys:(NSArray *)keys notFoundMarker:(id)marker;
//- (BOOL)writeToFile:(NSString *)path atomically:(BOOL)useAuxiliaryFile;
//- (BOOL)writeToURL:(NSURL *)url atomically:(BOOL)atomically;
//- (NSArray *)keysSortedByValueUsingSelector:(SEL)comparator;
//- (void)getObjects:(id __unsafe_unretained [])objects andKeys:(id __unsafe_unretained [])keys;
//- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block;
//- (void)enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, id obj, BOOL *stop))block;
//- (NSArray *)keysSortedByValueUsingComparator:(NSComparator)cmptr;
//- (NSArray *)keysSortedByValueWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;
//- (NSSet *)keysOfEntriesPassingTest:(BOOL (^)(id key, id obj, BOOL *stop))predicate;
//- (NSSet *)keysOfEntriesWithOptions:(NSEnumerationOptions)opts passingTest:(BOOL (^)(id key, id obj, BOOL *stop))predicate;

@end

@interface ObedientDictionary (MutableDictionary)

- (void)removeObjectForKey:(id)aKey;
- (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey;

@end

@interface ObedientDictionary (MutableDictionaryCreation)

//+ (instancetype)dictionaryWithCapacity:(NSUInteger)numItems;
- (instancetype)initWithCapacity:(NSUInteger)numItems;

@end

@interface ObedientDictionary (ExtendedMutableDictionary)

//- (void)addEntriesFromDictionary:(NSDictionary *)otherDictionary;
- (void)removeAllObjects;
//- (void)removeObjectsForKeys:(NSArray *)keyArray;
//- (void)setDictionary:(NSDictionary *)otherDictionary;
//- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;

@end

// EOF
