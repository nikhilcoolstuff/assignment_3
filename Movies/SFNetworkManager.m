//
//  SFNetworkManager.m
//  Movies
//
//  Created by Nikhil Lele on 11/13/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "SFNetworkManager.h"
#import "SFMovie.h"

static NSString * const BASE_URL = @"https://iTunes.apple.com/search";

@interface SFNetworkManager ()
@property (nonatomic, strong) NSURLSessionDataTask *fetchDataTask;
@property (nonatomic, strong) NSURLSession *defaultSession;
@property (nonatomic, strong) NSMutableArray *movies;
@property (nonatomic, strong) NSString *errorMessage;

@end

@implementation SFNetworkManager

-(id) init {
    self = [super init];
    if (self) {
        _defaultSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _movies = [NSMutableArray new];
    }
    return self;
}

-(void) fetchSearchResultsForString: (NSString *) searchString completionHandler: (completionHandler) completionHandler {

    [self.fetchDataTask cancel];
    self.errorMessage = nil;
    
    NSURLComponents *components = [NSURLComponents componentsWithString:BASE_URL];
    components.query = [NSString stringWithFormat:@"media=movie&term=%@", searchString];
    NSURL *url = [components URL];
    self.fetchDataTask = [self.defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if (error) {
            self.errorMessage = [@"Error: " stringByAppendingString:error.localizedDescription];
        } else if (httpResponse.statusCode == 200) {
            [self updateSearchResultsForJson:data];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(self.movies, self.errorMessage);
        });
    }];
    [self.fetchDataTask resume];
}

-(void) updateSearchResultsForJson: (NSData *) data {
    
    [self.movies removeAllObjects];
    
    NSError *serializeError;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&serializeError];
    if (serializeError) {
        self.errorMessage = [@"Error: " stringByAppendingString:serializeError.localizedDescription];
        return;
    }
    NSArray *results = json[@"results"];
    if (!results || results.count == 0)
        self.errorMessage = @"Error: No results found";
    
    [results enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *movieDict = (NSDictionary *)obj;
        SFMovie *movie = [[SFMovie alloc] initWithDictionary:movieDict];
        [self.movies addObject:movie];
    }];
}

- (void)writeStringToFile:(NSString*)aString {
    
    // Build the path, and create if needed.
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"bookmark.json";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    
    // The main act...
    [[aString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
}


- (NSString*)readStringFromFile {
    
    // Build the path...
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"bookmark.json";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    // The main act...
    return [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:fileAtPath] encoding:NSUTF8StringEncoding];
}

@end
