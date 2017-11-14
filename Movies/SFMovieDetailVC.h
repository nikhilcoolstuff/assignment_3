//
//  SFMovieDetailVC.h
//  Movies
//
//  Created by Nikhil Lele on 11/14/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFMovie.h"

@interface SFMovieDetailVC : UITableViewController
@property (nonatomic, strong) SFMovie *selectedMovie;
@end
