//
//  SPIndexViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/6/11.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPIndexViewController.h"
#import "SPSliderHeadView.h"

@interface SPIndexViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)  UITableView *tableView;
@end

@implementation SPIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupBase];
}

#pragma mark - setupBase
- (void)setupBase {
    self.navigationItem.title = @"鸿雁安+";
    self.view.backgroundColor = SPBGColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
    SPSliderHeadView *headerView = [SPSliderHeadView headerView];
    headerView.frame = CGRectMake(0, 0, ScreenW, ScreenW / 3);
    self.tableView.tableHeaderView = headerView;
}

#pragma mark tableView
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - SPBottomTabH);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
