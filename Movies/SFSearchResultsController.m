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
#import "SFImageDownloader.h"
#import "SFCacheManager.h"
#import "SFUtilities.h"

@interface SFSearchResultsController ()
@property (nonatomic, strong) NSArray *privateMovies;
@property (nonatomic, strong) NSMutableDictionary *trackImageDownloadDict;
@property (nonatomic, strong) SFNetworkManager *networkManager;
@property (nonatomic, strong) SFCacheManager *fileManager;
@end

@implementation SFSearchResultsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkManager = [[SFNetworkManager alloc] init];
    self.trackImageDownloadDict = [NSMutableDictionary new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) updateSearchResultsForMovies: (NSArray *) movies {
    self.privateMovies = movies;
    [self.tableView reloadData];
}

// Cancel ongoing imagme requests
-(void) cancelUpdatingResults {
    self.privateMovies = [NSArray new];
    [self.tableView reloadData];
    NSArray *allDownloads = [self.trackImageDownloadDict allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
    [self.trackImageDownloadDict removeAllObjects];
}

- (void)dealloc
{
    [self cancelUpdatingResults];
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.privateMovies.count > 0){
        self.tableView.backgroundView= nil;
        return 1;
    } else {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        messageLabel.text = NSLocalizedString(@"No_Data", nil);
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
    return self.privateMovies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SFSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell" forIndexPath:indexPath];
    SFMovie *movie = self.privateMovies[indexPath.row];
    
    cell.directedBy.text =[NSLocalizedString(@"Directed_by",nil) stringByAppendingString:movie.artistName];
    cell.releaseDate.text = [NSLocalizedString(@"Release_date",nil) stringByAppendingString:[SFUtilities formateDateString:movie.releaseDate]];
    cell.movieName.text = movie.trackName;
    cell.movieDetail.text = movie.shortDescription.length > 0 ? movie.shortDescription : movie.longDescription;
    cell.favButton.tag = indexPath.row;
    if ([[SFCacheManager sharedManager].favoritesLookupSet containsObject:movie.trackId]) {
        [cell.favButton setImage:[UIImage imageNamed:@"icons8-heart-filled"] forState:UIControlStateNormal];
    } else {
        [cell.favButton setImage:[UIImage imageNamed:@"icons8-heart"] forState:UIControlStateNormal];
    }
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SFMovie *movie = self.privateMovies[indexPath.row];
    if ([_delegate respondsToSelector:@selector(didSelectSearchResultCellForMovie:)]){
        [_delegate didSelectSearchResultCellForMovie:movie];
    }
}

#pragma mark - Local Methods

-(void) downloadThumbnailForMovie: (SFMovie *)movie forIndexPath:(NSIndexPath *) indexPath {
    SFImageDownloader *downloader = self.trackImageDownloadDict[indexPath];
    if (!downloader) {
        SFMovie *movie = self.privateMovies[indexPath.row];
        downloader = [[SFImageDownloader alloc] initWithMovie:movie];
        [downloader startDownloadWithCompletionHandler:^{
            SFSearchResultCell *cell = (SFSearchResultCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            cell.poster.image = movie.thumbnail;
            [self.trackImageDownloadDict removeObjectForKey:indexPath];
        }];
        self.trackImageDownloadDict[indexPath] = downloader;
    }
}

-(void)favoriteAction:(UIButton*)sender
{
    SFMovie *movie = self.privateMovies[sender.tag];

    if ([[SFCacheManager sharedManager].favoritesLookupSet containsObject:movie.trackId]) {
        [sender setImage:[UIImage imageNamed:@"icons8-heart"] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"icons8-heart-filled"] forState:UIControlStateNormal];
    }

    [[SFCacheManager sharedManager] toggleFavoriteMovie:movie];
}

@end
