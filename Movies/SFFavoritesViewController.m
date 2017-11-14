//
//  SFFavoritesViewController.m
//  Movies
//
//  Created by Alankar Muley on 11/14/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "SFFavoritesViewController.h"
#import "SFCacheManager.h"
#import "SFFavoritesCell.h"
#import "SFMovie.h"
#import "SFImageDownloader.h"


@interface SFFavoritesViewController ()
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
    self.favoriteMovies = [[SFCacheManager sharedManager] getFavoriteMovies];
    NSLog(@"test");
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
    SFFavoritesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favoritesCell" forIndexPath:indexPath];
    SFMovie *movie = self.favoriteMovies[indexPath.row];
    
    cell.directedBy.text =[NSLocalizedString(@"Directed_by",nil) stringByAppendingString:movie.artistName];
    cell.releaseDate.text = [NSLocalizedString(@"Release_date",nil) stringByAppendingString:[self formateDateString:movie.releaseDate]];
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
            [self downloadThumbnailForMovie:movie forIndexPath:indexPath];
        }
        // meanwhile return a placeholder image
        cell.poster.image = [UIImage imageNamed:@"placeholder.png"];
    }
    return cell;
}

#pragma mark - Local Methods

-(void) downloadThumbnailForMovie: (SFMovie *)movie forIndexPath:(NSIndexPath *) indexPath {
    SFImageDownloader *downloader = self.trackImageDownloadDict[indexPath];
    if (!downloader) {
        SFMovie *movie = self.favoriteMovies[indexPath.row];
        downloader = [[SFImageDownloader alloc] initWithMovie:movie];
        [downloader startDownloadWithCompletionHandler:^{
            SFFavoritesCell *cell = (SFFavoritesCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            cell.poster.image = movie.thumbnail;
            [self.trackImageDownloadDict removeObjectForKey:indexPath];
        }];
        self.trackImageDownloadDict[indexPath] = downloader;
    }
}

-(void)favoriteAction:(UIButton*)sender
{
//    SFMovie *movie = self.favoriteMovies[sender.tag];
//    [[SFCacheManager sharedManager] favoriteMovie:movie];
}

-(NSString *)formateDateString:(NSString * )apiDate{
    NSISO8601DateFormatter *formatter = [[NSISO8601DateFormatter alloc] init];
    NSDate *date = [formatter dateFromString:apiDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM d, yyyy"];
    return  [dateFormatter stringFromDate:date];
}

@end
