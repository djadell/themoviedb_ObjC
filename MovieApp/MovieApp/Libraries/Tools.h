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

//MARK: - iOS
+ (NSString*)getIpadLanguage;
//MARK: - Dates
+ (NSString*)getYearWithDate:(NSDate*)aDate;
+ (NSDate*)StringToDate:(NSString*)sDateString DateFormat:(NSString*)sDateFormat;
//MARK: - Network
+ (BOOL)isConnectedToInternet;

@end

NS_ASSUME_NONNULL_END
