//
//  SPPersonalCenterViewController.m
//  HYSmartPlus
//
//  Created by information on 2017/11/24.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPPersonalCenterViewController.h"
#import "MJExtension.h"

//顶部和头部View
#import "SPCenterTopToolView.h"
#import "SPMyCenterHeaderView.h"

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

@interface SPPersonalCenterViewController () <UITableViewDataSource,UITableViewDelegate>

/* headerView */
@property (nonatomic, strong)  SPMyCenterHeaderView *headerView;
/** 头部背景图片 */
@property (nonatomic, strong)  UIImageView *headerBgImageView;
/** tableView */
@property (nonatomic, strong)  UITableView *tableView;
/* 顶部Nav */
@property (nonatomic, strong)  SPCenterTopToolView *topToolView;

/* 服务数据 */
@property (nonatomic, strong)  NSMutableArray<SPServiceItem *> *serviceItem;

@property (nonatomic, strong)  NSArray *scrollArray;

@property (nonatomic, strong)  NSArray *integral;

@property (nonatomic, strong)  SPPersonScoreResult *result;

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
    
    SPPersonScoreParam *param = [SPPersonScoreParam param:APP00008];
    param.uid = [SPAccountTool loginResult].userbase.uid;
    [SPPersonCenterTool getPersonScore:param success:^(SPPersonScoreResult *result) {
        if (result.error) {
            [MBProgressHUD showError:result.errorMsg toView:self.view];
        }else{
            self.result = result;
            /*NSArray *indexPaths = @[[NSIndexPath indexPathWithIndex:1],[NSIndexPath indexPathWithIndex:2]];
            [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationMiddle];*/
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络异常" toView:self.view];
    }];
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
}

- (void)viewDidAppear:(BOOL)animated {
    //NSLog(@"contentInset = %@",NSStringFromUIEdgeInsets(self.collectionView.contentInset));
    
    //NSLog(@"safeAreaInsets = %@",NSStringFromUIEdgeInsets(self.collectionView.safeAreaInsets));
    
    
    //NSLog(@"adjustedContentInset = %@",NSStringFromUIEdgeInsets(self.collectionView.adjustedContentInset));
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
    [self.view addSubview:_topToolView];
}

- (void)setUpHeaderCenterView {
    self.tableView.tableHeaderView = self.headerView;
    self.headerBgImageView.frame = self.headerView.bounds;
    [self.headerView insertSubview:self.headerBgImageView atIndex:0]; //将背景图片放到最底层
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

- (SPMyCenterHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [SPMyCenterHeaderView headerView];
        _headerView.frame = CGRectMake(0, 0, ScreenW, 200);
    }
    return _headerView;
}

- (UIImageView *)headerBgImageView {
    if (!_headerBgImageView) {
        _headerBgImageView = [[UIImageView alloc] init];
        
        NSInteger armNum = [SPSpeedy dc_getRandomNumber:1 to:9];
        [_headerBgImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"mine_main_bg_%zd",armNum]]];
        [_headerBgImageView setBackgroundColor:[UIColor greenColor]];
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

- (NSArray *)scrollArray {
    if (!_scrollArray) {
        _scrollArray = [NSArray arrayWithObjects:@"111111111",@"22222222",@"33333333", nil];
    }
    return _scrollArray;
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
        cell.scrollArray = self.scrollArray;
        cusCell = cell;
    }else if(indexPath.section == 1){
        SPServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SPServiceCellID forIndexPath:indexPath];
        cell.serviceItem = self.serviceItem;
        cusCell = cell;
    }else if (indexPath.section == 2){
        SPIntegralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SPIntegralCellID forIndexPath:indexPath];
        cusCell = cell;
        cell.result = self.result;
    }else if (indexPath.section == 3){
        SPBPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SPBPCellID forIndexPath:indexPath];
        cusCell = cell;
    }
    cusCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cusCell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        return 40;
    }else if(indexPath.section == 1) {
        return 120;
    }else if (indexPath.section == 2) {
        return 245;
    }else if (indexPath.section == 3) {
        return 150;
    }
    return 0;
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
@end
