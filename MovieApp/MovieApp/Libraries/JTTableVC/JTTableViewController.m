//
//  JTTableViewController.m
//  JTTableViewController
//
//  Created by Jonathan Tribouharet
//

#import "JTTableViewController.h"



@implementation JTTableViewController


- (id)initWithLoadingCell:(NSString *)sCellIndetifier
{
    self = [super init];
    if(!self){
        return nil;
    }
    [self commonInit];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)commonInit
{
    self->_isLoading = NO;
    self->_haveMoreData = NO;
    self->_results = [NSMutableArray new];
    self.nextPageLoaderOffset = 3;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // If startFetchingResults was called before the view exist
    if(self.results.count == 0 && self.isLoading){
        [self showNoResultsLoadingView];
    }
}

- (void)resetData
{
    self->_isLoading = NO;
    self->_haveMoreData = NO;
    [self.results removeAllObjects];
    [self.tableView reloadData];
}

#pragma mark - TableView

- (void)setTableView:(UITableView *)tableView
{
    [self.tableView setDataSource:nil];
    [self.tableView setDelegate:nil];
    
    self->_tableView = tableView;
    
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    self.nextPageLoaderCell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:self.iLoadingCellXib];
    if (self.nextPageLoaderCell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:self.iLoadingCellXib owner:self options:nil];
        self.nextPageLoaderCell = (UITableViewCell *)[nib objectAtIndex:0];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.haveMoreData && self.nextPageLoaderCell){
        return [self.results count] + 1;
    }
    
    return [self.results count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    CGFloat nextPageLoaderCellHeight = CGRectGetHeight(self.nextPageLoaderCell.frame);
    if(indexPath.row == [self.results count] && nextPageLoaderCellHeight > 0){
        return nextPageLoaderCellHeight;
    }

    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == [self.results count]){
        //return self.nextPageLoaderCell;
        self.isLoadingCellXib = YES;
    }else if(!self.isLoading && indexPath.row >= self.results.count - self.nextPageLoaderOffset && self.haveMoreData){
        self.isLoadingCellXib = NO;
        [self startFetchingNextResults];
    }else{
        self.isLoadingCellXib = NO;
    }
    UITableViewCell *cell = [self.iDelegate tableView:self.tableView cellForRowAtIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.iDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.iDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.iDelegate respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)])
        return [self.iDelegate tableView:tableView canEditRowAtIndexPath:indexPath];
    
    return NO;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.iDelegate tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - NoResultsView

- (void)setNoResultsView:(UIView *)noResultsView
{
    NSAssert(self.tableView, @"You have to set the tableView first");

    self->_noResultsView = noResultsView;
    [self.tableView.superview addSubview:self.noResultsView];
    
//    [self.noResultsView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.tableView);
//    }];
    
    self.noResultsView.hidden = YES;
    
    // Avoid noResultsView to block touch for the refresh control
    self.noResultsView.userInteractionEnabled = NO;
}

- (void)showNoResultsView
{
    self.noResultsView.hidden = NO;
}

- (void)hideNoResultsView
{
    self.noResultsView.hidden = YES;
}

#pragma mark - NoResultsLoadingView

- (void)setNoResultsLoadingView:(UIView *)noResultsLoadingView
{
    NSAssert(self.tableView, @"You have to set the tableView first");
    
    self->_noResultsLoadingView = noResultsLoadingView;
    [self.tableView.superview addSubview:self.noResultsLoadingView];
    
//    [self.noResultsLoadingView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.tableView);
//    }];
    
    self.noResultsLoadingView.hidden = YES;
}

- (void)showNoResultsLoadingView
{
    self.noResultsLoadingView.hidden = NO;
}

- (void)hideNoResultsLoadingView
{
    self.noResultsLoadingView.hidden = YES;
}

#pragma mark - Fetch results

- (void)didFetchResults:(NSArray *)results haveMoreData:(BOOL)haveMoreData
{
    self->_isLoading = NO;
    [self endRefreshing];
    [self hideNoResultsLoadingView];
    
    [self.results removeAllObjects];
    [self.results addObjectsFromArray:results];
        
    self->_haveMoreData = haveMoreData;
    [self.tableView reloadData];
    
    if(self.results.count == 0){
        [self showNoResultsView];
    }
}

- (void)didFetchNextResults:(NSArray *)results haveMoreData:(BOOL)haveMoreData
{
    self->_isLoading = NO;
    [self endRefreshing];
    [self hideNoResultsLoadingView];
    
    [self.results addObjectsFromArray:results];
    self->_haveMoreData = haveMoreData;
}

- (void)didFailedToFetchResults
{
    self->_isLoading = NO;
    [self endRefreshing];
    [self hideNoResultsLoadingView];
}

- (void)startFetchingResults
{    
    self->_isLoading = YES;
    [self.iDelegate startFetchingResults];
    [self hideNoResultsView];
    
    if(self.results.count == 0){
        [self showNoResultsLoadingView];
    }
}

- (void)startFetchingNextResults
{
    self->_isLoading = YES;
    [self.iDelegate startFetchingNextResults];
    [self hideNoResultsView];
}

- (void)endRefreshing
{
    
}

@end
