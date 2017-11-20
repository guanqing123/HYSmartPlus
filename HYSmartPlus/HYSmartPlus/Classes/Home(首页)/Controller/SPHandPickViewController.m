//
//  SPHomeViewController.m
//  HYSmartPlus
//
//  Created by information on 2017/9/12.
//  Copyright © 2017年 hongyan. All rights reserved.
//

/** model */
#import "SPGridItem.h"
/** view */
#import "SPNavSearchBarView.h"

/** cell */
#import "SPGoodsGridCell.h" //10个选项

#define MJProductCellID @"product"
#import "SPHandPickViewController.h"
#import "SPHomeTool.h"
#import "SPHttpTool.h"

/** vendors */
#import "MJRefresh.h"
#import "MJExtension.h"

/** category */
#import "UIBarButtonItem+SPBarButtonItem.h"

/* head */
#import "SPSlideshowHeadView.h"  //轮播图

@interface SPHandPickViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
/* collectionView */
@property (nonatomic, strong)  UICollectionView *collectionView;
/** 10个属性 */
@property (nonatomic, strong)  NSMutableArray<SPGridItem *> *gridItem;

/* 滚回顶部按钮 */
@property (nonatomic, strong)  UIButton *backTopButton;
/* 下拉滚动gif */
@property (nonatomic, strong)  NSMutableArray *headerRefreshImages;


@end

/** head */
static NSString *const SPSlideshowHeadViewID = @"SPSlideshowHeadView";


/** cell */
static NSString *const SPGoodsGridCellID = @"SPGoodsGridCell";

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
        
        [_collectionView registerClass:[SPSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPSlideshowHeadViewID];
        
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
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) { //10属性
        return _gridItem.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridCell = nil;
    if (indexPath.section == 0) {
        SPGoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPGoodsGridCellID forIndexPath:indexPath];
        cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor redColor];
        gridCell = cell;
    }
    return gridCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            SPSlideshowHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPSlideshowHeadViewID forIndexPath:indexPath];
            reusableView = headerView;
        }
    }
    return reusableView;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) { //9宫格组
        return CGSizeMake(ScreenW / 5, ScreenW / 5 + SPMargin);
    }
    return CGSizeZero;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(ScreenW, ScreenW/3); //图片滚动的宽高
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
