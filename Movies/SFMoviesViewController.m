//
//  SFMoviesViewController.m
//  Movies
//
//  Created by Nikhil Lele on 11/13/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "SFMoviesViewController.h"
#import "SFSearchResultsController.h"
#import "SFNetworkManager.h"
#import "SFMovieDetailVC.h"


@interface SFMoviesViewController ()<SFSearchResultsDelegate>{
    SFMovie *searchSelectedMovie;
}
@property (nonatomic, strong) SFSearchResultsController *searchResultsVC;
@property (nonatomic, strong) SFNetworkManager *networkManager;
@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation SFMoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Movies";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.searchResultsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResultsVC"];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchResultsVC];
    self.searchResultsVC.delegate = self;
    self.searchController.searchBar.placeholder = @"Search Movies";
    self.searchController.searchResultsUpdater = self;
    self.navigationItem.searchController = self.searchController;
    self.definesPresentationContext = YES;
    self.networkManager = [[SFNetworkManager alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self.networkManager fetchSearchResultsForString:searchController.searchBar.text completionHandler:^(NSArray *movies, NSString *errorString) {
        if (errorString)
            // TODO show error
            NSLog(errorString);
        else
            [self.searchResultsVC updateSearchResultsForMovies:movies];
    }];
}

#pragma mark - SFSearchResultsDelegate

- (void) didSelectsearchResultCell:(SFMovie *)selectedMovie{
    searchSelectedMovie = selectedMovie ;
    [self performSegueWithIdentifier:@"movie_detail_segue" sender:nil];

}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"movie_detail_segue"]) {
      SFMovieDetailVC *movieDetailVC = (SFMovieDetailVC *) segue.destinationViewController;
      movieDetailVC.selectedMovie = searchSelectedMovie ;
  }
}


@end
