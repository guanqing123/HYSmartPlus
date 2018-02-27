//
//  SPExceedApplianceCell.m
//  HYSmartPlus
//
//  Created by information on 2017/11/22.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPExceedApplianceCell.h"

/** views */
#import "SPGoodsHandheldCell.h"
/** vendor */
#import "UIImageView+WebCache.h"

@interface SPExceedApplianceCell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

/** collectionView */
@property (nonatomic, strong)  UICollectionView *collectionView;
/** 头部ImageView */
@property (nonatomic, strong)  UIImageView *headImageView;
/** 图片数组 */
@property (nonatomic, strong)  NSArray *imagesArray;

@end

static NSString *const SPGoodsHandheldCellID = @"SPGoodsHandheldCell";

@implementation SPExceedApplianceCell

#pragma mark - intial
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.backgroundColor;
    
    _headImageView = [[UIImageView alloc] init];
    [self addSubview:_headImageView];
}

#pragma mark - lazyload
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(100, 100);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.frame = CGRectMake(0, ScreenW * 0.35 + SPMargin, ScreenW, 100);
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[SPGoodsHandheldCell class] forCellWithReuseIdentifier:SPGoodsHandheldCellID];
    }
    return _collectionView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(ScreenW * 0.35);
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imagesArray.count - 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SPGoodsHandheldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPGoodsHandheldCellID forIndexPath:indexPath];
    cell.handheldImage = _imagesArray[indexPath.row + 1];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"掌上生活点击了第%zd个产品",indexPath.row);
}

#pragma mark - setter getter methods
- (void)setGoodExceedArray:(NSArray *)goodExceedArray {
    _goodExceedArray = goodExceedArray;
    _imagesArray = goodExceedArray;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:goodExceedArray[0]]];
}

@end
