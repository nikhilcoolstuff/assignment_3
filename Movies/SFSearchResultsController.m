//
//  SFSearchResultsController.m
//  Movies
//
//  Created by Nikhil Lele on 11/14/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "SFSearchResultsController.h"
#import "SFSearchResultCell.h"
#import "SFImageDownloader.h"

@interface SFSearchResultsController ()
@property (nonatomic, strong) NSArray *privateMovies;
@property (nonatomic, strong) NSMutableDictionary *trackImageDownloadDict;
@end

@implementation SFSearchResultsController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.privateMovies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SFSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell" forIndexPath:indexPath];
    SFMovie *movie = self.privateMovies[indexPath.row];
    
    //cell.poster = "";
    cell.directedBy.text =[@"Directed by:" stringByAppendingString:movie.artistName];
    cell.releaseDate.text = [@"Release date:" stringByAppendingString:[self formateDateString:movie.releaseDate]];
    cell.movieName.text = movie.trackName;
    cell.movieDetail.text = movie.shortDescription.length > 0 ? movie.shortDescription : movie.longDescription;
    cell.favButton.tag = indexPath.row;
    [cell.favButton addTarget:self action:@selector(favouriteClicked:) forControlEvents:UIControlEventTouchUpInside];
    
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
    if ([_delegate respondsToSelector:@selector(didSelectsearchResultCell:)]){
        [_delegate didSelectsearchResultCell:movie];
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

-(void)favouriteClicked:(UIButton*)sender
{
    SFMovie *movie = self.privateMovies[sender.tag];
    NSLog(movie.trackName);
}

-(NSString *)formateDateString:(NSString * )apiDate{
    NSISO8601DateFormatter *formatter = [[NSISO8601DateFormatter alloc] init];
    NSDate *date = [formatter dateFromString:apiDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM d, yyyy"];
    return  [dateFormatter stringFromDate:date];
}
@end
