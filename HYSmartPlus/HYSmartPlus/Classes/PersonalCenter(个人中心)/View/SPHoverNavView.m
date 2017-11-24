//
//  SPHoverNavView.m
//  HYSmartPlus
//
//  Created by information on 2017/11/24.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPHoverNavView.h"

@interface  SPHoverNavView()

/** 左边Item */
@property (nonatomic, strong)  UIButton *leftItemButton;
/** 右边Item */
@property (nonatomic, strong)  UIButton *rightItemButton;

/** imageView */
@property (nonatomic, strong)  UIImageView *iconImageView;
/** title */
@property (nonatomic, strong)  UILabel *titleLabel;

@end

@implementation SPHoverNavView

#pragma mark - intial
- (instancetype)initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
        [self setUpViewWithColor:[UIColor clearColor]];
    }
    return self;
}

#pragma mark - 初始化View
- (void)setUpViewWithColor:(UIColor *)color {
    self.backgroundColor = color;
    
    _leftItemButton = ({
        UIButton *button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(leftButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    _rightItemButton = ({
        UIButton *button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    
    self.iconImageView = ({
        UIImageView *iconImageView = [UIImageView new];
        iconImageView.layer.masksToBounds = YES;
        iconImageView.layer.cornerRadius = 40/2.f; //宽度一半
        iconImageView;
    });
    
    self.titleLabel = ({
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentCenter;
        label;
    });
    
    [self addSubview:_leftItemButton];
    [self addSubview:_rightItemButton];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.iconImageView];
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.leftItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

@end
