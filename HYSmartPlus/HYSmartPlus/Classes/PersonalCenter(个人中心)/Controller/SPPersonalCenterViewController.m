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

@interface SPPersonalCenterViewController () <UITableViewDataSource,UITableViewDelegate>

/* headerView */
@property (nonatomic, strong)  SPMyCenterHeaderView *headerView;
/** 头部背景图片 */
@property (nonatomic, strong)  UIImageView *headerBgImageView;
/** tableView */
@property (nonatomic, strong)  UITableView *tableView;
/* 顶部Nav */
@property (nonatomic, strong)  SPCenterTopToolView *topToolView;

@end

@implementation SPPersonalCenterViewController

#pragma mark - lifeCycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
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
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - SPBottomTabH);
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (SPMyCenterHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [SPMyCenterHeaderView headerView];
        _headerView.frame = CGRectMake(0, 0, ScreenW, 256);
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
        //DCCenterItemCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterItemCellID forIndexPath:indexPath];
        //cusCell = cell;
    }else if(indexPath.section == 1){
        //DCCenterServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterServiceCellID forIndexPath:indexPath];
        //cell.serviceItemArray = [NSMutableArray arrayWithArray:_serviceItem];
        //cusCell = cell;
    }else if (indexPath.section == 2){
        //DCCenterBeaShopCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterBeaShopCellID forIndexPath:indexPath];
        //cusCell = cell;
    }else if (indexPath.section == 3){
        //DCCenterBackCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterBackCellID forIndexPath:indexPath];
        //cusCell = cell;
    }
    return cusCell;
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
