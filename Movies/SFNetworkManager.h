//
//  SFNetworkManager.h
//  Movies
//
//  Created by Nikhil Lele on 11/13/17.
//  Copyright © 2017 Salesforce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFNetworkManager : NSObject
-(void) callAPIforSearchString: (NSString *) searchString;
@end
