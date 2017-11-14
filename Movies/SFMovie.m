//
//  SFMovie.m
//  Movies
//
//  Created by Nikhil Lele on 11/13/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import "SFMovie.h"

@implementation SFMovie

-(id) initWithDictionary: (NSDictionary *) dict {
    self = [super init];
    if (self) {
        _wrapperType = dict[@"wrapperType"];
        _kind = dict[@"wrapperType"];
        _trackId = dict[@"trackId"];
        _artistName = dict[@"artistName"];
        _trackName = dict[@"trackName"];
        _trackCensoredName = dict[@"trackCensoredName"];
        _trackViewUrl = dict[@"trackViewUrl"];
        _previewUrl = dict[@"previewUrl"];
        _artworkUrl30 = dict[@"artworkUrl30"];
        _artworkUrl60 = dict[@"artworkUrl60"];
        _artworkUrl100 = dict[@"artworkUrl100"];
        _collectionPrice = dict[@"collectionPrice"];
        _trackPrice = dict[@"trackPrice"];
        _trackRentalPrice = dict[@"trackRentalPrice"];
        _collectionHdPrice = dict[@"collectionHdPrice"];
        _trackHdPrice = dict[@"trackHdPrice"];
        _trackHdRentalPrice = dict[@"trackHdRentalPrice"];
        _releaseDate = dict[@"releaseDate"];
        _collectionExplicitness = dict[@"collectionExplicitness"];
        _trackExplicitness = dict[@"trackExplicitness"];
        _trackTimeMillis = dict[@"trackTimeMillis"];
        _country = dict[@"country"];
        _currency = dict[@"currency"];
        _primaryGenreName = dict[@"primaryGenreName"];
        _contentAdvisoryRating = dict[@"contentAdvisoryRating"];
        _shortDescription = dict[@"shortDescription"];
        _longDescription = dict[@"longDescription"];
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _wrapperType = [coder decodeObjectForKey:@"wrapperType"];
        _kind = [coder decodeObjectForKey:@"wrapperType"];
        _trackId = [coder decodeObjectForKey:@"trackId"];
        _artistName = [coder decodeObjectForKey:@"artistName"];
        _trackName = [coder decodeObjectForKey:@"trackName"];
        _trackCensoredName = [coder decodeObjectForKey:@"trackCensoredName"];
        _trackViewUrl = [coder decodeObjectForKey:@"trackViewUrl"];
        _previewUrl = [coder decodeObjectForKey:@"previewUrl"];
        _artworkUrl30 = [coder decodeObjectForKey:@"artworkUrl30"];
        _artworkUrl60 = [coder decodeObjectForKey:@"artworkUrl60"];
        _artworkUrl100 = [coder decodeObjectForKey:@"artworkUrl100"];
        _collectionPrice = [coder decodeObjectForKey:@"collectionPrice"];
        _trackPrice = [coder decodeObjectForKey:@"trackPrice"];
        _trackRentalPrice = [coder decodeObjectForKey:@"trackRentalPrice"];
        _collectionHdPrice = [coder decodeObjectForKey:@"collectionHdPrice"];
        _trackHdPrice = [coder decodeObjectForKey:@"trackHdPrice"];
        _trackHdRentalPrice = [coder decodeObjectForKey:@"trackHdRentalPrice"];
        _releaseDate = [coder decodeObjectForKey:@"releaseDate"];
        _collectionExplicitness = [coder decodeObjectForKey:@"collectionExplicitness"];
        _trackExplicitness = [coder decodeObjectForKey:@"trackExplicitness"];
        _trackTimeMillis = [coder decodeObjectForKey:@"trackTimeMillis"];
        _country = [coder decodeObjectForKey:@"country"];
        _currency = [coder decodeObjectForKey:@"currency"];
        _primaryGenreName = [coder decodeObjectForKey:@"primaryGenreName"];
        _contentAdvisoryRating = [coder decodeObjectForKey:@"contentAdvisoryRating"];
        _shortDescription = [coder decodeObjectForKey:@"shortDescription"];
        _longDescription = [coder decodeObjectForKey:@"longDescription"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.wrapperType forKey:@"wrapperType"];
    [aCoder encodeObject:self.kind forKey:@"kind"];
    [aCoder encodeObject:self.artistName forKey:@"artistName"];
    [aCoder encodeObject:self.trackName forKey:@"trackName"];
    [aCoder encodeObject:self.trackCensoredName forKey:@"trackCensoredName"];
    [aCoder encodeObject:self.trackViewUrl forKey:@"trackViewUrl"];
    [aCoder encodeObject:self.previewUrl forKey:@"previewUrl"];
    [aCoder encodeObject:self.artworkUrl30 forKey:@"artworkUrl30"];
    [aCoder encodeObject:self.artworkUrl60 forKey:@"artworkUrl60"];
    [aCoder encodeObject:self.artworkUrl100 forKey:@"artworkUrl100"];
    [aCoder encodeObject:self.collectionPrice forKey:@"collectionPrice"];
    [aCoder encodeObject:self.trackPrice forKey:@"trackPrice"];
    [aCoder encodeObject:self.trackRentalPrice forKey:@"trackRentalPrice"];
    [aCoder encodeObject:self.collectionHdPrice forKey:@"collectionHdPrice"];
    [aCoder encodeObject:self.trackHdPrice forKey:@"trackHdPrice"];
    [aCoder encodeObject:self.trackHdRentalPrice forKey:@"trackHdRentalPrice"];
    [aCoder encodeObject:self.releaseDate forKey:@"releaseDate"];
    [aCoder encodeObject:self.collectionExplicitness forKey:@"collectionExplicitness"];
    [aCoder encodeObject:self.trackExplicitness forKey:@"trackExplicitness"];
    [aCoder encodeObject:self.trackTimeMillis forKey:@"trackTimeMillis"];
    [aCoder encodeObject:self.country forKey:@"country"];
    [aCoder encodeObject:self.currency forKey:@"currency"];
    [aCoder encodeObject:self.primaryGenreName forKey:@"primaryGenreName"];
    [aCoder encodeObject:self.contentAdvisoryRating forKey:@"contentAdvisoryRating"];
    [aCoder encodeObject:self.shortDescription forKey:@"shortDescription"];
    [aCoder encodeObject:self.longDescription forKey:@"longDescription"];
}

@end
