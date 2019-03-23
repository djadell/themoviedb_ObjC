//
//  HomeListVC.m
//  MovieApp
//
//  Created by David Adell on 23/3/19.
//  Copyright © 2019 djadell. All rights reserved.
//

#import "HomeListVC.h"
#import "HomeListCell.h"


@interface HomeListVC () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *iTable;

@end

@implementation HomeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//MARK: - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15; ///TODO: DEBUG hardcoded data! O.o
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeListCell class])];
    
    if(!cell) {
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeListCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HomeListCell class])];
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeListCell class])];
    }
    
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
