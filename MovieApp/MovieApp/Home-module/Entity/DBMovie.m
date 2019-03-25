//
//  DBMovie.m
//  MovieApp
//
//  Created by David Adell on 24/3/19.
//  Copyright © 2019 djadell. All rights reserved.
//

#import "DBMovie.h"

@interface DBMovie ()

@end

@implementation DBMovie

- (id) initWithID:(NSNumber*)aID
            Title:(NSString*)aTitle
         ImageURL:(NSString*)aImageURL
      ReleaseDate:(NSDate*)aReleaseDate
         Overview:(NSString*)aOverview
{
    self = [super init];
    
    if (self) {
        _iId = aID;
        _iTitle = aTitle;
        _iImageURL = aImageURL;
        _iReleaseDate = aReleaseDate;
        _iOverview = aOverview;
    }
    
    return self;
}




@end
