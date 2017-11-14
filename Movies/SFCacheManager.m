//
//  SFCacheManager.m
//  Movies
//
//  Created by Nikhil Lele on 11/14/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "SFCacheManager.h"

@implementation SFCacheManager

+ (instancetype)sharedManager {
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

-(instancetype)init {
    self = [super init];
    if (self)
        [self loadFavoritedMovies];
    
    return self;
}

-(void) favoriteMovie: (SFMovie *) movie {
    if (movie)
        [self.favoritedMovies addObject: movie];
    [NSKeyedArchiver archiveRootObject:self.favoritedMovies toFile:[self getCachePath]];
}

-(void) loadFavoritedMovies {
    self.favoritedMovies = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getCachePath]];
    if (!self.favoritedMovies) {
        self.favoritedMovies = [NSMutableArray new];
    }
}

- (NSString *) getCachePath {
    // Build the path, and create if needed.
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"favorites.json";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    return fileAtPath;
}

@end
