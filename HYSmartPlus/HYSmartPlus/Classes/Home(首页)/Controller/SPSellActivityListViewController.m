//
//  SPSellActivityListViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/6/13.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#define searchViewH 44.0f

#import "SPSellActivityListViewController.h"
#import "SPSellActivityDetailViewController.h"
#import "SPSearchBar.h"
#import "MJRefresh.h"

#import "SPNonTopTableViewCell.h"

#import "SPIndexTool.h"
#import "SPAccountTool.h"
#import "SPLoginResult.h"

@interface SPSellActivityListViewController () <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
// 搜索条
@property (nonatomic, weak)  UIView *searchView;
// 搜索内容
@property (nonatomic, copy) NSString *searchText;
// tableView
@property (nonatomic, weak) UITableView  *tableView;

@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, strong)  NSMutableArray *sellActivityList;

@end

@implementation SPSellActivityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1.设置导航与背景
    [self setupNavBar];
    
    //2.设置搜索框
    [self setupSearchBar];
    
    //3.初始化 UITableView
    [self setupTableView];
}

#pragma mark - 设置导航与背景
- (void)setupNavBar {
    self.title = @"安家帮";
    self.view.backgroundColor = SPBGColor;
}

#pragma mark - 设置搜索框
- (void)setupSearchBar {
    UIView *searchView = [[UIView alloc] init];
    searchView.backgroundColor = [UIColor whiteColor];
    searchView.frame = CGRectMake(0, SPTopNavH, ScreenW, searchViewH);
    _searchView = searchView;
    [self.view addSubview:searchView];
    
    SPSearchBar *searchBar = [SPSearchBar searchBar];
    searchBar.placeholder = @"标题";
    searchBar.keyboardType = UIKeyboardTypeDefault;
    searchBar.returnKeyType = UIReturnKeyDone;
    searchBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    searchBar.layer.borderWidth = 0.2;
    searchBar.layer.cornerRadius = 4;
    searchBar.backgroundColor = RGB(244, 244, 244);
    [searchView addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(searchView).with.insets(UIEdgeInsetsMake(SPMargin*0.5, SPMargin, SPMargin*0.5, SPMargin));
    }];
    searchBar.delegate = self;
    [searchBar addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    searchBar.inputAccessoryView = [[UIView alloc] init];
    searchBar.returnKeyType = UIReturnKeySearch;
}

#pragma mark - 搜索框文本变化
- (void)textFieldDidChange:(UITextField *)textField {
    self.searchText = textField.text;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self.tableView.mj_header beginRefreshing];
    return YES;
}

#pragma mark - setupTableView
- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, self.searchView.dc_bottom, ScreenW, ScreenH - self.searchView.dc_bottom);
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.backgroundColor = RGB(244, 244, 244);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    [self.tableView.mj_header beginRefreshing];
    self.pageNum = 1;
    self.pageSize = 10;
    
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
}

- (void)headerRefreshing {
    _pageNum = 1;
    
    SPSellActivityFenyeParam *fenyeParam = [[SPSellActivityFenyeParam alloc] init];
    fenyeParam.userid = [SPAccountTool loginResult].userbase.uid;
    fenyeParam.pageNum = self.pageNum;
    fenyeParam.pageSize = self.pageSize;
    fenyeParam.content = self.searchText;
    
    [SPIndexTool getSellingActivityFenye:fenyeParam success:^(SPSellActivityFenyeResult *fenyeResult) {
        if (![fenyeResult.code isEqualToString:@"00000"]) {
            [self.tableView.mj_header endRefreshing];
            [MBProgressHUD showError:fenyeResult.msg toView:self.view];
        }else{
            [self.sellActivityList removeAllObjects];
            [self.sellActivityList addObjectsFromArray:fenyeResult.sellActivityFenye.list];
            if (fenyeResult.sellActivityFenye.pages > 1) {
                _pageNum ++;
                [self setupFooterRefreshing];
            }else{
                self.tableView.mj_footer = nil;
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD showError:@"网络异常" toView:self.view];
    }];
}

- (void)setupFooterRefreshing {
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
}

- (void)footerRefreshing {
    SPSellActivityFenyeParam *fenyeParam = [[SPSellActivityFenyeParam alloc] init];
    fenyeParam.userid = [SPAccountTool loginResult].userbase.uid;
    fenyeParam.pageNum = self.pageNum;
    fenyeParam.pageSize = self.pageSize;
    fenyeParam.content = self.searchText;
    
    [SPIndexTool getSellingActivityFenye:fenyeParam success:^(SPSellActivityFenyeResult *fenyeResult) {
        if (![fenyeResult.code isEqualToString:@"00000"]) {
            [self.tableView.mj_footer endRefreshing];
            [MBProgressHUD showError:fenyeResult.msg toView:self.view];
        }else{
            [self.sellActivityList addObjectsFromArray:fenyeResult.sellActivityFenye.list];
            [self.tableView reloadData];
            _pageNum ++;
            NSInteger totalPage = fenyeResult.sellActivityFenye.pages;
            if (_pageNum > totalPage) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD showError:@"网络异常" toView:self.view];
    }];
}

#pragma mark -lazyLoad
- (NSMutableArray *)sellActivityList {
    if (!_sellActivityList) {
        _sellActivityList = [NSMutableArray array];
    }
    return _sellActivityList;
}

#pragma mark - tableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sellActivityList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPNonTopTableViewCell *nonTopCell = [SPNonTopTableViewCell cellWithTableView:tableView];
    SPSellActivity *sellActivity = [self.sellActivityList objectAtIndex:indexPath.row];
    nonTopCell.sellActivity = sellActivity;
    return nonTopCell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SPSellActivityDetailViewController *sellActivityDetailVc = [[SPSellActivityDetailViewController alloc] init];
    sellActivityDetailVc.view.backgroundColor = SPBGColor;
    SPSellActivity *sellActivity = [self.sellActivityList objectAtIndex:indexPath.row];
    sellActivityDetailVc.sellActivity = sellActivity;
    [self.navigationController pushViewController:sellActivityDetailVc animated:YES];
}

@end
