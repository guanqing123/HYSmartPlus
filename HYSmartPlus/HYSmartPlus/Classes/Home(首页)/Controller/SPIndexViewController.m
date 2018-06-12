//
//  SPIndexViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/6/11.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPIndexViewController.h"
#import "SPSliderHeadView.h"

#import "SPImageDetailViewController.h"
#import "SPHomeSectionHeaderView.h"
#import "SPTopTableViewCell.h"
#import "SPNonTopTableViewCell.h"

#import "SPIndexTool.h"
#import "SPAccountTool.h"
#import "SPLoginResult.h"

@interface SPIndexViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)  UITableView *tableView;
@property (nonatomic, strong)  NSArray *sellActivityList;
@end

@implementation SPIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupBase];
    
    [self setupHeaderView];
    
    [self setupTableData];
}

#pragma mark - setupBase
- (void)setupBase {
    self.navigationItem.title = @"鸿雁安+";
    self.view.backgroundColor = SPBGColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
}

#pragma mark tableView
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - SPBottomTabH);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sellActivityList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 140.0f;
    }
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPSellActivity *sellActivity = self.sellActivityList[indexPath.row];
    if (indexPath.row == 0) {
        SPTopTableViewCell *cell = [SPTopTableViewCell cellWithTableView:tableView];
        cell.sellActivity = sellActivity;
        return cell;
    }
    SPNonTopTableViewCell *cell = [SPNonTopTableViewCell cellWithTableView:tableView];
    cell.sellActivity = sellActivity;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 48.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SPHomeSectionHeaderView *sectionHeaderView = [SPHomeSectionHeaderView sectionHeaderView];
    return sectionHeaderView;
}

#pragma mark - setupHeaderView
- (void)setupHeaderView {
    SPSliderHeadView *headerView = [SPSliderHeadView headerView];
    WEAKSELF
    headerView.imageClickBlock = ^(SPHomePage *homePage) {
        SPImageDetailViewController *imageDetailVc = [[SPImageDetailViewController alloc] init];
        imageDetailVc.view.backgroundColor = SPBGColor;
        imageDetailVc.homePage = homePage;
        [weakSelf.navigationController pushViewController:imageDetailVc animated:YES];
    };
    headerView.frame = (CGRect){CGPointZero,CGSizeMake(ScreenW, ScreenW / 3)};
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - setupTableData
- (void)setupTableData {
    SPSellActivityParam *sellActivityParam = [[SPSellActivityParam alloc] init];
//    sellActivityParam.userid = [SPAccountTool loginResult].userbase.uid;
    sellActivityParam.userid = @"180321105710";
    WEAKSELF
    [SPIndexTool getSellingActivityTopFive:sellActivityParam success:^(SPSellActivityResult *result) {
        if (![result.code isEqualToString:@"00000"]) {
            [MBProgressHUD showError:result.msg toView:weakSelf.view];
        }else{
            self.sellActivityList = result.data;
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络异常" toView:weakSelf.view];
    }];
}

@end
