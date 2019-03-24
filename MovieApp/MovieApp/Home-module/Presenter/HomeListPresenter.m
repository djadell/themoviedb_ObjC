//
//  HomeListPresenter.m
//  MovieApp
//
//  Created by David Adell on 24/3/19.
//  Copyright © 2019 djadell. All rights reserved.
//

#import "HomeListPresenter.h"
#import "HomeListInteractor.h"


@interface HomeListPresenter ()
{
    int iPageNumber;
}

@property (strong,nonatomic) HomeListVC* iHomeView;

@end

@implementation HomeListPresenter

- (id) initWithHomeListVC:(HomeListVC*)iHomeListVC
{
    self = [super init];
    
    if (self) {
        _iHomeView = iHomeListVC;
    }
    
    return self;
}

-(void)resetResults:(NSString*)aSearchBarText
{
    NSArray *maTemp = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4", nil];
    iPageNumber = 1;
    // Must be implemented
    
    [self startFetchingNextResults];
    
    //return maTemp;
}

- (void)startFetchingNextResults
{
    NSArray *maTemp = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4", nil];
    // Must be implemented
    
    if (self.iDelegate &&
        [self.iDelegate conformsToProtocol:@protocol(HomeListPresenterDelegate)]&&
        [self.iDelegate respondsToSelector:@selector(startFetchingResults:totalPages:)])
    {
        [self.iDelegate startFetchingResults:maTemp totalPages:iPageNumber];
    }
}


@end
