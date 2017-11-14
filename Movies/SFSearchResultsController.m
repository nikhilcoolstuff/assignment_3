//
//  SFSearchResultsController.m
//  Movies
//
//  Created by Nikhil Lele on 11/14/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "SFSearchResultsController.h"
#import "SFSearchResultCell.h"
@interface SFSearchResultsController ()

@end

@implementation SFSearchResultsController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SFSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell" forIndexPath:indexPath];
    //cell.poster = "";
    cell.directedBy.text =@"Directed by:";
    cell.releaseDate.text = @"Release date:";
    //cell.movieName.text = @"";
    //cell.movieDetail.text = @"";
    //favButton;
    return cell;
}

@end
