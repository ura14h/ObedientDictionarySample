//
//  ObedientDictionarySampleTests.m
//  ObedientDictionarySampleTests
//
//  Created by Hiroki Ishiura on 2014/08/02.
//  Copyright (c) 2014 Hiroki Ishiura. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ObedientDictionary.h"

@interface ObedientDictionarySampleTests : XCTestCase

@end

@implementation ObedientDictionarySampleTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testClangLiteral
{
	id ns = @{@"key3": @"value3", @"key2": @"value2", @"key1": @"value1"};
	XCTAssertTrue ([ns isKindOfClass:[NSDictionary class]], @"literal is NSDictionary");
	
	// Incompatible pointer types initializing 'NSMutableDictionary *' with an expression of type 'NSDictionary *'
	id nm = @{@"key3": @"value3", @"key2": @"value2", @"key1": @"value1"};
	XCTAssertFalse([nm isKindOfClass:[NSMutableDictionary class]], @"literal is not NSMutableDictionary");
	
	// Incompatible pointer types initializing 'ObedientDictionary *' with an expression of type 'NSDictionary *'
	id od = @{@"key3": @"value3", @"key2": @"value2", @"key1": @"value1"};
	XCTAssertFalse([od isKindOfClass:[ObedientDictionary class]], @"literal is not ObedientDictionary"); // !!!: Not comaptible!
}

- (void)testCount
{
	XCTAssertEqual(([[[NSMutableDictionary alloc] initWithObjectsAndKeys:nil] count]), 0, @"count is 0");
	XCTAssertEqual(([[[ObedientDictionary  alloc] initWithObjectsAndKeys:nil] count]), 0, @"count is 0");

	XCTAssertEqual(([[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"value1", @"key1", nil] count]), 1, @"count is 1");
	XCTAssertEqual(([[[ObedientDictionary  alloc] initWithObjectsAndKeys:@"value1", @"key1", nil] count]), 1, @"count is 1");
	
	XCTAssertEqual(([[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", @"value1", @"key3", nil] count]), 3, @"count is 3");
	XCTAssertEqual(([[[ObedientDictionary  alloc] initWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", @"value1", @"key3", nil] count]), 3, @"count is 3");
}

- (void)testObjectForKey
{
	ObedientDictionary  *od = [[ObedientDictionary  alloc] initWithObjectsAndKeys:@"value3", @"key3", @"value2", @"key2", @"value1", @"key1", nil];
	NSLog(@"%s: od allKeys=%@", __PRETTY_FUNCTION__, [od allKeys]);
	XCTAssertTrue([od objectForKey:@"key1"] && [[od objectForKey:@"key1"] isEqualToString:@"value1"], @"key1 has value1");
	XCTAssertTrue([od objectForKey:@"key2"] && [[od objectForKey:@"key2"] isEqualToString:@"value2"], @"key2 has value2");
	XCTAssertTrue([od objectForKey:@"key3"] && [[od objectForKey:@"key3"] isEqualToString:@"value3"], @"key3 has value3");
	XCTAssertNil ([od objectForKey:@"key4"], @"key4 is undefined");
}

- (void)testKeyEnumerator
{
	// TODO: put testing code here.
}

- (void)testCopyWithZone
{
	// TODO: put testing code here.
}

- (void)testMutableCopyWithZone
{
	// TODO: put testing code here.
}

- (void)testEncodeWithCoder
{
	// TODO: put testing code here.
}

- (void)testInitWithCoder
{
	// TODO: put testing code here.
}

- (void)testSupportsSecureCoding
{
	// TODO: put testing code here.
}

- (void)testCountByEnumeratingWithStateObjectsCount
{
	ObedientDictionary  *od = [[ObedientDictionary  alloc] initWithObjectsAndKeys:@"value3", @"key3", @"value2", @"key2", @"value1", @"key1", nil];
	NSInteger number = 3;
	for (NSString *value in od) {
		XCTAssertTrue(([value isEqualToString:[NSString stringWithFormat:@"value%ld", (long)number]]), @"same to value order by initializer");
		number--;
	}
}

- (void)testDictionary
{
	XCTAssertNotNil([NSMutableDictionary dictionary], @"must be not nil.");
	XCTAssertNotNil([ObedientDictionary  dictionary], @"must be not nil.");
}

- (void)testDictionaryWithObjectForKey
{
	// TODO: put testing code here.
}

- (void)testDictionaryWithObjectsForKeysCount
{
	// TODO: put testing code here.
}

- (void)testDictionaryWithObjectsAndKeys
{
	// TODO: put testing code here.
}

- (void)testDictionaryWithDictionary
{
	// TODO: put testing code here.
}

- (void)testDictionaryWithObjectsForKeys
{
	// TODO: put testing code here.
}

- (void)testInit
{
	XCTAssertNotNil([[NSMutableDictionary alloc] init], @"must be not nil");
	XCTAssertNotNil([[ObedientDictionary  alloc] init], @"must be not nil");
}

- (void)testInitWithObjectsForKeysCount
{
	// TODO: put testing code here.
}

- (void)testInitWithObjectsAndKeys
{
	XCTAssertNotNil(([[NSMutableDictionary alloc] initWithObjectsAndKeys:nil]), @"thrown NSInvalidArgumentException");
	XCTAssertNotNil(([[ObedientDictionary  alloc] initWithObjectsAndKeys:nil]), @"thrown NSInvalidArgumentException");
	
	XCTAssertThrows(([[NSMutableDictionary alloc] initWithObjectsAndKeys:@"value1", nil]), @"thrown NSInvalidArgumentException");
	XCTAssertThrows(([[ObedientDictionary  alloc] initWithObjectsAndKeys:@"value1", nil]), @"thrown NSInvalidArgumentException");
	
	XCTAssertNotNil(([[NSMutableDictionary alloc] initWithObjectsAndKeys:@"value1", @"key1", nil]), @"dictionary is {key1:value1}");
	XCTAssertNotNil(([[ObedientDictionary  alloc] initWithObjectsAndKeys:@"value1", @"key1", nil]), @"dictionary is {key1:value1}");
	
	XCTAssertThrows(([[NSMutableDictionary alloc] initWithObjectsAndKeys:@"value1", @"key1", @"value2", nil]), @"thrown NSInvalidArgumentException");
	XCTAssertThrows(([[ObedientDictionary  alloc] initWithObjectsAndKeys:@"value1", @"key1", @"value2", nil]), @"thrown NSInvalidArgumentException");
	
	XCTAssertNotNil(([[NSMutableDictionary alloc] initWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil]), @"dictionary is {key1:value1, key2:value2}");
	XCTAssertNotNil(([[ObedientDictionary  alloc] initWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil]), @"dictionary is {key1:value1, key2:value2}");
	
	XCTAssertThrows(([[NSMutableDictionary alloc] initWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", @"value3", nil]), @"thrown NSInvalidArgumentException");
	XCTAssertThrows(([[ObedientDictionary  alloc] initWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", @"value3", nil]), @"thrown NSInvalidArgumentException");
	
	XCTAssertNotNil(([[NSMutableDictionary alloc] initWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", @"value1", @"key3", nil]), @"dictionary is {key1:value1, key2:value2, key3:value1}");
	XCTAssertNotNil(([[ObedientDictionary  alloc] initWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", @"value1", @"key3", nil]), @"dictionary is {key1:value1, key2:value2, key3:value1}");
	
	XCTAssertNotNil(([[NSMutableDictionary alloc] initWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", @"value3", @"key1", nil]), @"dictionary is {key1:value3, key2:value2}");
	XCTAssertNotNil(([[ObedientDictionary  alloc] initWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", @"value3", @"key1", nil]), @"dictionary is {key1:value3, key2:value2}");
}

- (void)testInitWithDictionary
{
	// TODO: put testing code here.
}

- (void)testInitWithDictionaryCopyItems
{
	// TODO: put testing code here.
}

- (void)testInitWithObjectsForKeys
{
	XCTAssertNotNil(([[NSMutableDictionary alloc] initWithObjects:nil forKeys:nil]), @"thrown NSInvalidArgumentException");
	XCTAssertNotNil(([[ObedientDictionary  alloc] initWithObjects:nil forKeys:nil]), @"thrown NSInvalidArgumentException");

	XCTAssertThrows(([[NSMutableDictionary alloc] initWithObjects:@[@"value1"] forKeys:nil]), @"thrown NSInvalidArgumentException");
	XCTAssertThrows(([[ObedientDictionary  alloc] initWithObjects:@[@"value1"] forKeys:nil]), @"thrown NSInvalidArgumentException");

	XCTAssertNotNil(([[NSMutableDictionary alloc] initWithObjects:@[@"value1"] forKeys:@[@"key1"]]), @"dictionary is {key1:value1}");
	XCTAssertNotNil(([[ObedientDictionary  alloc] initWithObjects:@[@"value1"] forKeys:@[@"key1"]]), @"dictionary is {key1:value1}");
	
	XCTAssertThrows(([[NSMutableDictionary alloc] initWithObjects:@[@"value1"] forKeys:@[@"key1", @"key2"]]), @"thrown NSInvalidArgumentException");
	XCTAssertThrows(([[ObedientDictionary  alloc] initWithObjects:@[@"value1"] forKeys:@[@"key1", @"key2"]]), @"thrown NSInvalidArgumentException");
	
	XCTAssertNotNil(([[NSMutableDictionary alloc] initWithObjects:@[@"value1", @"value2"] forKeys:@[@"key1", @"key2"]]), @"dictionary is {key1:value1, key2:value2}");
	XCTAssertNotNil(([[ObedientDictionary  alloc] initWithObjects:@[@"value1", @"value2"] forKeys:@[@"key1", @"key2"]]), @"dictionary is {key1:value1, key2:value2}");

	XCTAssertThrows(([[NSMutableDictionary alloc] initWithObjects:@[@"value1", @"value2"] forKeys:@[@"key1", @"key2", @"key3"]]), @"thrown NSInvalidArgumentException");
	XCTAssertThrows(([[ObedientDictionary  alloc] initWithObjects:@[@"value1", @"value2"] forKeys:@[@"key1", @"key2", @"key3"]]), @"thrown NSInvalidArgumentException");
	
	XCTAssertNotNil(([[NSMutableDictionary alloc] initWithObjects:@[@"value1", @"value2", @"value1"] forKeys:@[@"key1", @"key2", @"key3"]]), @"dictionary is {key1:value1, key2:value2, key3:value1}");
	XCTAssertNotNil(([[ObedientDictionary  alloc] initWithObjects:@[@"value1", @"value2", @"value1"] forKeys:@[@"key1", @"key2", @"key3"]]), @"dictionary is {key1:value1, key2:value2, key3:value1}");

	XCTAssertNotNil(([[NSMutableDictionary alloc] initWithObjects:@[@"value1", @"value2", @"value3"] forKeys:@[@"key1", @"key2", @"key1"]]), @"dictionary is {key1:value3, key2:value2");
	XCTAssertNotNil(([[ObedientDictionary  alloc] initWithObjects:@[@"value1", @"value2", @"value3"] forKeys:@[@"key1", @"key2", @"key1"]]), @"dictionary is {key1:value3, key2:value2");
}

- (void)testDictionaryWithContentsOfFile
{
	// TODO: put testing code here.
}

- (void)testDictionaryWithContentsOfURL
{
	// TODO: put testing code here.
}

- (void)testInitWithContentsOfFile
{
	// TODO: put testing code here.
}

- (void)testInitWithContentsOfURL
{
	// TODO: put testing code here.
}

- (void)testAllKeys
{
	NSMutableDictionary *ns = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"value3", @"key3", @"value2", @"key2", @"value1", @"key1", nil];
	NSLog(@"%s: ns allKeys=%@", __PRETTY_FUNCTION__, [ns allKeys]);

	ObedientDictionary  *od = [[ObedientDictionary  alloc] initWithObjectsAndKeys:@"value3", @"key3", @"value2", @"key2", @"value1", @"key1", nil];
	NSLog(@"%s: od allKeys=%@", __PRETTY_FUNCTION__, [od allKeys]);
	NSInteger number = 3;
	for (NSString *key in [od allKeys]) {
		XCTAssertTrue(([key isEqualToString:[NSString stringWithFormat:@"key%ld", (long)number]]), @"same to key order by initializer");
		number--;
	}
	
	{
		NSString *key1 = @"key1";
		NSString *key2 = @"key2";

		NSMutableDictionary *ns = [[NSMutableDictionary alloc] init];
		[ns setObject:@"value1" forKey:key1];
		[ns setObject:@"value2" forKey:key2];
		NSArray *nska = [ns allKeys];
		XCTAssertNotEqual(nska[0], key1, @"key is not same object");
		XCTAssertNotEqual(nska[1], key2, @"key is not same object");

		ObedientDictionary  *od = [[ObedientDictionary alloc] init];
		[od setObject:@"value1" forKey:key1];
		[od setObject:@"value2" forKey:key2];
		NSArray *odka = [od allKeys];
		XCTAssertEqual(odka[0], key1, @"key is same object"); // !!!: Incomaptible action!
		XCTAssertEqual(odka[1], key2, @"key is same object"); // !!!: Incomaptible action!
	}
}

- (void)testAllKeysForObject
{
	NSMutableDictionary *ns = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"value1", @"key3", @"value1", @"key2", @"value1", @"key1", nil];
	NSLog(@"%s: ns allKeysForObject=%@", __PRETTY_FUNCTION__, [ns allKeysForObject:@"value1"]);

	ObedientDictionary  *od = [[ObedientDictionary  alloc] initWithObjectsAndKeys:@"value1", @"key3", @"value1", @"key2", @"value1", @"key1", nil];
	NSLog(@"%s: od allKeysForObject=%@", __PRETTY_FUNCTION__, [od allKeysForObject:@"value1"]);
	NSInteger number = 3;
	for (NSString *key in [od allKeysForObject:@"value1"]) {
		XCTAssertTrue(([key isEqualToString:[NSString stringWithFormat:@"key%ld", (long)number]]), @"same to key order by initializer");
		number--;
	}
}

- (void)testAllValues
{
	NSMutableDictionary *ns = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"value3", @"key3", @"value2", @"key2", @"value1", @"key1", nil];
	NSLog(@"%s: ns allValues=%@", __PRETTY_FUNCTION__, [ns allValues]);
	
	ObedientDictionary  *od = [[ObedientDictionary  alloc] initWithObjectsAndKeys:@"value3", @"key3", @"value2", @"key2", @"value1", @"key1", nil];
	NSLog(@"%s: od allValues=%@", __PRETTY_FUNCTION__, [od allValues]);
	NSInteger number = 3;
	for (NSString *value in [od allValues]) {
		XCTAssertTrue(([value isEqualToString:[NSString stringWithFormat:@"value%ld", (long)number]]), @"same to value order by initializer");
		number--;
	}
}

- (void)testDescription
{
	XCTAssertTrue([[[[NSMutableDictionary alloc] init] description] isEqualToString:@"{\n}"], @"emtpty content");
	XCTAssertTrue([[[[ObedientDictionary  alloc] init] description] isEqualToString:@"{\n}"], @"emtpty content");

	NSMutableDictionary *ns = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"value3", @"key3", @"value2", @"key2", @"value1", @"key1", nil];
	ObedientDictionary  *od = [[ObedientDictionary  alloc] initWithObjectsAndKeys:@"value3", @"key3", @"value2", @"key2", @"value1", @"key1", nil];
	NSLog(@"%s: ns description=%@", __PRETTY_FUNCTION__, [ns description]);
	NSLog(@"%s: od description=%@", __PRETTY_FUNCTION__, [od description]);
	XCTAssertFalse([[ns description] isEqualToString:@"{\n    key3 = value3;\n    key2 = value2;\n    key1 = value1;\n}"], @"key order of NSMutableDictionary is broken");
	XCTAssertTrue ([[ns description] isEqualToString:@"{\n    key1 = value1;\n    key2 = value2;\n    key3 = value3;\n}"], @"key order of NSMutableDictionary is broken");
	XCTAssertTrue ([[od description] isEqualToString:@"{\n    key3 = value3;\n    key2 = value2;\n    key1 = value1;\n}"], @"key order of ObedientDictionary is keeped");
}

- (void)testDescriptionInStringsFileFormat
{
	// TODO: put testing code here.
}

- (void)testDescriptionWithLocale
{
	// TODO: put testing code here.
}

- (void)testDescriptionWithLocaleIndent
{
	// TODO: put testing code here.
}

- (void)testIsEqualToDictionary
{
	// TODO: put testing code here.
}

- (void)testObjectEnumerator
{
	// TODO: put testing code here.
}

- (void)testObjectsForKeysNotFoundMarker
{
	// TODO: put testing code here.
}

- (void)testWriteToFileAtomically
{
	// TODO: put testing code here.
}

- (void)testWriteToURLAtomically
{
	// TODO: put testing code here.
}

- (void)testKeysSortedByValueUsingSelector
{
	// TODO: put testing code here.
}

- (void)testGetObjectsAndKeys
{
	// TODO: put testing code here.
}

- (void)testEnumerateKeysAndObjectsUsingBlock
{
	// TODO: put testing code here.
}

- (void)testEnumerateKeysAndObjectsWithOptionsUsingBlock
{
	NSMutableDictionary *ns = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"value3", @"key3", @"value2", @"key2", @"value1", @"key1", nil];
	NSMutableArray *nsa = [NSMutableArray array];
	[ns enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		[nsa addObject:key];
	}];
	NSLog(@"nsa=%@", nsa);
	ObedientDictionary  *od = [[ObedientDictionary  alloc] initWithObjectsAndKeys:@"value3", @"key3", @"value2", @"key2", @"value1", @"key1", nil];
	NSMutableArray *oda = [NSMutableArray array];
	[od enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		[oda addObject:key];
	}];
	NSLog(@"oda=%@", oda);
	XCTAssertTrue(([oda[0] isEqualToString:@"key3"]), @"the order is same to initializer");
	XCTAssertTrue(([oda[1] isEqualToString:@"key2"]), @"the order is same to initializer");
	XCTAssertTrue(([oda[2] isEqualToString:@"key1"]), @"the order is same to initializer");
}

- (void)testKeysSortedByValueUsingComparator
{
	// TODO: put testing code here.
}

- (void)testKeysSortedByValueWithOptionsUsingComparator
{
	// TODO: put testing code here.
}

- (void)testKeysOfEntriesPassingTest
{
	// TODO: put testing code here.
}

- (void)testKeysOfEntriesWithOptionsPassingTest
{
	// TODO: put testing code here.
}

- (void)testRemoveObjectForKey
{
	ObedientDictionary  *od = [[ObedientDictionary  alloc] initWithObjectsAndKeys:@"value3", @"key3", @"value2", @"key2", @"value1", @"key1", nil];
	XCTAssertEqual ([od count], 3, @"count is 3");
	[od removeObjectForKey:@"key3"];
	XCTAssertEqual([od count], 2, @"count is 2");
	XCTAssertEqual([[od allKeys] count], 2, @"2 keys");
	XCTAssertEqual([[od allValues] count], 2, @"2 values");
	XCTAssertNil   ([od objectForKey:@"key3"], @"key3 is discard");
	XCTAssertNotNil([od objectForKey:@"key2"], @"key2 is keeped");
	XCTAssertNotNil([od objectForKey:@"key1"], @"key1 is keeped");
	NSInteger number = 2;
	for (NSString *key in [od allKeys]) {
		XCTAssertTrue(([key isEqualToString:[NSString stringWithFormat:@"key%ld", (long)number]]), @"same to key order by initializer");
		number--;
	}
	
	[od removeObjectForKey:@"key2"];
	XCTAssertEqual([od count], 1, @"count is 1");
	XCTAssertEqual([[od allKeys] count], 1, @"1 key");
	XCTAssertEqual([[od allValues] count], 1, @"1 value");
	XCTAssertNil   ([od objectForKey:@"key3"], @"key3 is discard");
	XCTAssertNil   ([od objectForKey:@"key2"], @"key2 is discard");
	XCTAssertNotNil([od objectForKey:@"key1"], @"key1 is keeped");
	
	[od removeObjectForKey:@"key1"];
	XCTAssertEqual([od count], 0, @"count is 0");
	XCTAssertEqual([[od allKeys] count], 0, @"no keys");
	XCTAssertEqual([[od allValues] count], 0, @"no values");
	XCTAssertNil([od objectForKey:@"key3"], @"key3 is discard");
	XCTAssertNil([od objectForKey:@"key2"], @"key2 is discard");
	XCTAssertNil([od objectForKey:@"key1"], @"key1 is discard");
}

- (void)testSetObjectForKey
{
	NSMutableDictionary *ns = [[NSMutableDictionary alloc] init];
	[ns setObject:@"value3" forKey:@"key3"];
	[ns setObject:@"value2" forKey:@"key2"];
	[ns setObject:@"value1" forKey:@"key1"];
	NSLog(@"%s: ns allKeys=%@", __PRETTY_FUNCTION__, [ns allKeys]);

	ObedientDictionary  *od = [[ObedientDictionary  alloc] init];
	[od setObject:@"value3" forKey:@"key3"];
	[od setObject:@"value2" forKey:@"key2"];
	[od setObject:@"value1" forKey:@"key1"];
	NSLog(@"%s: od allKeys=%@", __PRETTY_FUNCTION__, [od allKeys]);
	NSInteger number = 3;
	for (NSString *key in [od allKeys]) {
		XCTAssertTrue(([key isEqualToString:[NSString stringWithFormat:@"key%ld", (long)number]]), @"same to key order by initializer");
		number--;
	}
}

- (void)testDictionaryWithCapacity
{
	// TODO: put testing code here.
}

- (void)testInitWithCapacity
{
	// TODO: put testing code here.
}

- (void)testAddEntriesFromDictionary
{
	// TODO: put testing code here.
}

- (void)testRemoveAllObjects
{
	ObedientDictionary  *od = [[ObedientDictionary  alloc] initWithObjectsAndKeys:@"value3", @"key3", @"value2", @"key2", @"value1", @"key1", nil];
	XCTAssertEqual([od count], 3, @"count is 3");
	[od removeAllObjects];
	XCTAssertEqual([od count], 0, @"count is 0");
	XCTAssertEqual([[od allKeys] count], 0, @"no keys");
	XCTAssertEqual([[od allValues] count], 0, @"no values");
	XCTAssertNil([od objectForKey:@"key3"], @"key3 is discard");
	XCTAssertNil([od objectForKey:@"key2"], @"key2 is discard");
	XCTAssertNil([od objectForKey:@"key1"], @"key1 is discard");
}

- (void)testRemoveObjectsForKeys
{
	// TODO: put testing code here.
}

- (void)testSetDictionary
{
	// TODO: put testing code here.
}

- (void)testSetObjectForKeyedSubscript
{
	// TODO: put testing code here.
}

@end
