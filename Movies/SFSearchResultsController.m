//
//  SFSearchResultsController.m
//  Movies
//
//  Created by Alankar Muley on 11/14/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "SFSearchResultsController.h"

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell" forIndexPath:indexPath];
    
    cell.textLabel.text = @"Movie Name";
    return cell;
}

@end
