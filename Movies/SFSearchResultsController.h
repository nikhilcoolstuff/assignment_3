//
//  SFSearchResultsController.h
//  Movies
//
//  Created by Nikhil Lele on 11/14/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFMovie.h"


@protocol SFSearchResultsDelegate <NSObject>
- (void) didSelectsearchResultCell:(SFMovie *)selectedMovie;
@end

@interface SFSearchResultsController : UITableViewController
@property(nonatomic, weak) id<SFSearchResultsDelegate> delegate;

-(void) updateSearchResultsForMovies: (NSArray *) movies;
-(void) cancelUpdatingResults;

@end
