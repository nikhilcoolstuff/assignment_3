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

-(void) favoriteMovie: (SFMovie *) movie {
    [NSKeyedArchiver archiveRootObject:movie toFile:[self getCachePath]];
}

-(NSArray *)getFavoriteMovies {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self getCachePath]];
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
