//
//  SPSettingViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/5/11.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPSettingViewController.h"
#import "SPHeadImageCollectionViewController.h"
#import "SPDiscountViewController.h"
#import "SPInviteFriendViewController.h"
#import "SPAboutMeViewController.h"

#import "SPSettingTopView.h"
#import "SPSettingTableViewCell.h"


#import "SPAccountTool.h"
#import "SDWebImageManager.h"

#import "SPNavigationController.h"
#import "SPLoginViewController.h"

@interface SPSettingViewController () <UITableViewDataSource,UITableViewDelegate,SPSettingTopViewDelegate>

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
    self.dataArray = @[@"清除缓存",@"关于我们"];
}

#pragma mark - 头部View
- (void)setUpHeaderView {
    SPSettingTopView *topView = [SPSettingTopView topView];
    topView.bounds = (CGRect){CGPointZero,CGSizeMake(ScreenW, 190)};
    topView.delegate = self;
    [topView setData];
    _topView = topView;
    self.tableView.tableHeaderView = topView;
    WEAKSELF
    topView.headerViewBlock = ^{
        SPHeadImageCollectionViewController *headImageVc = [[SPHeadImageCollectionViewController alloc] init];
        headImageVc.headImgeBlock = ^{
            [weakSelf refreshHeaderView];
        };
        [weakSelf.navigationController pushViewController:headImageVc animated:YES];
    };
}

#pragma mark - 刷新头部
- (void)refreshHeaderView {
    [self.topView setData];
    !_settingVcBlock ? : _settingVcBlock();
}

#pragma mark - SPSettingTopViewDelegate
- (void)topView:(SPSettingTopView *)topView buttonType:(SettingTopViewButtonType)buttonType {
    switch (buttonType) {
        case SettingTopViewButtonTypeWx:
            [self wx];
            break;
        case SettingTopViewButtonTypeSdg:
            [self sdg];
            break;
        default:
            break;
    }
}

- (void)wx {
    SPDiscountViewController *discountVc = [[SPDiscountViewController alloc] init];
    discountVc.title = @"微信公众号";
    [self.navigationController pushViewController:discountVc animated:YES];
}

- (void)sdg {
    SPInviteFriendViewController *inviteFriendVc = [[SPInviteFriendViewController alloc] init];
    inviteFriendVc.title = @"邀请水电工";
    [self.navigationController pushViewController:inviteFriendVc animated:YES];
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

#pragma mark - loginOffClick
- (void)loginOffClick {
    
    //alertVc
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"温馨提醒" message:@"是否确定退出登录" preferredStyle:UIAlertControllerStyleActionSheet];
    
    //取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //确定
    WEAKSELF
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [SPAccountTool deleteLoginResult];
        SPNavigationController *nav = [[SPNavigationController alloc] initWithRootViewController:[[SPLoginViewController alloc] init]];
        [weakSelf presentViewController:nav animated:YES completion:nil];
    }];
    
    [alertVc addAction:sureAction];
    [alertVc addAction:cancelAction];
    
    [self presentViewController:alertVc animated:YES completion:nil];
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
    
    settingCell.titleLabel.text = self.dataArray[indexPath.row];
    
    return settingCell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [[SDWebImageManager sharedManager].imageCache clearMemory];
        [MBProgressHUD showSuccess:@"清楚完毕" toView:self.view];
    }else if(indexPath.row == 1) {
        SPAboutMeViewController *aboutMe = [[SPAboutMeViewController alloc] init];
        [self.navigationController pushViewController:aboutMe animated:YES];
    }
}

@end
