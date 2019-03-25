//
//  HomeListInteractor.h
//  MovieApp
//
//  Created by David Adell on 24/3/19.
//  Copyright © 2019 djadell. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HomeListInteractorDelegate <NSObject>

@required
- (void)dataFetchingResults:(NSArray*)items totalPages:(float)totalPages;

@optional

@end

@interface HomeListInteractor : NSObject

@property (nonatomic, assign) id<HomeListInteractorDelegate> iDelegate;

- (void)getPopularMoviesWithPage:(int)aPage;

@end

NS_ASSUME_NONNULL_END
