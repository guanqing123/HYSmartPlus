//
//  SPGoodsRecommendHeadView.m
//  HYSmartPlus
//
//  Created by information on 2017/11/22.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPGoodsRecommendHeadView.h"

/** vendor */
#import "SPLIRLButton.h"

@interface SPGoodsRecommendHeadView()

@property (nonatomic, weak) SPLIRLButton  *lirlButton;

@end

@implementation SPGoodsRecommendHeadView

#pragma mark - intial
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    SPLIRLButton *lirlButton = [SPLIRLButton buttonWithType:UIButtonTypeCustom];
    [lirlButton setTitle:@"品牌精选" forState:UIControlStateNormal];
    [lirlButton setTitleColor:RGB(77, 171, 21) forState:UIControlStateNormal];
    [lirlButton setImage:[UIImage imageNamed:@"shouye_icon03"] forState:UIControlStateNormal];
    lirlButton.titleLabel.font = PFR13Font;
    [self addSubview:lirlButton];
    self.lirlButton = lirlButton;
}

#pragma mark - layoutSubViews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.lirlButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

@end
