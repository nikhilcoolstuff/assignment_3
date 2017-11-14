//
//  SFCacheManager.h
//  Movies
//
//  Created by Nikhil Lele on 11/14/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SFMovie;

@interface SFCacheManager : NSObject
+ (instancetype)sharedManager;

@property (nonatomic, strong) NSMutableArray *favoritedMovies;
@property (nonatomic, strong) NSMutableSet *favoritesLookupSet;
-(void) toggleFavoriteMovie: (SFMovie *) movie;

@end
