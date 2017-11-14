//
//  SFNetworkManager.h
//  Movies
//
//  Created by Nikhil Lele on 11/13/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completionHandler)(NSArray *movies, NSString *errorString);

@interface SFNetworkManager : NSObject
-(void) fetchSearchResultsForString: (NSString *) searchString completionHandler: (completionHandler) completionHandler;
@end
