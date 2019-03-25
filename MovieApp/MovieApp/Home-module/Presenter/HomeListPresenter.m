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
    int iPageNumber;
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
    NSArray *maTemp = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4", nil];
    iPageNumber = 1;
    
    if (aSearchBarText.length) {
        // Must be implemented
    } else {
        [_iInteractor getPopularMoviesWithPage:iPageNumber];
    }
//    [self startFetchingNextResults];
    
    //return maTemp;
}

- (void)startFetchingNextResults
{
    // Must be implemented
    //iPageNumber++;
    
    
}

//MARK: - HomeListInteractorDelegate
- (void) dataFetchingResults:(NSArray*)items totalPages:(float)totalPages
{
    if (self.iDelegate &&
        [self.iDelegate conformsToProtocol:@protocol(HomeListPresenterDelegate)]&&
        [self.iDelegate respondsToSelector:@selector(startFetchingResults:totalPages:)])
    {
        [self.iDelegate startFetchingResults:items totalPages:totalPages];
    }
}

@end
