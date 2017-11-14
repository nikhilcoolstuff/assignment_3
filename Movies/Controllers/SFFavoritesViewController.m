//
//  SFFavoritesViewController.m
//  Movies
//
//  Created by Nikhil Lele on 11/14/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "SFFavoritesViewController.h"
#import "SFCacheManager.h"
#import "SFMovie.h"
#import "SFUtilities.h"
#import "SFFavoritesCell.h"
#import "SFMovieDetailVC.h"

@interface SFFavoritesViewController ()
@property (nonatomic, strong) SFMovie *favoritesSelectedMovie;
@property (nonatomic, strong) NSArray *favoriteMovies;
@property (nonatomic, strong) NSMutableDictionary *trackImageDownloadDict;
@end

@implementation SFFavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"Favorites", nil);
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.trackImageDownloadDict = [NSMutableDictionary new];
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.favoriteMovies = [SFCacheManager sharedManager].favoritedMovies;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.favoriteMovies.count > 0){
        self.tableView.backgroundView= nil;
        return 1;
    } else {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        messageLabel.text = NSLocalizedString(@"No_Favorites", nil);
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
        [messageLabel sizeToFit];
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return 0;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favoriteMovies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SFFavoritesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favoritesCell" forIndexPath:indexPath];
    SFMovie *movie = self.favoriteMovies[indexPath.row];
    
    cell.directedBy.text =[NSLocalizedString(@"Directed_by",nil) stringByAppendingString:movie.artistName];
    cell.releaseDate.text = [NSLocalizedString(@"Release_date",nil) stringByAppendingString:[SFUtilities formateDateString:movie.releaseDate]];
    cell.movieName.text = movie.trackName;
    cell.movieDetail.text = movie.shortDescription.length > 0 ? movie.shortDescription : movie.longDescription;
    
    // load any previously cached images
    if (movie.thumbnail) {
        cell.poster.image = movie.thumbnail;
    } else {
        // We dont have the thumbnail so request for downloading it. Make sure table view scroll has ended so we dont fetch unnecessary images.
        if (!self.tableView.dragging && !self.tableView.decelerating)
        {
//            [self downloadThumbnailForMovie:movie forIndexPath:indexPath];
        }
        // meanwhile return a placeholder image
        cell.poster.image = [UIImage imageNamed:@"placeholder.png"];
    }
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[SFCacheManager sharedManager] toggleFavoriteMovie:self.favoriteMovies[indexPath.row]];
        self.favoriteMovies = [SFCacheManager sharedManager].favoritedMovies;
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.favoritesSelectedMovie = self.favoriteMovies[indexPath.row];
    [self performSegueWithIdentifier:@"fav_movie_detail_segue" sender:nil];
}

#pragma mark local methods

-(void)favoriteAction:(UIButton*)sender {
    SFMovie *movie = self.favoriteMovies[sender.tag];
    [[SFCacheManager sharedManager] toggleFavoriteMovie:movie];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"fav_movie_detail_segue"]) {
        SFMovieDetailVC *movieDetailVC = (SFMovieDetailVC *) segue.destinationViewController;
        movieDetailVC.selectedMovie = self.favoritesSelectedMovie;
    }
}

@end
