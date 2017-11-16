//
//  SPHomeViewController.m
//  HYSmartPlus
//
//  Created by information on 2017/9/12.
//  Copyright © 2017年 hongyan. All rights reserved.
//
// UIBarButtonItem
#import "UIBarButtonItem+SPBarButtonItem.h"
#import "UIImage+SPExtension.h"
// titleView
#import "SPNavSearchBarView.h"

#define MJProductCellID @"product"
#import "SPHandPickViewController.h"
#import "SPHomeTool.h"
#import "SPHttpTool.h"

#import "MJRefresh.h"

/* head */
#import "SPSlideshowHeadView.h"  //轮播图

@interface SPHandPickViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
/* collectionView */
@property (nonatomic, strong)  UICollectionView *collectionView;
/* 头部滚动页 */
@property (nonatomic, strong)  SPSlideshowHeadView *slideView;
/* 滚回顶部按钮 */
@property (nonatomic, strong)  UIButton *backTopButton;
/* 下拉滚动gif */
@property (nonatomic, strong)  NSMutableArray *headerRefreshImages;


@end

/* head */
static NSString *const SPSlideshowHeadViewID = @"SPSlideshowHeadView";

@implementation SPHandPickViewController

#pragma mark - LazyLoad
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[SPSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPSlideshowHeadViewID];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:MJProductCellID];
        
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
    SPSliderParam *param = [SPSliderParam param:slider];
    [SPHomeTool homeSliderWithParam:param success:^(NSArray *sliderResult) {
        NSMutableArray *resultArray = [NSMutableArray array];
        [sliderResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SPSliderResult *result = obj;
            [resultArray addObject:result.path];
        }];
        self.slideView.imageURLStringsGroup = resultArray;
    } failure:^(NSError *error) {
        
    }];
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
    return 120;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MJProductCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            SPSlideshowHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPSlideshowHeadViewID forIndexPath:indexPath];
            self.slideView = headerView;
            reusableView = headerView;
        }
    }
    return reusableView;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(ScreenW, ScreenW/3); //图片滚动的宽高
    }
    
    return CGSizeZero;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

@end
