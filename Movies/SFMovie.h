//
//  SFMovie.h
//  Movies
//
//  Created by Nikhil Lele on 11/13/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFMovie : NSObject

@property (nonatomic, copy) NSString *wrapperType;
@property (nonatomic, copy) NSString *kind;
@property (nonatomic, strong) NSNumber *trackId;
@property (nonatomic, copy) NSString *artistName;
@property (nonatomic, copy) NSString *trackName;
@property (nonatomic, copy) NSString *trackCensoredName;
@property (nonatomic, copy) NSString *trackViewUrl;
@property (nonatomic, copy) NSString *previewUrl;
@property (nonatomic, copy) NSString *artworkUrl30;
@property (nonatomic, copy) NSString *artworkUrl60;
@property (nonatomic, copy) NSString *artworkUrl100;
@property (nonatomic, strong) NSNumber *collectionPrice;
@property (nonatomic, strong) NSNumber *trackPrice;
@property (nonatomic, strong) NSNumber *trackRentalPrice;
@property (nonatomic, strong) NSNumber *collectionHdPrice;
@property (nonatomic, strong) NSNumber *trackHdPrice;
@property (nonatomic, strong) NSNumber *trackHdRentalPrice;
@property (nonatomic, copy) NSString *releaseDate;
@property (nonatomic, copy) NSString *collectionExplicitness;
@property (nonatomic, copy) NSString *trackExplicitness;
@property (nonatomic, strong) NSNumber *trackTimeMillis;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *primaryGenreName;
@property (nonatomic, copy) NSString *contentAdvisoryRating;
@property (nonatomic, copy) NSString *shortDescription;
@property (nonatomic, copy) NSString *longDescription;

-(id) initWithDictionary: (NSDictionary *) dict; 

@end
