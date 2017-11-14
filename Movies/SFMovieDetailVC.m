//
//  SFMovieDetailVC.m
//  Movies
//
//  Created by Nikhil Lele on 11/14/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "SFMovieDetailVC.h"
@import AVFoundation;
@import AVKit;

@interface SFMovieDetailVC ()
@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet UILabel *releaseDate;
@property (weak, nonatomic) IBOutlet UILabel *movieDetail;
@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *directedBy;
@property (weak, nonatomic) IBOutlet UIView *moviePreviewView;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UILabel *kind;
@property (weak, nonatomic) IBOutlet UILabel *primaryGenreName;
@end

@implementation SFMovieDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationSetup];
    [self intialDataSetup];
    [self previewPlayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Local Methods

-(void) navigationSetup {
    self.navigationItem.title = NSLocalizedString(@"Movie_Detail",nil) ;
    UIBarButtonItem *_btn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icons8-heart"]
                                                          style:UIBarButtonItemStylePlain
                                                         target:self
                                                         action:@selector(favouriteClicked)];
    self.navigationItem.rightBarButtonItem = _btn;
}
-(void) intialDataSetup {
    self.movieName.text = self.selectedMovie.trackName;
    self.releaseDate.text = [NSLocalizedString(@"Release_date",nil)  stringByAppendingString:[self formateDateString:self.selectedMovie.releaseDate]];
    self.duration.text = [NSLocalizedString(@"Duration",nil) stringByAppendingString:[self millsToDurationString:self.selectedMovie.trackTimeMillis]];
    self.directedBy.text =[NSLocalizedString(@"Directed_by",nil) stringByAppendingString:self.selectedMovie.artistName];
    self.movieDetail.text = self.selectedMovie.shortDescription.length > 0 ? self.selectedMovie.shortDescription : self.selectedMovie.longDescription;
    self.primaryGenreName.text = [NSLocalizedString(@"Genre",nil) stringByAppendingString:self.selectedMovie.primaryGenreName];
    self.kind.text =[NSLocalizedString(@"Kind",nil) stringByAppendingString:self.selectedMovie.kind];
}

-(void) previewPlayer{
    NSURL *url = [NSURL URLWithString:self.selectedMovie.previewUrl];
    AVPlayer *player = [AVPlayer playerWithURL:url];
    AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
    [self addChildViewController:controller];
    [self.moviePreviewView addSubview:controller.view];
    controller.view.frame = self.moviePreviewView.frame;
    controller.player = player;
}


-(void)favouriteClicked
{
}

-(NSString *)formateDateString:(NSString * )apiDate{
    NSISO8601DateFormatter *formatter = [[NSISO8601DateFormatter alloc] init];
    NSDate *date = [formatter dateFromString:apiDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM d, yyyy"];
    return  [dateFormatter stringFromDate:date];
}

-(NSString *)millsToDurationString:(NSNumber *)timeInSeconds {
    
    NSCalendar *_calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit _units = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *_components = [_calendar components:_units fromDate:[NSDate date] toDate:[NSDate dateWithTimeIntervalSinceNow:[timeInSeconds longLongValue]] options:kNilOptions];
    return [NSString stringWithFormat:@"%ld h : %ld min",(long)_components.hour ,(long)_components.minute];
}
@end
