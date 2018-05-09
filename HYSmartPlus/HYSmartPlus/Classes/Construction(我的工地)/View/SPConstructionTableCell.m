//
//  SPConstructionTableCell.m
//  HYSmartPlus
//
//  Created by information on 2018/5/7.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPConstructionTableCell.h"
#import "SPTopTextView.h"
#import "SPMiddleCollectionViewCell.h"
#import "XLPhotoBrowser.h"

@interface SPConstructionTableCell() <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,XLPhotoBrowserDelegate,SPBottomToolBarViewDelegate>

@property (nonatomic, strong)  UICollectionView *collectionView;

@property (nonatomic, strong) SPTopTextView  *topTextView;

@property (nonatomic, strong) SPBottomToolBarView  *bottomToolBarView;

@property (nonatomic, strong)  NSArray *imageUrls;

@end

static NSString *const SPMiddleCollectionViewCellID = @"SPMiddleCollectionViewCellID";

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
        self.backgroundColor = RGB(244, 244, 244);
        
        // 1.添加文本view
        [self.contentView addSubview:self.topTextView];
        
        // 2.添加中间的collectionView
        [self.contentView addSubview:self.collectionView];
        
        // 3.设置工具条
        [self.contentView addSubview:self.bottomToolBarView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat parentW = self.frame.size.width;
    self.topTextView.frame = CGRectMake(0, 0, parentW, topTextViewH);
    
    self.collectionView.frame = CGRectMake(0, self.topTextView.dc_bottom, parentW, (parentW - (column + 1) * margin)/column + 2 * margin);
    
    self.bottomToolBarView.frame = CGRectMake(0, self.collectionView.dc_bottom + 2, parentW, bottomToolBarViewH);
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = margin;
    frame.origin.y += margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    [super setFrame:frame];
}

#pragma mark - lazyLoad
- (SPTopTextView *)topTextView {
    if (!_topTextView) {
        _topTextView = [SPTopTextView topTextView];
    }
    return _topTextView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = layout.minimumInteritemSpacing = margin;
        layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SPMiddleCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:SPMiddleCollectionViewCellID];
    }
    return _collectionView;
}

- (SPBottomToolBarView *)bottomToolBarView {
    if (!_bottomToolBarView) {
        _bottomToolBarView = [[SPBottomToolBarView alloc] init];
        _bottomToolBarView.delegate = self;
    }
    return _bottomToolBarView;
}

#pragma mark - SPBottomToolBarViewDelegate
- (void)bottomToolBar:(SPBottomToolBarView *)toolBar buttonType:(ToolBarButtonType)buttonType {
    if([self.delegate respondsToSelector:@selector(constructionTableCell:dropower:buttonType:)]) {
        [self.delegate constructionTableCell:self dropower:self.dropower buttonType:buttonType];
    }
}

#pragma mark - setDropower
- (void)setDropower:(SPDropower *)dropower {
    _dropower = dropower;
    
    NSMutableArray *imageUrls = [NSMutableArray array];
    for (SPDropowerDetail *detail in dropower.children) {
        [imageUrls addObject:detail.fileRealPath];
    }
    self.imageUrls = imageUrls;
    
    // 刷新头部信息
    self.topTextView.dropower = dropower;
    // 刷新图片信息
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dropower.children.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SPMiddleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPMiddleCollectionViewCellID forIndexPath:indexPath];
    
    SPDropowerDetail *dropowerDetail = self.dropower.children[indexPath.row];
    cell.dropowerDetail = dropowerDetail;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XLPhotoBrowser *browser = [XLPhotoBrowser showPhotoBrowserWithImages:self.imageUrls currentImageIndex:indexPath.row];
    browser.browserStyle = XLPhotoBrowserStyleIndexLabel;
    
    // 设置长按手势弹出的地步ActionSheet数据,不实现此方法则没有长按手势
    [browser setActionSheetWithTitle:@"请选择您的操作" delegate:self cancelButtonTitle:@"取消" deleteButtonTitle:@"删除" otherButtonTitles:@"保存", nil];
}

#pragma mark - XLPhotoBrowserDelegate
- (void)photoBrowser:(XLPhotoBrowser *)browser clickActionSheetIndex:(NSInteger)actionSheetindex currentImageIndex:(NSInteger)currentImageIndex {
    switch (actionSheetindex) {
            case 0: // 保存
            {
                [browser saveCurrentShowImage];
            }
            break;
            case 1: // 删除
            {
                [browser dismiss];
                [self deleteDropowerDetail:currentImageIndex];
            }
            break;
        default:
            break;
    }
}

- (void)deleteDropowerDetail:(NSInteger)currentImageIndex {
    SPDropowerDetail *detail = self.dropower.children[currentImageIndex];
    if([self.delegate respondsToSelector:@selector(constructionTableCell:deleteDropowerDetail:)]) {
        [self.delegate constructionTableCell:self deleteDropowerDetail:detail];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((ScreenW - (column + 3) * margin)/column, (ScreenW - (column + 3) * margin)/column);
}

@end
