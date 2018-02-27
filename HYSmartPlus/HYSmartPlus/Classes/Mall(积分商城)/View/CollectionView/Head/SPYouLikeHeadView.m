//
//  SPYouLikeHeadView.m
//  HYSmartPlus
//
//  Created by information on 2017/11/22.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPYouLikeHeadView.h"

/** vendor */
#import "SPLIRLButton.h"

@interface SPYouLikeHeadView()

@property (nonatomic, weak) SPLIRLButton  *lirlButton;

@end

@implementation SPYouLikeHeadView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    SPLIRLButton *lirlButton = [SPLIRLButton buttonWithType:UIButtonTypeCustom];
    [lirlButton setTitle:@"热门推荐" forState:UIControlStateNormal];
    [lirlButton setTitleColor:RGB(14, 122, 241) forState:UIControlStateNormal];
    [lirlButton setImage:[UIImage imageNamed:@"shouye_icon02"] forState:UIControlStateNormal];
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
