//
//  SPServiceTableViewCell.m
//  HYSmartPlus
//
//  Created by information on 2018/3/14.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPServiceTableViewCell.h"
//view
#import "SPServiceCollectionViewCell.h"

@interface SPServiceTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *topTitleView;

@property (nonatomic, strong)  UICollectionView *collectionView;

@end

static NSString *const SPServiceCollectionViewCellID = @"SPServiceCollectionViewCellID";

@implementation SPServiceTableViewCell

#pragma mark - initial
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topTitleView.mas_bottom);
        make.left.equalTo(self);
        make.bottom.equalTo(self).offset(-10);
        make.right.equalTo(self);
    }];
}

#pragma mark - lazyLoad
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout =[UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerClass:[SPServiceCollectionViewCell class] forCellWithReuseIdentifier:SPServiceCollectionViewCellID];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _serviceItem.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SPServiceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPServiceCollectionViewCellID forIndexPath:indexPath];
    cell.serviceItem = _serviceItem[indexPath.row];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SPServiceItem  *item =  _serviceItem[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(serviceTableViewCell:didClickCollectionViewItem:)]) {
        [self.delegate serviceTableViewCell:self didClickCollectionViewItem:item];
    }
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ScreenW / 4, 75);
}

@end
