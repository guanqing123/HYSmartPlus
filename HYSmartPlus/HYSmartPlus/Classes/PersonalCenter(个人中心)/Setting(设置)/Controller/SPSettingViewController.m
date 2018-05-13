//
//  SPSettingViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/5/11.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPSettingViewController.h"
#import "SPSettingTopView.h"
#import "SPSettingTableViewCell.h"

@interface SPSettingViewController () <UITableViewDataSource,UITableViewDelegate>

/** tableView */
@property (nonatomic, strong)  UITableView *tableView;

/** 头部View */
@property (nonatomic, strong)  SPSettingTopView *topView;

/** 数组 */
@property (nonatomic, strong)  NSArray *dataArray;

@end

static NSString *const SPSettingTableViewCellID = @"SPSettingTableViewCellID";

@implementation SPSettingViewController

#pragma mark - LazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, SPTopNavH, ScreenW, ScreenH - SPTopNavH);
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SPSettingTableViewCell class]) bundle:nil] forCellReuseIdentifier:SPSettingTableViewCellID];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpBase];
    
    [self setUpHeaderView];
    
    [self setUpFooterView];
}

#pragma mark - initialize
- (void)setUpBase {
    self.view.backgroundColor = SPBGColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.title = @"设置中心";
    
    self.dataArray = @[@"清除缓存",@"关于"];
}

#pragma mark - 头部View
- (void)setUpHeaderView {
    SPSettingTopView *topView = [SPSettingTopView topView];
    topView.bounds = (CGRect){CGPointZero,CGSizeMake(ScreenW, 190)};
    _topView = topView;
    self.tableView.tableHeaderView = topView;
}

#pragma mark - 退出登录
- (void)setUpFooterView {
    UIView *footerView = [UIView new];
    
    UIButton *loginOffButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginOffButton setTitle:@"退出登录" forState:0];
    loginOffButton.backgroundColor = RGB(235, 103, 98);
    loginOffButton.frame = CGRectMake(15, 35, ScreenW - 30, 45);
    [loginOffButton addTarget:self action:@selector(loginOffClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:loginOffButton];
    [SPSpeedy dc_setUpBezierPathCircularLayerWith:loginOffButton size:CGSizeMake(SPMargin, SPMargin)];
    footerView.dc_height = 80;
    self.tableView.tableFooterView = footerView;
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPSettingTableViewCell *settingCell = [tableView dequeueReusableCellWithIdentifier:SPSettingTableViewCellID];
    return settingCell;
}

@end
