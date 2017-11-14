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

-(void) favoriteMovie: (SFMovie *) movie;
-(NSArray *)getFavoriteMovies;

@end
