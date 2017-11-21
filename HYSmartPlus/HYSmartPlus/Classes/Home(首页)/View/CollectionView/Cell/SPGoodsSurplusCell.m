//
//  SPGoodsSurplusCell.m
//  HYSmartPlus
//
//  Created by information on 2017/11/21.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPGoodsSurplusCell.h"

/** model */
#import "SPRecommendItem.h"
/** vendor */
#import "UIImageView+WebCache.h"

@interface SPGoodsSurplusCell()

/** 图片 */
@property (nonatomic, weak)  UIImageView *goodsImageView;
/** 价格 */
@property (nonatomic, weak)  UILabel *priceLabel;
/** 剩余 */
@property (nonatomic, weak)  UILabel *stockLabel;
/** 属性 */
@property (nonatomic, weak)  UILabel *natureLabel;

@end

@implementation SPGoodsSurplusCell

#pragma mark - intial
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI {
    UIImageView *goodsImageView = [[UIImageView alloc] init];
    goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:goodsImageView];
    self.goodsImageView = goodsImageView;
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.font = PFR12Font;
    priceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    UILabel *stockLabel = [[UILabel alloc] init];
    stockLabel.textColor = [UIColor darkGrayColor];
    stockLabel.font = PFR10Font;
    stockLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:stockLabel];
    self.stockLabel = stockLabel;
    
    UILabel *natureLabel = [[UILabel alloc] init];
    natureLabel.textAlignment = NSTextAlignmentCenter;
    natureLabel.backgroundColor = [UIColor redColor];
    natureLabel.font = PFR10Font;
    natureLabel.textColor = [UIColor whiteColor];
    [self.goodsImageView addSubview:natureLabel];
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.width.mas_equalTo(self).multipliedBy(0.8);
        make.height.mas_equalTo(self.dc_width * 0.8);
    }];
}

#pragma mark - Setter Getter Methods
- (void)setRecommendItem:(SPRecommendItem *)recommendItem
{
    _recommendItem = recommendItem;
    
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:recommendItem.image_url]];
    
    _priceLabel.text = ([recommendItem.price integerValue] >= 10000) ? [NSString stringWithFormat:@"¥ %.2f万",[recommendItem.price floatValue] / 10000.0] : [NSString stringWithFormat:@"¥ %.2f",[recommendItem.price floatValue]];
    
    _stockLabel.text = [NSString stringWithFormat:@"仅剩：%@件",recommendItem.stock];
    _natureLabel.text = recommendItem.nature;
}

@end
