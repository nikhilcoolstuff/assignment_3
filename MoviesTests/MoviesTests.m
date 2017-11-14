//
//  MoviesTests.m
//  MoviesTests
//
//  Created by Nikhil Lele on 11/13/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SFNetworkManager.h"
#import "SFCacheManager.h"
#import "SFMovie.h"

@interface MoviesTests : XCTestCase
@property (nonatomic) SFNetworkManager *networkLayer;
@property (nonatomic) SFCacheManager *cacheManager;
@end

@implementation MoviesTests

- (void)setUp {
    [super setUp];
    self.networkLayer = [[SFNetworkManager alloc] init];
    self.cacheManager = [SFCacheManager sharedManager];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBasicSearch {
    [self.networkLayer fetchSearchResultsForString:@"Brad" completionHandler:^(NSArray *movies, NSString *errorString) {
        XCTAssertGreaterThan(movies.count, 0);
    }];
}

- (void)testToggleFavorite {
    SFMovie *movie = [[SFMovie alloc] init];
    movie.trackId = @(12345);
    [[SFCacheManager sharedManager] toggleFavoriteMovie:movie];
    XCTAssertGreaterThan([SFCacheManager sharedManager].favoritedMovies.count, 0);
    XCTAssertGreaterThan([SFCacheManager sharedManager].favoritesLookupSet.count, 0);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
