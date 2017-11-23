//
//  SPGoodsSortCell.m
//  HYSmartPlus
//
//  Created by information on 2017/11/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPGoodsSortCell.h"

/** model */
#import "SPClassMainItem.h"
#import "SPClassSubItem.h"

/** view */
#import "UIImageView+WebCache.h"

@interface SPGoodsSortCell()

/** imageView */
@property (nonatomic, weak) UIImageView  *goodsImageView;
/** label */
@property (nonatomic, weak) UILabel  *goodsTitleLabel;

@end

@implementation SPGoodsSortCell

#pragma mark - intial
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI {
    self.backgroundColor = SPBGColor;
    UIImageView *goodsImageView = [[UIImageView alloc] init];
    goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:goodsImageView];
    self.goodsImageView = goodsImageView;
    
    UILabel *goodsTitleLabel = [[UILabel alloc] init];
    goodsTitleLabel.font = PFR13Font;
    goodsTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:goodsTitleLabel];
    self.goodsTitleLabel = goodsTitleLabel;
}

#pragma mark - layoutSubViews
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self) setOffset:5];
        make.size.mas_equalTo(CGSizeMake(self.dc_width * 0.85, self.dc_width * 0.85));
    }];
    
    [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(self.goodsImageView.mas_bottom) setOffset:5];
        make.width.mas_equalTo(self.goodsImageView);
        make.centerX.mas_equalTo(self);
    }];
}

#pragma mark - setter getter methods
- (void)setSubItem:(SPClassSubItem *)subItem {
    _subItem = subItem;
    if ([subItem.image_url containsString:@"http"]) {
        [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:subItem.image_url]];
    }else{
        _goodsImageView.image = [UIImage imageNamed:subItem.image_url];
    }
    _goodsTitleLabel.text = subItem.goods_title;
}

@end
