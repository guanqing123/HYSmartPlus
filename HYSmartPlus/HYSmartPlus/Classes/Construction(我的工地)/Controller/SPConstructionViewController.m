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

@interface SPConstructionViewController () <UITableViewDataSource,UITableViewDelegate>
// 搜索条
@property (nonatomic, weak)  UIView *searchView;
// tableView
@property (nonatomic, weak) UITableView  *tableView;

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
}

#pragma mark - setupTableView
- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, self.searchView.dc_bottom, ScreenW, ScreenH - self.searchView.dc_bottom);
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.backgroundColor = RGB(226, 226, 226);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPConstructionTableCell *cell = [SPConstructionTableCell cellWithTableView:tableView];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (ScreenW - (column + 1) * margin) / column + 144.0f;
}

@end
