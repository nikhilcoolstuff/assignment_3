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
        _kind = dict[@"wrapperType"];;
        _trackId = dict[@"trackId"];;
        _artistName = dict[@"artistName"];;
        _trackName = dict[@"trackName"];;
        _trackCensoredName = dict[@"trackCensoredName"];;
        _trackViewUrl = dict[@"trackViewUrl"];;
        _previewUrl = dict[@"previewUrl"];;
        _artworkUrl30 = dict[@"artworkUrl30"];;
        _title = dict[@"title"];;
        _artworkUrl60 = dict[@"artworkUrl60"];;
        _artworkUrl100 = dict[@"artworkUrl100"];;
        _collectionPrice = dict[@"collectionPrice"];;
        _trackPrice = dict[@"trackPrice"];;
        _trackRentalPrice = dict[@"trackRentalPrice"];;
        _collectionHdPrice = dict[@"collectionHdPrice"];;
        _trackHdPrice = dict[@"trackHdPrice"];;
        _trackHdRentalPrice = dict[@"trackHdRentalPrice"];;
        _releaseDate = dict[@"releaseDate"];;
        _collectionExplicitness = dict[@"collectionExplicitness"];;
        _trackExplicitness = dict[@"trackExplicitness"];;
        _trackTimeMillis = dict[@"trackTimeMillis"];;
        _country = dict[@"country"];;
        _currency = dict[@"currency"];;
        _primaryGenreName = dict[@"primaryGenreName"];;
        _contentAdvisoryRating = dict[@"contentAdvisoryRating"];;
        _shortDescription = dict[@"shortDescription"];;
        _longDescription = dict[@"longDescription"];;
        
    }
    return self;
}

@end
