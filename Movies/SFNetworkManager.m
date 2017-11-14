//
//  SFNetworkManager.m
//  Movies
//
//  Created by Nikhil Lele on 11/13/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "SFNetworkManager.h"

static NSString * const BASE_URL = @"https://iTunes.apple.com/search";
@implementation SFNetworkManager

-(id) init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void) callAPIforSearchString: (NSString *) searchString {
    
    NSURLComponents *components = [NSURLComponents componentsWithString:BASE_URL];
    components.query = @"media=movie&term=jack+johnson";
    NSURL *url = [components URL];
    
    [[[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *serializeError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&serializeError];
        NSLog(@"%@", json);
    }] resume];
    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//
//    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSError *serializeError;
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&serializeError];
//        NSLog(@"%@", json);
//    }] resume];
}

@end
