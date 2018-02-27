//
//  SPGoodsYouLikeCell.m
//  HYSmartPlus
//
//  Created by information on 2017/11/22.
//  Copyright © 2017年 hongyan. All rights reserved.
//
#define cellWH ScreenW * 0.5 - 50

#import "SPGoodsYouLikeCell.h"

/** model */
#import "SPRecommendItem.h"
/** vendor */
#import "UIImageView+WebCache.h"

@interface  SPGoodsYouLikeCell()

/** 图片 */
@property (nonatomic, weak) UIImageView  *goodsImageView;
/** 标题 */
@property (nonatomic, weak) UILabel  *goodsLabel;
/** 价格 */
@property (nonatomic, weak) UILabel  *priceLabel;
/** 看相似 */
@property (nonatomic, weak) UIButton  *sameButton;

@end

@implementation SPGoodsYouLikeCell

#pragma mark - intial
- (instancetype)initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *goodsImageView = [[UIImageView alloc] init];
    goodsImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:goodsImageView];
    self.goodsImageView = goodsImageView;
    
    UILabel *goodsLabel = [[UILabel alloc] init];
    goodsLabel.font = PFR12Font;
    goodsLabel.numberOfLines = 2;
    goodsLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:goodsLabel];
    self.goodsLabel = goodsLabel;
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.font = PFR15Font;
    [self addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    UIButton *sameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sameButton.titleLabel.font = PFR10Font;
    [sameButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [sameButton setTitle:@"看相似" forState:UIControlStateNormal];
    [sameButton addTarget:self action:@selector(lookSameGoods) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sameButton];
    [SPSpeedy dc_chageControlCircularWith:sameButton AndSetCornerRadius:0 SetBorderWidth:1.0 SetBorderColor:[UIColor darkGrayColor] canMasksToBounds:YES];
    self.sameButton = sameButton;
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self) setOffset:SPMargin];
        make.size.mas_equalTo(CGSizeMake(cellWH, cellWH));
    }];
    
    [self.goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(self).multipliedBy(0.8);
        make.height.mas_equalTo(40);
        [make.top.mas_equalTo(self.goodsImageView.mas_bottom) setOffset:SPMargin];
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsImageView);
        make.width.mas_equalTo(self).multipliedBy(0.5);
        make.top.mas_equalTo(self.goodsLabel.mas_bottom);
    }];
    
    [self.sameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self) setOffset:-SPMargin];
        make.centerY.mas_equalTo(self.priceLabel);
        make.size.mas_equalTo(CGSizeMake(35, 18));
    }];
}

#pragma mark - setter getter methods
- (void)setYouLikeItem:(SPRecommendItem *)youLikeItem {
    _youLikeItem = youLikeItem;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:youLikeItem.image_url]];
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[youLikeItem.price floatValue]];
    self.goodsLabel.text = youLikeItem.main_title;
}

#pragma mark - 点击事件
- (void)lookSameGoods {
    NSLog(@"点击了%@的相似按钮",_youLikeItem.main_title);
}

@end
