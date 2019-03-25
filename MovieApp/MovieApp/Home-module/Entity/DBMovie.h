//
//  DBMovie.h
//  MovieApp
//
//  Created by David Adell on 24/3/19.
//  Copyright © 2019 djadell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBMovie : NSObject

@property (nonatomic,strong) NSNumber*  iId;
@property (nonatomic,strong) NSString*  iTitle;
@property (nonatomic,strong) NSDate*    iReleaseDate;
@property (nonatomic,strong) NSString*  iImageURL;
@property (nonatomic,strong) NSURL*     iImagePathURL;
@property (nonatomic,strong) NSString*  iOverview;
@property (nonatomic,strong) UIImage*   iDownloadedImage;

- (id) initWithID:(NSString*)aID
            Title:(NSString*)aTitle
         ImageURL:(NSString*)aImageURL
      ReleaseDate:(NSDate*)aReleaseDate
         Overview:(NSString*)aOverview;

@end

NS_ASSUME_NONNULL_END
