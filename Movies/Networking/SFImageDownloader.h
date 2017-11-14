//
//  SFImageDownloader.h
//  Movies
//
//  Created by Nikhil Lele on 11/14/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@class SFMovie;

typedef void (^imageDownloadCompletionHandler)(void);

@interface SFImageDownloader : NSObject
-(id) initWithMovie: (SFMovie *) movie; 
-(void) startDownloadWithCompletionHandler:(imageDownloadCompletionHandler) completionHandler;
-(void) cancelDownload;
@end
