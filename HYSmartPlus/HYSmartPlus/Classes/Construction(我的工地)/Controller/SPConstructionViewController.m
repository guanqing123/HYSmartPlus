//
//  SPConstructionViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/5/1.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#define searchViewH 44.0f

#import "SPConstructionViewController.h"
#import "SPSiteCreateViewController.h"
#import "SPSearchBar.h"
#import "SPConstructionTableCell.h"
#import "MJRefresh.h"
#import "SPConstructionTool.h"
#import "SPAccountTool.h"
#import "SPLoginResult.h"

@interface SPConstructionViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
// 搜索条
@property (nonatomic, weak)  UIView *searchView;
// 搜索内容
@property (nonatomic, copy) NSString *searchText;
// tableView
@property (nonatomic, weak) UITableView  *tableView;

@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, strong)  NSMutableArray *dropowerArray;

@end

@implementation SPConstructionViewController

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
    self.view.backgroundColor = SPBGColor;
    
    // rightItem
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"add"] withHighLightedImage:[UIImage imageNamed:@"add"] target:self action:@selector(add)];
}

#pragma mark - 创建工地
- (void)add {
    SPSiteCreateViewController *siteVc = [[SPSiteCreateViewController alloc] init];
    siteVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:siteVc animated:YES];
}

#pragma mark - 设置搜索框
- (void)setupSearchBar {
    UIView *searchView = [[UIView alloc] init];
    searchView.backgroundColor = [UIColor whiteColor];
    searchView.frame = CGRectMake(0, SPTopNavH, ScreenW, searchViewH);
    _searchView = searchView;
    [self.view addSubview:searchView];
    
    SPSearchBar *searchBar = [SPSearchBar searchBar];
    searchBar.placeholder = @"业主电话";
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
}

#pragma mark - 搜索框文本变化
- (void)textFieldDidChange:(UITextField *)textField {
    self.searchText = textField.text;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - setupTableView
- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, self.searchView.dc_bottom, ScreenW, ScreenH - self.searchView.dc_bottom - SPBottomTabH);
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
    self.pageSize = 2;
    
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    }
}

- (void)headerRefreshing {
    _pageNum = 1;
    SPDropowerFenyeParam *fenyeParam = [[SPDropowerFenyeParam alloc] init];
    fenyeParam.uid = [SPAccountTool loginResult].userbase.uid;
    fenyeParam.pageNum = self.pageNum;
    fenyeParam.pageSize = self.pageSize;
    [SPConstructionTool getDropowerAndDetailsFenye:fenyeParam success:^(SPDropowerFenyeResult *fenyeResult) {
        if (![fenyeResult.code isEqualToString:@"00000"]) {
            [self.tableView.mj_header endRefreshing];
            [MBProgressHUD showError:fenyeResult.msg toView:self.view];
        }else{
            [self.dropowerArray removeAllObjects];
            [self.dropowerArray addObjectsFromArray:fenyeResult.dropowerFenye.list];
            if (fenyeResult.dropowerFenye.pages > 1) {
                _pageNum ++;
                [self setupFooterRefreshing];
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
    SPDropowerFenyeParam *fenyeParam = [[SPDropowerFenyeParam alloc] init];
    fenyeParam.uid = [SPAccountTool loginResult].userbase.uid;
    fenyeParam.pageNum = self.pageNum;
    fenyeParam.pageSize = self.pageSize;
    [SPConstructionTool getDropowerAndDetailsFenye:fenyeParam success:^(SPDropowerFenyeResult *fenyeResult) {
        if (![fenyeResult.code isEqualToString:@"00000"]) {
            [MBProgressHUD showError:fenyeResult.msg toView:self.view];
        }else{
            [self.dropowerArray addObjectsFromArray:fenyeResult.dropowerFenye.list];
            [self.tableView reloadData];
            _pageNum ++;
            NSInteger totalPage = fenyeResult.dropowerFenye.pages;
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

#pragma mark lazyLoad
- (NSMutableArray *)dropowerArray {
    if (!_dropowerArray) {
        _dropowerArray = [NSMutableArray array];
    }
    return _dropowerArray;
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dropowerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPConstructionTableCell *cell = [SPConstructionTableCell cellWithTableView:tableView];
    
    SPDropower *dropower = self.dropowerArray[indexPath.row];
    cell.dropower = dropower;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (ScreenW - (column + 1) * margin)/column + topTextViewH + bottomToolBarViewH + 4 * margin;
}

@end
