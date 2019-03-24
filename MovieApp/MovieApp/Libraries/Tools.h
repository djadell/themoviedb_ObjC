//
//  Tools.h
//  MovieApp
//
//  Created by David Adell on 23/3/19.
//  Copyright © 2019 djadell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tools : NSObject

//MARK: - Dates
+ (NSString*)getYearWithDate:(NSDate*)aDate;
//MARK: - Network
+ (BOOL)isConnectedToInternet;

@end

NS_ASSUME_NONNULL_END
