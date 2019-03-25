//
//  HomeListVC.m
//  MovieApp
//
//  Created by David Adell on 23/3/19.
//  Copyright © 2019 djadell. All rights reserved.
//

#import "HomeListVC.h"
#import "HomeListCell.h"
#import "HomeListPresenter.h"
#import "JTTableViewController.h"

#define K_MAX_ROWS_PAGE 20
#define KCELL_HEIGHT 195

@interface HomeListVC () <UITableViewDelegate,UITableViewDataSource,JTTableViewControllerDelegate,HomeListPresenterDelegate,UISearchBarDelegate>

@property (strong, nonatomic) JTTableViewController *iJTTableVC;
@property (weak, nonatomic) IBOutlet UITableView *iTable;
@property (weak, nonatomic) IBOutlet UISearchBar *iSearchBar;

@property (strong, nonatomic) HomeListPresenter *iPresenter;
@property (strong, nonatomic) NSArray *iMovieList;

@end

@implementation HomeListVC

//MARK: - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_iPresenter) {
        _iPresenter = [[HomeListPresenter alloc] initWithHomeListVC:self];
        [_iPresenter setIDelegate:self];
    }
    _iJTTableVC = [JTTableViewController new];
    [_iJTTableVC setILoadingCellXib:@"JTTableLoadingCell"];
    [_iJTTableVC setTableView:_iTable];
    [_iTable setDataSource:_iJTTableVC];
    [_iTable setDelegate:_iJTTableVC];
    [_iJTTableVC setIDelegate:self];
    
    [_iPresenter resetResults:_iSearchBar.text];
}

//MARK: - UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //Disabled
}

//MARK: - JTTableViewControllerDelegate
- (void)startFetchingResults
{
    //Disabled
}

- (void)startFetchingNextResults
{
    NSLog(@"[DEBUG] startFetchingNextResults");
    [_iPresenter startFetchingNextResults:_iSearchBar.text];
}

//MARK: - HomeListPresenterDelegate
- (void) startFetchingResults:(NSArray*)items totalPages:(float)totalPages
{
    [self.iJTTableVC didFetchResults:items haveMoreData:([items count] >= K_MAX_ROWS_PAGE)];
}

- (void) nextFetchingResults:(NSArray*)items totalPages:(float)totalPages
{
    [self.iJTTableVC didFetchNextResults:items haveMoreData:([items count] >= K_MAX_ROWS_PAGE)];
    [self.iJTTableVC.tableView reloadData];
}



//MARK: - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Automatically return the height of nextPageLoaderCell, by default use UITableViewAutomaticDimension
    //JTTABLEVIEW_heightForRowAtIndexPath
    return KCELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_iJTTableVC.isLoadingCellXib) {
        return _iJTTableVC.nextPageLoaderCell;
    }
    
    HomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeListCell class])];
    
    if(!cell) {
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeListCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HomeListCell class])];
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeListCell class])];
    }
    // Must be implemented
    cell.iMovie = _iJTTableVC.results[indexPath.row];
    
    return cell;
}

//MARK: - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:K_TABLE_SELECTION_ANIMATION];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}



@end
