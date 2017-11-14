//
//  SFFavoritesCell.h
//  Movies
//
//  Created by Nikhil Lele on 11/14/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFFavoritesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *directedBy;
@property (weak, nonatomic) IBOutlet UILabel *releaseDate;
@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet UILabel *movieDetail;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
@end
