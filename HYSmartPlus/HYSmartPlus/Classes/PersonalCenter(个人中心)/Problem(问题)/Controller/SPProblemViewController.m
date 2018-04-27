//
//  SPProblemViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/4/27.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPProblemViewController.h"
#import "SPProblem.h"

#import "WCCommonProblemCell.h"
#import "WCCommonProblemHeaderView.h"

@interface SPProblemViewController () <UISearchResultsUpdating,UISearchBarDelegate,WCCommonProblemHeaderViewDelegate>

@property (nonatomic, strong) UISearchController  *searchController;

@property (nonatomic, strong)  NSMutableArray *searchArray;
@property (nonatomic, strong)  NSMutableArray *modelArray;
@property (nonatomic, strong)  NSMutableArray *questionArray;
@property (strong, nonatomic) NSMutableArray *searchedModelArray;
@property (nonatomic, strong)  NSDictionary *dict;

@end

@implementation SPProblemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"常见问题";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    //Attempting to load the view of a view controller while it is deallocating is not allowed and may result in undefined behavior (<UISearchController: 0x7f9ce3921fb0>)
    //[_searchController loadViewIfNeeded]; 9.0 这句话可以解决这个问题,但是要求 9.0
    _searchController.view.backgroundColor = [UIColor clearColor]; // 用这句话也可以解决
    _searchController.searchResultsUpdater = self;
    _searchController.dimsBackgroundDuringPresentation = NO;
    [_searchController.searchBar sizeToFit];
    _searchController.searchBar.delegate = self;
    _searchController.searchBar.placeholder = @"关键字搜索";
    _searchController.hidesNavigationBarDuringPresentation = YES;
    
    self.tableView.tableHeaderView = _searchController.searchBar;
    self.definesPresentationContext = YES;
}

#pragma mark - lazyload
- (NSMutableArray *)modelArray {
    if (_modelArray == nil) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

- (NSMutableArray *)questionArray {
    if (_questionArray == nil) {
        _questionArray = [NSMutableArray array];
    }
    return _questionArray;
}

- (NSMutableArray *)searchedModelArray {
    if (_searchedModelArray == nil) {
        _searchedModelArray = [NSMutableArray array];
    }
    return _searchedModelArray;
}

#pragma mark - loadData
- (void)setResult:(SPProblemResult *)result {
    _result = result;
    [self.modelArray removeAllObjects];
    [self.questionArray removeAllObjects];
    [self.modelArray addObjectsFromArray:result.list];
    for (SPProblem *problem in self.modelArray) {
        [self.questionArray addObject:problem.faq_question];
    }
    self.dict = [[NSDictionary alloc] initWithObjects:self.modelArray forKeys:self.questionArray];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_searchController.active) {
        return _searchArray.count;
    }else{
        return _modelArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_searchController.active) {
        SPProblem *problem = [_searchedModelArray objectAtIndex:section];
        return problem.isOpened ? 1 : 0;
    }else{
        SPProblem *problem = [_modelArray objectAtIndex:section];
        return problem.isOpened ? 1 : 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WCCommonProblemCell *cell = [WCCommonProblemCell cellWithTableView:tableView];
    if (_searchController.active) {
        SPProblem *problem = [_searchedModelArray objectAtIndex:indexPath.section];
        cell.problem = problem;
    }else{
        SPProblem *problem = self.modelArray[indexPath.section];
        cell.problem = problem;
    }
    return cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WCCommonProblemHeaderView *headerView = [WCCommonProblemHeaderView headerViewWithTableView:tableView];
    headerView.delegate = self;
    
    if (_searchController.active) {
        SPProblem *problem = self.searchedModelArray[section];
        headerView.problem = problem;
    }else{
        SPProblem *problem = self.modelArray[section];
        headerView.problem = problem;
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 345.0f;
}

#pragma mark - WCCommonProblemHeaderViewDelegateDelegate
- (void)headerViewDidClickedNameView:(WCCommonProblemHeaderView *)headerView {
    [self.tableView reloadData];
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@",searchString];
    if (_searchArray != nil) {
        [_searchArray removeAllObjects];
    }
    if (self.searchedModelArray.count > 0) {
        [self.searchedModelArray removeAllObjects];
    }
    _searchArray = [NSMutableArray arrayWithArray:[_questionArray filteredArrayUsingPredicate:predicate]];
    for (int i = 0; i < _searchArray.count; i++) {
        [self.searchedModelArray addObject:[_dict objectForKey:_searchArray[i]]];
    }
    [self.tableView reloadData];
}

@end
