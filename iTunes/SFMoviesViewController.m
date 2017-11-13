//
//  SFMoviesViewController.m
//  iTunes
//
//  Created by Nikhil Lele on 11/13/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "SFMoviesViewController.h"

@interface SFMoviesViewController ()

@end

@implementation SFMoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Movies";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.searchController = [[UISearchController alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
