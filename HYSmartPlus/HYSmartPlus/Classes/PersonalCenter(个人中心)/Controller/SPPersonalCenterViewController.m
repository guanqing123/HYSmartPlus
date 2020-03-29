//
//  SPPersonalCenterViewController.m
//  HYSmartPlus
//
//  Created by information on 2017/11/24.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPPersonalCenterViewController.h"
#import "MJExtension.h"

#import "SPSettingViewController.h"

#import "SPProblemViewController.h"
#import "SPInviteFriendViewController.h"

#import "SPDiscountViewController.h"

#import "SPStyleDIY.h"
#import "SPBindBossViewController.h"

#import "SPScoreViewController.h"

//顶部和头部View
#import "SPCenterTopToolView.h"
#import "SPPersonCenterHeaderView.h"

//cell
#import "SPProblemTableViewCell.h"
#import "SPServiceTableViewCell.h"
#import "SPIntegralTableViewCell.h"
#import "SPBPTableViewCell.h"

//Models
#import "SPServiceItem.h"

#import "SPLoginResult.h"
#import "SPAccountTool.h"
#import "SPPersonCenterTool.h"

@interface SPPersonalCenterViewController () <UITableViewDataSource,UITableViewDelegate,SPProblemTableViewCellDelegate,SPServiceTableViewCellDelegate,SPCenterTopToolViewDelegate,SPIntegralTableViewCellDelegate,SPBPTableViewCellDelegate>

/* headerView */
//@property (nonatomic, strong)  SPMyCenterHeaderView *headerView;

@property (nonatomic, strong)  SPPersonCenterHeaderView *headerView;

/** 头部背景图片 */
@property (nonatomic, strong)  UIImageView *headerBgImageView;
/** tableView */
@property (nonatomic, strong)  UITableView *tableView;
/* 顶部Nav */
@property (nonatomic, strong)  SPCenterTopToolView *topToolView;

/* 服务数据 */
@property (nonatomic, strong)  NSMutableArray<SPServiceItem *> *serviceItem;

@property (nonatomic, strong)  NSArray *integral;

@property (nonatomic, strong)  SPPersonScoreResult *result;

@property (nonatomic, strong)  SPProblemResult *problemResult;

@property (nonatomic, strong)  SPBindBossViewController *scanVc;

@end

static NSString *const SPProblemCellID = @"SPProblemCellID";
static NSString *const SPServiceCellID = @"SPServiceCellID";
static NSString *const SPIntegralCellID = @"SPIntegralCellID";
static NSString *const SPBPCellID = @"SPBPCellID";

@implementation SPPersonalCenterViewController

#pragma mark - lifeCycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    // 刷新积分
    [self refreshScore];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpBase];
    
    [self setUpNavTopView];
    
    [self setUpHeaderCenterView];
    
    [self setUpProblem];
}

- (void)viewDidAppear:(BOOL)animated {
    //NSLog(@"contentInset = %@",NSStringFromUIEdgeInsets(self.collectionView.contentInset));
    
    //NSLog(@"safeAreaInsets = %@",NSStringFromUIEdgeInsets(self.collectionView.safeAreaInsets));
    
    
    //NSLog(@"adjustedContentInset = %@",NSStringFromUIEdgeInsets(self.collectionView.adjustedContentInset));
}

#pragma mark - 刷新积分
- (void)refreshScore {
    [MBProgressHUD showMessage:@"刷新积分..." toView:self.view];
    SPPersonScoreParam *param = [SPPersonScoreParam param:APP00008];
    param.uid = [SPAccountTool loginResult].userbase.uid;
    [SPPersonCenterTool getPersonScore:param success:^(SPPersonScoreResult *result) {
        [MBProgressHUD hideHUDForView:self.view];
        if (result.error) {
            [MBProgressHUD showError:result.errorMsg toView:self.view];
        }else{
            self.result = result;
            [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(2, 2)] withRowAnimation:UITableViewRowAnimationFade];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络异常" toView:self.view];
    }];
}

#pragma mark - rewrite
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - initialize
- (void)setUpBase {
    self.view.backgroundColor = SPBGColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
    if (@available(ios 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)setUpNavTopView {
    _topToolView = [[SPCenterTopToolView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 64)];
    _topToolView.delegate = self;
    [self.view addSubview:_topToolView];
}

- (void)setUpHeaderCenterView {
    SPPersonCenterHeaderView *headerView = [SPPersonCenterHeaderView headerView];
    WEAKSELF
    headerView.headImageBlock = ^{
        [weakSelf openSettingVc];
    };
    headerView.frame = (CGRect){CGPointZero,CGSizeMake(ScreenW, 200)};
    _headerView = headerView;
    [headerView setData];
    self.tableView.tableHeaderView = headerView;
    self.headerBgImageView.frame = headerView.bounds;
    [self.headerView insertSubview:self.headerBgImageView atIndex:0]; //将背景图片放到最底层*/
}

#pragma mark - SPCenterTopToolViewDelegate
- (void)centerTopToolView:(SPCenterTopToolView *)topToolView buttonType:(TopToolBarButtonType)buttonType {
    switch (buttonType) {
        case TopToolBarButtonTypeScan:
            [self openScanVCWithStyle:[SPStyleDIY ZhiFuBaoStyle]];
            break;
        case TopToolBarButtonTypeSetting:
            [self openSettingVc];
            break;
        default:
            break;
    }
}

- (void)openSettingVc {
    SPSettingViewController *settingVc = [[SPSettingViewController alloc] init];
    WEAKSELF
    settingVc.settingVcBlock = ^{
        [weakSelf.headerView setData];
    };
    [self.navigationController pushViewController:settingVc animated:YES];
}

#pragma mark - LazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - SPBottomTabH);
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[SPProblemTableViewCell class] forCellReuseIdentifier:SPProblemCellID];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SPServiceTableViewCell class]) bundle:nil] forCellReuseIdentifier:SPServiceCellID];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SPIntegralTableViewCell class]) bundle:nil] forCellReuseIdentifier:SPIntegralCellID];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SPBPTableViewCell class]) bundle:nil]
            forCellReuseIdentifier:SPBPCellID];
    }
    return _tableView;
}

- (UIImageView *)headerBgImageView {
    if (!_headerBgImageView) {
        _headerBgImageView = [[UIImageView alloc] init];
        NSInteger armNum = [SPSpeedy dc_getRandomNumber:1 to:9];
        [_headerBgImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"mine_main_bg_%zd",armNum]]];
        [_headerBgImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_headerBgImageView setClipsToBounds:YES];
    }
    return _headerBgImageView;
}

- (NSMutableArray<SPServiceItem *> *)serviceItem {
    if (!_serviceItem) {
        _serviceItem = [SPServiceItem mj_objectArrayWithFilename:@"MyServiceFlow.plist"];
    }
    return _serviceItem;
}

#pragma mark - setUpProblem
- (void)setUpProblem {
    SPProblemParam *param = [SPProblemParam param:HYXK00006];
    [SPPersonCenterTool getProblem:param success:^(SPProblemResult *result) {
        if (result.error) {
            [MBProgressHUD showError:result.errorMsg toView:self.view];
        }else{
            self.problemResult = result;
            [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"常用问题加载异常" toView:self.view];
    }];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cusCell = [UITableViewCell new];
    if (indexPath.section == 0) {
        SPProblemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SPProblemCellID forIndexPath:indexPath];
        cell.delegate = self;
        cell.result = self.problemResult;
        cusCell = cell;
    }else if(indexPath.section == 1){
        SPServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SPServiceCellID forIndexPath:indexPath];
        cell.delegate = self;
        cell.serviceItem = self.serviceItem;
        cusCell = cell;
    }else if (indexPath.section == 2){
        SPIntegralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SPIntegralCellID forIndexPath:indexPath];
        cusCell = cell;
        cell.result = self.result;
        cell.delegate = self;
    }else if (indexPath.section == 3){
        SPBPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SPBPCellID forIndexPath:indexPath];
        cusCell = cell;
        cell.result = self.result;
        cell.delegate = self;
    }
    cusCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cusCell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        return 60;
    }else if(indexPath.section == 1) {
        return 120;
    }else if (indexPath.section == 2) {
        return 245;
    }else if (indexPath.section == 3) {
        return 150;
    }
    return 0;
}

#pragma mark - SPIntegralTableViewCellDelegate
- (void)integralTableViewCellDidClickIntegralBtn:(SPIntegralTableViewCell *)integralTableViewCell {
    NSString *urlPath = [[NSString alloc] initWithFormat:@"http://sge.cn/web/jifen/integralList?userid=%@&khdm=%@",[SPAccountTool loginResult].userbase.uid,@"00000000"];
    SPScoreViewController *scoreVc = [[SPScoreViewController alloc] initWithUrlPath:urlPath title:@"品牌积分"];
    [self.navigationController pushViewController:scoreVc animated:YES];
}

#pragma mark - SPBPTableViewCellDelegate
- (void)bpTableViewCell:(SPBPTableViewCell *)tabelViewCell bpBtnClick:(NSString *)khdm {
    NSString *urlPath = [[NSString alloc] initWithFormat:@"http://sge.cn/web/jifen/integralList?userid=%@&khdm=%@",[SPAccountTool loginResult].userbase.uid,khdm];
    SPScoreViewController *scoreVc = [[SPScoreViewController alloc] initWithUrlPath:urlPath title:@"门店积分"];
    [self.navigationController pushViewController:scoreVc animated:YES];
}

#pragma mark - SPProblemTableViewCellDelegate
- (void)problemTableViewCellDidMoreProblem:(SPProblemTableViewCell *)tableViewCell {
    SPProblemViewController *problemVc = [[SPProblemViewController alloc] init];
    problemVc.result = self.problemResult;
    [self.navigationController pushViewController:problemVc animated:YES];
}

#pragma mark - SPServiceTableViewCellDelegate
- (void)serviceTableViewCell:(SPServiceTableViewCell *)tableViewCell didClickCollectionViewItem:(SPServiceItem *)serviceItem {
    switch (serviceItem.serviceType) {
        case PersonCenterServiceSignIn:
            [self doSignIn];
            break;
        case PersonCenterServiceInviteFriend:
            [self doInviteFriend];
            break;
        case PersonCenterServiceDiscount:
            [self doDiscount];
            break;
        case PersonCenterServiceBindBoss:
            [self openScanVCWithStyle:[SPStyleDIY InnerStyle]];
            break;
        default:
            break;
    }
}

- (SPBindBossViewController *)scanVc {
    if (!_scanVc) {
        _scanVc = [[SPBindBossViewController alloc] init];
        _scanVc.isOpenInterestRect = YES;
        _scanVc.libraryType = SLT_Native;
        _scanVc.scanCodeType = SCT_QRCode;
    }
    return _scanVc;
}

- (void)openScanVCWithStyle:(LBXScanViewStyle *)style {
    self.scanVc.style = style;
    [self.navigationController pushViewController:self.scanVc animated:YES];
}


- (void)doSignIn {
    SPSignInParam *param = [SPSignInParam param:APP00007];
    param.uid = [SPAccountTool loginResult].userbase.uid;
    [SPPersonCenterTool doSignIn:param success:^(SPSignInResult *result) {
        if (result.error) {
            [MBProgressHUD showError:result.errorMsg toView:self.view];
        }else{
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"恭喜" message:@"今日签到成功" preferredStyle:UIAlertControllerStyleAlert];
            WEAKSELF
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf refreshScore];
            }];
            [alertVc addAction:sureAction];
            [self presentViewController:alertVc animated:YES completion:nil];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络异常,签到失败" toView:self.view];
    }];
}

- (void)doInviteFriend {
    SPInviteFriendViewController *inviteFriendVc = [[SPInviteFriendViewController alloc] init];
    [self.navigationController pushViewController:inviteFriendVc animated:YES];
}

- (void)doDiscount {
    SPDiscountViewController *discountVc = [[SPDiscountViewController alloc] init];
    [self.navigationController pushViewController:discountVc animated:YES];
}


#pragma mark -  滚动tableview 完毕之后
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _topToolView.hidden = (scrollView.contentOffset.y < 0) ? YES : NO;
    
    _topToolView.backgroundColor = (scrollView.contentOffset.y > 64) ? RGB(0, 0, 0) : [UIColor clearColor];
    
    //图片高度
    CGFloat imageHeight = self.headerView.dc_height;
    //图片宽度
    CGFloat imageWidth = ScreenW;
    //图片上下偏移量
    CGFloat imageOffsetY = scrollView.contentOffset.y;
    //上移
    if (imageOffsetY < 0) {
        CGFloat totalOffset = imageHeight + ABS(imageOffsetY);
        CGFloat f = totalOffset / imageHeight;
        self.headerBgImageView.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
    }
}

#pragma mark - 屏幕横竖屏设置
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
@end
