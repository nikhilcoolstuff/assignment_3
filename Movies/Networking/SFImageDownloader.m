//
//  SFImageDownloader.m
//  Movies
//
//  Created by Nikhil Lele on 11/14/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "SFImageDownloader.h"
#import "SFMovie.h"

@interface SFImageDownloader ()
@property (nonatomic, strong) NSURLSessionDataTask *sessionDataTask;
@property (nonatomic, strong) SFMovie *movie;
@end

@implementation SFImageDownloader

-(id) initWithMovie:(SFMovie *)movie {
    self = [super init];
    if (self) {
        _movie = movie;
    }
    return self;
}

-(void) startDownloadWithCompletionHandler:(imageDownloadCompletionHandler) completionHandler {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.movie.artworkUrl60]];
    self.sessionDataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            self.movie.thumbnail = [[UIImage alloc] initWithData:data];
            
            // return on main queue once download is complete.
            [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
                completionHandler();
            }];
        }
    }];
    [self.sessionDataTask resume];
}

-(void) cancelDownload {
    [self.sessionDataTask cancel];
    self.sessionDataTask = nil;
}

@end
