//
//  SFCacheManager.m
//  Movies
//
//  Created by Nikhil Lele on 11/14/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "SFCacheManager.h"
#import "SFMovie.h"
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

-(void) toggleFavoriteMovie: (SFMovie *) movie {
    // toggle favorite
    if([self.favoritesLookupSet containsObject:movie.trackId]) {
        // find matching movie and remove
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"trackId==%@",movie.trackId];
        NSArray *results = [self.favoritedMovies filteredArrayUsingPredicate:predicate];
        if (results.count > 0) {
            SFMovie *movieToRemove = (SFMovie *)results[0];
            [self.favoritedMovies removeObject:movieToRemove];
        }
    } else {
        [self.favoritedMovies addObject: movie];
    }
    self.favoritesLookupSet = [self.favoritedMovies valueForKey:@"trackId"];
    [NSKeyedArchiver archiveRootObject:self.favoritedMovies toFile:[self getCachePath]];
}

-(void) loadFavoritedMovies {
    self.favoritedMovies = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getCachePath]];
    self.favoritesLookupSet = [self.favoritedMovies valueForKey:@"trackId"];
    if (!self.favoritedMovies) {
        self.favoritedMovies = [NSMutableArray new];
        self.favoritesLookupSet = [NSMutableSet new];
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
