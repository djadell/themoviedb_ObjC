//
//  DBMovie.h
//  MovieApp
//
//  Created by David Adell on 24/3/19.
//  Copyright © 2019 djadell. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBMovie : NSObject

@property (nonatomic,strong) NSString* iId;
@property (nonatomic,strong) NSString* iTitle;
@property (nonatomic,strong) NSDate*   iDate;
@property (nonatomic,strong) NSString* iImage;
@property (nonatomic,strong) NSString* iOverview;


@end

NS_ASSUME_NONNULL_END
