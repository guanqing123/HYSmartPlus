//
//  SPConstructionTableCell.m
//  HYSmartPlus
//
//  Created by information on 2018/5/7.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#define topColorViewH 30

#import "SPConstructionTableCell.h"
#import "SPMiddleTextView.h"

@interface SPConstructionTableCell() <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)  UICollectionView *collectionView;

@property (nonatomic, weak) SPMiddleTextView  *middleTextView;

@end

static NSString *const SPConstructionCollectionViewCellID = @"SPConstructionCollectionViewCellID";

@implementation SPConstructionTableCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SPConstructionTableCellID";
    SPConstructionTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SPConstructionTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 0.非常重要
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = RGB(226, 226, 226);
        // 1.添加文本view
        [self setupMiddleTextView];
        
        [self setupContentPhotoView];
    }
    return self;
}

- (void)setupMiddleTextView {
    [self.contentView addSubview:self.middleTextView];
}

- (SPMiddleTextView *)middleTextView {
    if (!_middleTextView) {
        _middleTextView = [SPMiddleTextView middleTextView];
        _middleTextView.backgroundColor = [UIColor whiteColor];
    }
    return _middleTextView;
}

- (void)setupContentPhotoView {
    [self.contentView addSubview:self.collectionView];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = RGB(226, 226, 226);
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:SPConstructionCollectionViewCellID];
    }
    return _collectionView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat parentW = self.frame.size.width;
    self.middleTextView.frame = CGRectMake(0, 0, parentW, 114);
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = margin;
    frame.origin.y += margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    [super setFrame:frame];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPConstructionCollectionViewCellID forIndexPath:indexPath];

    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 50, 30);
    [cell addSubview:label];
    cell.backgroundColor = [UIColor whiteColor];
    
    label.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((ScreenW - (column + 1) * margin)/column, (ScreenW - (column + 1) * margin)/column);
}

@end
