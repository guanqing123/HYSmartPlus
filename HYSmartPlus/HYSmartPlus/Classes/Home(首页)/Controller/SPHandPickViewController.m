//
//  SPHomeViewController.m
//  HYSmartPlus
//
//  Created by information on 2017/9/12.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPHandPickViewController.h"

/** model */
#import "SPGridItem.h"
#import "SPRecommendItem.h"

/** view */
#import "SPNavSearchBarView.h"

/** cell */
#import "SPGoodsGridCell.h" //10个选项
#import "SPGoodsCountDownCell.h" //倒计时商品
#import "SPExceedApplianceCell.h" //掌上专享
#import "SPGoodsHandheldCell.h" //精品精选

/* head */
#import "SPSlideshowHeadView.h"  //轮播图
#import "SPCountDownHeadView.h"  //倒计时标语
#import "SPGoodsRecommendHeadView.h" //精品精选
#import "SPYouLikeHeadView.h" //猜你喜欢

/** foot */
#import "SPTopLineFootView.h" //头条
#import "SPScrollAdFootView.h" //掌上专享

/** vendor */
#import "MJRefresh.h"
#import "MJExtension.h"

/** category */
#import "UIBarButtonItem+SPBarButtonItem.h"

/** tool */
#import "SPHomeTool.h"
#import "SPHttpTool.h"

@interface SPHandPickViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
/* collectionView */
@property (nonatomic, strong)  UICollectionView *collectionView;
/** 10个属性 */
@property (nonatomic, strong)  NSMutableArray<SPGridItem *> *gridItem;
/** 推荐商品属性 */
@property (nonatomic, strong)  NSMutableArray<SPRecommendItem *> *youLikeItem;

/* 滚回顶部按钮 */
@property (nonatomic, strong)  UIButton *backTopButton;
/* 下拉滚动gif */
@property (nonatomic, strong)  NSMutableArray *headerRefreshImages;


@end

/** cell */
static NSString *const SPGoodsGridCellID = @"SPGoodsGridCell";
static NSString *const SPGoodsCountDownCellID = @"SPGoodsCountDownCell";
static NSString *const SPExceedApplianceCellID = @"SPExceedApplianceCell";
static NSString *const SPGoodsHandheldCellID = @"SPGoodsHandheldCell";

/** head */
static NSString *const SPSlideshowHeadViewID = @"SPSlideshowHeadView";
static NSString *const SPCountDownHeadViewID = @"SPCountDownHeadView";
static NSString *const SPGoodsRecommendHeadViewID = @"SPGoodsRecommendHeadView";
static NSString *const SPYouLikeHeadViewID = @"SPYouLikeHeadView";

/** foot */
static NSString *const SPTopLineFootViewID = @"SPTopLineFootView";
static NSString *const SPScrollAdFootViewID = @"SPScrollAdFootView";

@implementation SPHandPickViewController

#pragma mark - LazyLoad
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
//        layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView registerClass:[SPGoodsGridCell class] forCellWithReuseIdentifier:SPGoodsGridCellID];
        [_collectionView registerClass:[SPGoodsCountDownCell class] forCellWithReuseIdentifier:SPGoodsCountDownCellID];
        [_collectionView registerClass:[SPExceedApplianceCell class] forCellWithReuseIdentifier:SPExceedApplianceCellID];
        [_collectionView registerClass:[SPGoodsHandheldCell class] forCellWithReuseIdentifier:SPGoodsHandheldCellID];
        
        [_collectionView registerClass:[SPTopLineFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:SPTopLineFootViewID];
        [_collectionView registerClass:[SPScrollAdFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:SPScrollAdFootViewID];
        
        [_collectionView registerClass:[SPSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPSlideshowHeadViewID];
        [_collectionView registerClass:[SPCountDownHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPCountDownHeadViewID];
        [_collectionView registerClass:[SPGoodsRecommendHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPGoodsRecommendHeadViewID];
        [_collectionView registerClass:[SPYouLikeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPYouLikeHeadViewID];
        
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        [header setImages:self.headerRefreshImages forState:MJRefreshStateIdle];
        [header setImages:self.headerRefreshImages forState:MJRefreshStatePulling];
        [header setImages:self.headerRefreshImages forState:MJRefreshStateRefreshing];
        self.collectionView.mj_header = header;
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSMutableArray *)headerRefreshImages {
    if (!_headerRefreshImages) {
        _headerRefreshImages = [NSMutableArray array];
        for (int i = 1; i <= 9; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"SPRefreshTableHeader%d", i]];
            if (image != nil) {
                [_headerRefreshImages addObject:image];
            }
        }
    }
    return _headerRefreshImages;
}

- (void)headerRefresh {
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.collectionView.mj_header endRefreshing];
    });
}

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBar.barTintColor == RGBA(231, 23, 37, 1.0))return;
    self.navigationController.navigationBar.barTintColor = RGBA(231, 23, 37, 1.0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpBase];
    
    [self setUpNav];
    
    [self setUpData];
    
    [self setUpScrollToTopView];
}

#pragma mark - initialize
- (void)setUpBase{
    self.view.backgroundColor = SPBGColor;
    self.collectionView.backgroundColor = self.view.backgroundColor;
}

#pragma mark - 导航栏处理
- (void)setUpNav {
    // 左边扫一扫
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"richScan"] withHighLightedImage:[UIImage imageNamed:@"richScan"] target:self action:@selector(richScanItemClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    // 右边消息
    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"message"] withHighLightedImage:[UIImage imageNamed:@"message"] target:self action:@selector(messageItemClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    // titleView
    SPNavSearchBarView *searchBarVc = [[SPNavSearchBarView alloc] init];
    searchBarVc.placeholdField.text = @"搜索功能即将开放";
    searchBarVc.frame = CGRectMake(60, 25, ScreenW * 0.68, 35);
    self.navigationItem.titleView = searchBarVc;
}

#pragma mark - setUpData
- (void)setUpData {
    _gridItem = [SPGridItem mj_objectArrayWithFilename:@"GoodsGrid.plist"];
    _youLikeItem = [SPRecommendItem mj_objectWithFilename:@"HomeHighGoods.plist"];
}

#pragma mark - 滚回顶部
- (void)setUpScrollToTopView {
    UIButton *backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:backTopButton];
    self.backTopButton = backTopButton;
    [backTopButton addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    backTopButton.hidden = YES;
    [backTopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.mas_equalTo(self.view.mas_right).offset(-SPMargin);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-SPBottomTabH-SPMargin);
    }];
}

- (void)scrollToTop {
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //判断回到顶部按钮是否隐藏
    self.backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) { //10属性
        return _gridItem.count;
    }
    if (section == 1) { //准点开抢 6点场
        return 1;
    }
    if (section == 2) { //掌上专享
        return 1;
    }
    if (section == 3) { //精品精选
        return GoodsHandheldImagesArray.count;
    }
    if (section == 4) { //猜你喜欢
        return _youLikeItem.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridCell = nil;
    if (indexPath.section == 0) { // 10个属性
        SPGoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPGoodsGridCellID forIndexPath:indexPath];
        cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridCell = cell;
    }else if (indexPath.section == 1) { // 倒计时
        SPGoodsCountDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPGoodsCountDownCellID forIndexPath:indexPath];
        cell.backgroundColor = [UIColor blueColor];
        gridCell = cell;
    }else if (indexPath.section == 2) { // 掌上专享
        SPExceedApplianceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPExceedApplianceCellID forIndexPath:indexPath];
        cell.goodExceedArray = GoodsRecommendArray;
        gridCell = cell;
    }else if (indexPath.section == 3) { // 精品精选
        SPGoodsHandheldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPGoodsHandheldCellID forIndexPath:indexPath];
        cell.handheldImage = GoodsHandheldImagesArray[indexPath.row];
        gridCell = cell;
    }
    
    return gridCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) { //最头部滚动页
            SPSlideshowHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPSlideshowHeadViewID forIndexPath:indexPath];
            reusableView = headerView;
        }else if(indexPath.section == 1) { //6点场,好货秒抢
            SPCountDownHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPCountDownHeadViewID forIndexPath:indexPath];
            reusableView = headerView;
        }else if (indexPath.section == 3) { //精品精选
            SPGoodsRecommendHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPGoodsRecommendHeadViewID forIndexPath:indexPath];
            reusableView = headerView;
        }else if (indexPath.section == 4) { //猜你喜欢
            SPYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPYouLikeHeadViewID forIndexPath:indexPath];
            reusableView = headerView;
        }
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        if (indexPath.section == 0) { //头条翻转
            SPTopLineFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:SPTopLineFootViewID forIndexPath:indexPath];
            reusableView = footerView;
        }else if (indexPath.section == 2) { //掌上专享
            SPScrollAdFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:SPScrollAdFootViewID forIndexPath:indexPath];
            reusableView = footerView;
        }
    }
    
    return reusableView;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) { //9宫格组
        return CGSizeMake(ScreenW / 5, ScreenW / 5 + SPMargin);
    }
    if (indexPath.section == 1) { //计时
        return CGSizeMake(ScreenW, 150);
    }
    if (indexPath.section == 2) { //掌上专享
        return CGSizeMake(ScreenW, ScreenW * 0.35 + 120);
    }
    if (indexPath.section == 3) { //精品精选
        return [self layoutAttributesForItemAtIndexPath:indexPath].size;
    }
    return CGSizeZero;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            layoutAttributes.size = CGSizeMake(ScreenW, ScreenW * 0.35);
        }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
            layoutAttributes.size = CGSizeMake(ScreenW * 0.5, ScreenW * 0.2);
        }else{
            layoutAttributes.size = CGSizeMake(ScreenW * 0.25, ScreenW * 0.35);
        }
    }
    return layoutAttributes;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(ScreenW, ScreenW/3); //图片滚动的宽高
    }
    if (section == 1 || section == 3 || section == 4) { //计时,精品精选,猜你喜欢
        return CGSizeMake(ScreenW, 40);
    }
    
    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(ScreenW, 60); //Top头条的宽高
    }
    if (section == 2) {
        return CGSizeMake(ScreenW, 80); //滚动广告 
    }
    return CGSizeZero;
}

/**
 这里我用代理设置以下间距 感兴趣可以自己调整值看看差别
 */
#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 4) ? 4 : 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 4) ? 4 : 0;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

@end
