//
//  MoviesTests.m
//  MoviesTests
//
//  Created by Nikhil Lele on 11/13/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SFNetworkManager.h"

@interface MoviesTests : XCTestCase
@property (nonatomic) S *vcToTest;
@end

@implementation MoviesTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBasicSearch {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
