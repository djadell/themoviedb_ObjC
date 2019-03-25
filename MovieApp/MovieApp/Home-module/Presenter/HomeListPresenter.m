//
//  HomeListPresenter.m
//  MovieApp
//
//  Created by David Adell on 24/3/19.
//  Copyright © 2019 djadell. All rights reserved.
//

#import "HomeListPresenter.h"
#import "HomeListInteractor.h"


@interface HomeListPresenter () <HomeListInteractorDelegate>
{
    
}

@property (strong,nonatomic) HomeListVC* iView;
@property (strong,nonatomic) HomeListInteractor *iInteractor;

@end

@implementation HomeListPresenter

- (id) initWithHomeListVC:(HomeListVC*)iHomeListVC
{
    self = [super init];
    
    if (self) {
        _iView = iHomeListVC;
        _iInteractor = [HomeListInteractor new];
        [_iInteractor setIDelegate:self];
    }
    
    return self;
}

-(void)resetResults:(NSString*)aSearchBarText
{
    _iPageNumber = 1;
    
    if (aSearchBarText.length) {
        // Must be implemented
    } else {
        [_iInteractor getPopularMoviesWithPage:_iPageNumber isNext:NO];
    }
}

- (void)startFetchingNextResults:(NSString*)aSearchBarText
{
    NSLog(@"[DEBUG] startFetchingNextResults iPageNumber++ isLoading = %@",_isLoadingData?@"Y":@"N");
    _iPageNumber++;
    if (aSearchBarText.length) {
        // Must be implemented
    } else {
        [_iInteractor getPopularMoviesWithPage:_iPageNumber isNext:YES];
    }
}

//MARK: - HomeListInteractorDelegate
- (void) dataFetchingResults:(NSArray*)items totalPages:(float)totalPages isNext:(BOOL)isNext
{
    
    if (self.iDelegate &&
        [self.iDelegate conformsToProtocol:@protocol(HomeListPresenterDelegate)]&&
        ([self.iDelegate respondsToSelector:@selector(startFetchingResults:totalPages:)]||
         [self.iDelegate respondsToSelector:@selector(nextFetchingResults:totalPages:)]))
    {
        if (isNext) {
            [self.iDelegate nextFetchingResults:items totalPages:totalPages];
        } else {
           [self.iDelegate startFetchingResults:items totalPages:totalPages];
        }
    }
}

@end
