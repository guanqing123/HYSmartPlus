//
//  SPGoodsYouLikeCell.m
//  HYSmartPlus
//
//  Created by information on 2017/11/22.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPGoodsYouLikeCell.h"

@interface  SPGoodsYouLikeCell()

/** 图片 */
@property (nonatomic, weak) UIImageView  *goodsImageView;
/** 标题 */
@property (nonatomic, weak) UILabel  *goodsLabel;
/** 价格 */
@property (nonatomic, weak) UILabel  *priceLabel;

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
}

@end
