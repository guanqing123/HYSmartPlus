//
//  SPGoodsGridCell.m
//  HYSmartPlus
//
//  Created by information on 2017/11/20.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPGoodsGridCell.h"

/** model */
#import "SPGridItem.h"
/** vendor */
#import "UIImageView+WebCache.h"

@interface SPGoodsGridCell()
/** imageView */
@property (nonatomic, weak) UIImageView  *imageView;
/** titleLabel */
@property (nonatomic, weak) UILabel  *titleLabel;
@end

@implementation SPGoodsGridCell

#pragma mark - intial
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = PFR13Font;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(self)setOffset:SPMargin];
        if (iphone5) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }else{
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }
        make.centerX.mas_equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self.imageView.mas_bottom)setOffset:5];
    }];
}

#pragma mark - Setter Getter Methods
- (void)setGridItem:(SPGridItem *)gridItem {
    _gridItem = gridItem;
    /** 图片 */
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:gridItem.iconImage]];
    /** 标题 */
    self.titleLabel.text = gridItem.gridTitle;
}

@end

