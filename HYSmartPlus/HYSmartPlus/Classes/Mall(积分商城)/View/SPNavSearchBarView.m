//
//  SPNavSearchBarView.m
//  HYSmartPlus
//
//  Created by information on 2017/11/13.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPNavSearchBarView.h"

@implementation SPNavSearchBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchClick)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)searchClick{
    
}

/**
 初始化组件
 */
- (void)setUpUI {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    
    /* 占位文字 */
    UITextField *placeholdField = [[UITextField alloc] initWithFrame:CGRectZero];
    placeholdField.font = PFR14Font;
    //placeholdField.textColor = [UIColor whiteColor];
    placeholdField.userInteractionEnabled = NO;
    self.placeholdField = placeholdField;
    
    /* 设置放大镜图片 */
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    imageView.frame = CGRectMake(0, 0, 30, 30);
    imageView.contentMode = UIViewContentModeCenter;
    placeholdField.leftView = imageView;
    placeholdField.leftViewMode = UITextFieldViewModeAlways;
    
    /* 语言按钮 */
    UIButton *voiceImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [voiceImageBtn setImage:[UIImage imageNamed:@"searchbar_button_voice_icon"] forState:UIControlStateNormal];
    [voiceImageBtn addTarget:self action:@selector(voiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.voiceImageBtn = voiceImageBtn;
    
    [self addSubview:placeholdField];
    [self addSubview:voiceImageBtn];
}

- (void)voiceButtonClick {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.placeholdField.frame = CGRectMake(0, 0, self.dc_width - 40, self.dc_height);
    
    [self.placeholdField mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.equalTo(self) setOffset:0];
        make.top.equalTo(self);
        make.height.equalTo(self);
    }];
    [self.voiceImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.equalTo(self) setOffset:-SPMargin];
        make.top.equalTo(self);
        make.height.equalTo(self);
    }];
    
    //设置边角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
