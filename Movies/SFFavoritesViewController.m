//
//  SFFavoritesViewController.m
//  Movies
//
//  Created by Alankar Muley on 11/14/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "SFFavoritesViewController.h"
#import "SFCacheManager.h"
#import "SFSearchResultCell.h"
#import "SFMovie.h"
#import "SFUtilities.h"

@interface SFFavoritesViewController ()
@property (nonatomic, strong) NSArray *favoriteMovies;
@end

@implementation SFFavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"Favorites", nil);
    self.favoriteMovies = [NSArray new];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.favoriteMovies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SFSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell" forIndexPath:indexPath];
    SFMovie *movie = self.favoriteMovies[indexPath.row];
    
    cell.directedBy.text =[NSLocalizedString(@"Directed_by",nil) stringByAppendingString:movie.artistName];
    cell.releaseDate.text = [NSLocalizedString(@"Release_date",nil) stringByAppendingString:[SFUtilities formateDateString:movie.releaseDate]];
    cell.movieName.text = movie.trackName;
    cell.movieDetail.text = movie.shortDescription.length > 0 ? movie.shortDescription : movie.longDescription;
    cell.favButton.tag = indexPath.row;
    [cell.favButton addTarget:self action:@selector(favoriteAction:) forControlEvents:UIControlEventTouchUpInside];
    
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

-(void)favoriteAction:(UIButton*)sender
{
    SFMovie *movie = self.favoriteMovies[sender.tag];
    [[SFCacheManager sharedManager] favoriteMovie:movie];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
