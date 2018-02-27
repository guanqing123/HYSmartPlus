//
//  SPOverFootView.m
//  HYSmartPlus
//
//  Created by information on 2017/11/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPOverFootView.h"

@interface SPOverFootView()

/** label */
@property (nonatomic, weak) UILabel  *overLabel;

@end

@implementation SPOverFootView


#pragma mark - intial
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    UILabel *overLabel = [[UILabel alloc] init];
    overLabel.textAlignment = NSTextAlignmentCenter;
    overLabel.text = @"看完咯,下次再逛吧";
    overLabel.font = PFR16Font;
    overLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:overLabel];
    self.overLabel = overLabel;
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.overLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
}

@end
