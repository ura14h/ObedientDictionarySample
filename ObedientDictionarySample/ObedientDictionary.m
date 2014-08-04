//
//  ObedientDictionary.m
//
//  Created by Hiroki Ishiura on 2014/08/02.
//  Copyright (c) 2014 Hiroki Ishiura. All rights reserved.
//

#import "ObedientDictionary.h"

#pragma mark - ObedientDictionary

@interface ObedientDictionary ()

@property (strong, nonatomic) NSMutableDictionary *p_dictionary;
@property (strong, nonatomic) NSMutableArray *p_dictionaryKeys;

@end

#pragma mark - NSEnumerator for ObedientDictionary

@interface ObedientDictionaryEnumerator : NSEnumerator

@property (weak, nonatomic) ObedientDictionary *dictionary;
@property (assign, nonatomic) NSUInteger nextKeyIndex;

- initWithObedientDictionary:(ObedientDictionary *)dictionary;

@end

#pragma mark - ObedientDictionary

@implementation ObedientDictionary

- (NSUInteger)count
{
	return _p_dictionaryKeys.count;
}

- (id)objectForKey:(id)aKey
{
	if (![_p_dictionaryKeys containsObject:aKey]) {
		return nil;
	}
	return [_p_dictionary objectForKey:aKey];
}

- (NSEnumerator *)keyEnumerator
{
	return [[ObedientDictionaryEnumerator alloc] initWithObedientDictionary:self];
}

#pragma mark InheritedInterfaceses

- (id)copyWithZone:(NSZone *)zone
{
	return [self mutableCopyWithZone:zone];
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
	ObedientDictionary *otherObedientDictionary = [[ObedientDictionary alloc] init];
	otherObedientDictionary.p_dictionary = [self.p_dictionary copyWithZone:zone];
	otherObedientDictionary.p_dictionaryKeys = [self.p_dictionaryKeys copyWithZone:zone];
	return otherObedientDictionary;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[_p_dictionary encodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	_p_dictionary = [[NSMutableDictionary alloc] initWithCoder:aDecoder];
	_p_dictionaryKeys = [_p_dictionary.allKeys mutableCopy];
	return self;
}

+ (BOOL)supportsSecureCoding
{
	return [NSMutableArray supportsSecureCoding] && [NSMutableDictionary supportsSecureCoding];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len
{
	NSUInteger bufferIndex = 0;
	NSUInteger keyIndex = state->state;
	NSUInteger keysCount = _p_dictionaryKeys.count;
	while (bufferIndex < len) {
		if (keyIndex >= keysCount) break;
		buffer[bufferIndex++] = _p_dictionary[_p_dictionaryKeys[keyIndex++]];
	}
	state->state = keyIndex;
	state->itemsPtr = buffer;
	state->mutationsPtr = (unsigned long*)(__bridge void*)self;
	return bufferIndex;
}

@end

@implementation ObedientDictionary (DictionaryCreation)

+ (instancetype)dictionary
{
    return [[ObedientDictionary alloc] init];
}

//+ (instancetype)dictionaryWithObject:(id)object forKey:(id <NSCopying>)key;
//+ (instancetype)dictionaryWithObjects:(const id [])objects forKeys:(const id <NSCopying> [])keys count:(NSUInteger)cnt;
//+ (instancetype)dictionaryWithObjectsAndKeys:(id)firstObject, ... NS_REQUIRES_NIL_TERMINATION;
//+ (instancetype)dictionaryWithDictionary:(NSDictionary *)dict;
//+ (instancetype)dictionaryWithObjects:(NSArray *)objects forKeys:(NSArray *)keys;

- (instancetype)init
{
    self = [super init];
    if (self) {
		_p_dictionary = [[NSMutableDictionary alloc] init];
		_p_dictionaryKeys = [[NSMutableArray alloc] init];
    }
    return self;
}

//- (instancetype)initWithObjects:(const id [])objects forKeys:(const id <NSCopying> [])keys count:(NSUInteger)cnt;

- (instancetype)initWithObjectsAndKeys:(id)firstObject, ... NS_REQUIRES_NIL_TERMINATION
{
    self = [super init];
    if (self) {
		_p_dictionary = [[NSMutableDictionary alloc] init];
		_p_dictionaryKeys = [[NSMutableArray alloc] init];
		
		va_list arguments;
		va_start(arguments, firstObject);
		id value = firstObject;
		while (value) {
			id key = va_arg(arguments, id);
			if (!key) {
				@throw NSInvalidArgumentException;
			}
			// !!!: This is incompatible action with NSMutableDictionary.
			// The specified key object will be copy by setObject operation.
			// Therefore the hash of copied key will be different a hash of key stored to array.
			[_p_dictionary setObject:value forKey:key];
			[_p_dictionaryKeys addObject:key];
			value = va_arg(arguments, id);
		}
		va_end(arguments);
    }
	return self;
}

//- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary;
//- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary copyItems:(BOOL)flag;

- (instancetype)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys
{
    self = [super init];
    if (self) {
		_p_dictionary = [[NSMutableDictionary alloc] initWithObjects:objects forKeys:keys];
		_p_dictionaryKeys = [[NSMutableArray alloc] initWithArray:keys];
    }
    return self;
}

//+ (id)dictionaryWithContentsOfFile:(NSString *)path;
//+ (id)dictionaryWithContentsOfURL:(NSURL *)url;
//- (id)initWithContentsOfFile:(NSString *)path;
//- (id)initWithContentsOfURL:(NSURL *)url;

- (void)dealloc
{
	_p_dictionary = nil;
	_p_dictionaryKeys = nil;
}

@end

@implementation ObedientDictionary (ExtendedDictionary)

- (NSArray *)allKeys
{
	// !!!: This is incompatible action with NSMutableDictionary.
	// see also initWithObjectsAndKeys:
	// see also setObject:forKey:
	return _p_dictionaryKeys;
}

- (NSArray *)allKeysForObject:(id)anObject
{
	NSArray *keys = [_p_dictionary allKeysForObject:anObject];
	keys = [keys sortedArrayUsingComparator:^NSComparisonResult(id key1, id key2) {
		NSUInteger index1 = [_p_dictionaryKeys indexOfObject:key1];
		NSUInteger index2 = [_p_dictionaryKeys indexOfObject:key2];
		return index1 - index2;
	}];
	return keys;
}

- (NSArray *)allValues
{
	NSMutableArray *values = [[NSMutableArray alloc] initWithCapacity:_p_dictionaryKeys.count];
	for (id key in _p_dictionaryKeys) {
		[values addObject:_p_dictionary[key]];
	}
	return values;
}

- (NSString *)description
{
	NSMutableString *message = [[NSMutableString alloc] init];
	[message appendString:@"{\n"];
	for (id key in _p_dictionaryKeys) {
		[message appendFormat:@"    %@ = %@;\n", key, _p_dictionary[key]];
	}
	[message appendString:@"}"];
	return message;
}

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

- (void)enumerateKeysAndObjectsUsingBlock:(void (^)(id key, id obj, BOOL *stop))block
{
	for (id key in _p_dictionaryKeys) {
		if (block) {
			BOOL stop = NO;
			block(key, _p_dictionary[key], &stop);
			if (stop) {
				break;
			}
		}
	}
}

//- (void)enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (^)(id key, id obj, BOOL *stop))block;
//- (NSArray *)keysSortedByValueUsingComparator:(NSComparator)cmptr;
//- (NSArray *)keysSortedByValueWithOptions:(NSSortOptions)opts usingComparator:(NSComparator)cmptr;
//- (NSSet *)keysOfEntriesPassingTest:(BOOL (^)(id key, id obj, BOOL *stop))predicate;
//- (NSSet *)keysOfEntriesWithOptions:(NSEnumerationOptions)opts passingTest:(BOOL (^)(id key, id obj, BOOL *stop))predicate;

@end

@implementation ObedientDictionary (MutableDictionary)

- (void)removeObjectForKey:(id)aKey
{
	[_p_dictionary removeObjectForKey:aKey];
	[_p_dictionaryKeys removeObject:aKey];
}

- (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey
{
	// !!!: This is incompatible action with NSMutableDictionary.
	// The specified key object will be copy by setObject operation.
	// Therefore the hash of copied key will be different a hash of key stored to array.
	[_p_dictionary setObject:anObject forKey:aKey];
	if (![_p_dictionaryKeys containsObject:aKey]) {
		[_p_dictionaryKeys addObject:aKey];
	}
}

@end

@implementation ObedientDictionary (MutableDictionaryCreation)

//+ (instancetype)dictionaryWithCapacity:(NSUInteger)numItems;

- (instancetype)initWithCapacity:(NSUInteger)numItems
{
    self = [super init];
    if (self) {
		_p_dictionary = [[NSMutableDictionary alloc] initWithCapacity:numItems];
		_p_dictionaryKeys = [[NSMutableArray alloc] initWithCapacity:numItems];
    }
    return self;
}

@end

@implementation ObedientDictionary (ExtendedMutableDictionary)

//- (void)addEntriesFromDictionary:(NSDictionary *)otherDictionary;

- (void)removeAllObjects
{
	[_p_dictionary removeAllObjects];
	[_p_dictionaryKeys removeAllObjects];
}

//- (void)removeObjectsForKeys:(NSArray *)keyArray;
//- (void)setDictionary:(NSDictionary *)otherDictionary;
//- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;

@end

#pragma mark - NSEnumerator for ObedientDictionary

@implementation ObedientDictionaryEnumerator

- (id)initWithObedientDictionary:(ObedientDictionary *)dictionary
{
    self = [super init];
    if (self) {
		_dictionary = dictionary;
    }
    return self;
}

- (void)dealloc
{
	_dictionary = nil;
}

- (id)nextObject
{
	id result;
	if (_nextKeyIndex < _dictionary.p_dictionaryKeys.count) {
		result = _dictionary.p_dictionary[_dictionary.p_dictionaryKeys[_nextKeyIndex]];
	} else {
		result = nil;
	}
	return result;
}

@end

// EOF
