//
//  SFSearchResultsController.m
//  Movies
//
//  Created by Nikhil Lele on 11/14/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "SFSearchResultsController.h"
#import "SFSearchResultCell.h"
#import "SFNetworkManager.h"

@interface SFSearchResultsController () {
    NSArray *privateMovies;
}
@property (nonatomic, strong) SFNetworkManager *networkManager;
@end

@implementation SFSearchResultsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkManager = [[SFNetworkManager alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateSearchResultsForMovies: (NSArray *) movies {
    privateMovies = [movies copy];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return privateMovies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SFSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell" forIndexPath:indexPath];
    SFMovie *movie = privateMovies[indexPath.row];
    
    //cell.poster = "";
    cell.directedBy.text =[NSLocalizedString(@"Directed_by",nil) stringByAppendingString:movie.artistName];
    cell.releaseDate.text = [NSLocalizedString(@"Release_date",nil) stringByAppendingString:[self formateDateString:movie.releaseDate]];
    cell.movieName.text = movie.trackName;
    cell.movieDetail.text = movie.shortDescription.length > 0 ? movie.shortDescription : movie.longDescription;
    cell.favButton.tag = indexPath.row;
    [cell.favButton addTarget:self action:@selector(favouriteClicked:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SFMovie *movie = privateMovies[indexPath.row];
    if ([_delegate respondsToSelector:@selector(didSelectsearchResultCell:)]){
        [_delegate didSelectsearchResultCell:movie];
    }
}

#pragma mark - Local Methods

-(void)favouriteClicked:(UIButton*)sender
{
    
    SFMovie *movie = privateMovies[sender.tag];
    [self.networkManager  writeStringToFile:movie.trackName];
}

-(NSString *)formateDateString:(NSString * )apiDate{
    NSISO8601DateFormatter *formatter = [[NSISO8601DateFormatter alloc] init];
    NSDate *date = [formatter dateFromString:apiDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM d, yyyy"];
    return  [dateFormatter stringFromDate:date];
}
@end
