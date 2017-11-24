//
//  SPPersonalCenterViewController.m
//  HYSmartPlus
//
//  Created by information on 2017/11/24.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPPersonalCenterViewController.h"

/** view */
#import "SPMySelfHeadView.h" //头部

#import "SPGoodsYouLikeCell.h"

#import "SPRecommendItem.h"

#import "MJExtension.h"

@interface SPPersonalCenterViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

/** collectionView */
@property (nonatomic, strong)  UICollectionView *collectionView;

/** 推荐商品属性 */
@property (nonatomic, strong)  NSMutableArray<SPRecommendItem *> *youLikeItem;

@end

static NSString *const SPMySelfHeadViewID = @"SPMySelfHeadView";
static NSString *const SPGoodsYouLikeCellID = @"SPGoodsYouLikeCell";

@implementation SPPersonalCenterViewController

#pragma mark - LifeCycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpBase];
    _youLikeItem = [SPRecommendItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"contentInset = %@",NSStringFromUIEdgeInsets(self.collectionView.contentInset));
    
    NSLog(@"safeAreaInsets = %@",NSStringFromUIEdgeInsets(self.collectionView.safeAreaInsets));
    
    
    NSLog(@"adjustedContentInset = %@",NSStringFromUIEdgeInsets(self.collectionView.adjustedContentInset));
}

#pragma mark - initialize
- (void)setUpBase {
    self.view.backgroundColor = SPBGColor;
    self.collectionView.backgroundColor = self.view.backgroundColor;
}

#pragma mark - LazyLoad
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self.view addSubview:_collectionView];
        
        _collectionView.frame = CGRectMake(0, -200, ScreenW, ScreenH + 200);
        
        //头部
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SPMySelfHeadView class]) bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPMySelfHeadViewID];
        
        [_collectionView registerClass:[SPGoodsYouLikeCell class] forCellWithReuseIdentifier:SPGoodsYouLikeCellID];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return _youLikeItem.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {//猜你喜欢
        SPGoodsYouLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPGoodsYouLikeCellID forIndexPath:indexPath];
        cell.youLikeItem = _youLikeItem[indexPath.row];
        gridcell = cell;
    }
    return gridcell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            SPMySelfHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPMySelfHeadViewID forIndexPath:indexPath];
            reusableView = headerView;
        }
    }
    return reusableView;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == 0) { //猜你喜欢
        return CGSizeMake((ScreenW - 4)/2, (ScreenW - 4)/2 + 40);
    }
    return CGSizeZero;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return (section == 0) ? CGSizeMake(ScreenW, 380) : CGSizeZero;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 1) ? 4 : 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (section == 1) ? 4 : 0;
}

@end
