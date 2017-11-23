//
//  SPBrandSortCell.m
//  HYSmartPlus
//
//  Created by information on 2017/11/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPBrandSortCell.h"

/** model */
#import "SPClassSubItem.h"

/** verdor */
#import "UIImageView+WebCache.h"

@interface SPBrandSortCell()
/** imageView */
@property (nonatomic, weak) UIImageView  *brandImageView;
@end

@implementation SPBrandSortCell

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
    UIImageView *brandImageView = [[UIImageView alloc] init];
    brandImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:brandImageView];
    self.brandImageView = brandImageView;
}

#pragma mark - layoutSubViews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.brandImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.dc_width - 20, self.dc_height - 25));
    }];
}

#pragma mark - setter getter method
- (void)setSubItem:(SPClassSubItem *)subItem {
    _subItem = subItem;
    [_brandImageView sd_setImageWithURL:[NSURL URLWithString:subItem.image_url]];
}

@end
