//
//  HomeListPresenter.h
//  MovieApp
//
//  Created by David Adell on 24/3/19.
//  Copyright © 2019 djadell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeListVC.h"

NS_ASSUME_NONNULL_BEGIN
@protocol HomeListPresenterDelegate <NSObject>

@required
- (void) startFetchingResults:(NSArray*)items totalPages:(float)totalPages;
- (void) nextFetchingResults:(NSArray*)items totalPages:(float)totalPages;
@optional

@end

@interface HomeListPresenter : NSObject

@property (nonatomic, assign) id<HomeListPresenterDelegate> iDelegate;

- (id)initWithHomeListVC:(HomeListVC*)iHomeListVC;
- (void)resetResults:(NSString*)aSearchBarText;
- (void)startFetchingNextResults;

@end

NS_ASSUME_NONNULL_END
