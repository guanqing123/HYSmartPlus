//
//  SPLoginFooterView.m
//  HYSmartPlus
//
//  Created by information on 2018/3/1.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPLoginFooterView.h"

@interface SPLoginFooterView()
@property (nonatomic, strong)  UIButton *qqBtn;
@property (nonatomic, strong)  UIButton *wxBtn;
@property (nonatomic, strong)  UIView *splitLine;
@property (nonatomic, strong)  UIButton *registBtn;
@property (nonatomic, strong)  UILabel *titleLabel;
@property (nonatomic, strong)  UIView *leftLine;
@property (nonatomic, strong)  UIView *rightLine;
@end

@implementation SPLoginFooterView

+ (instancetype)footerView {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 1.qq
        [self addSubview:self.qqBtn];
        // 2.wx
        [self addSubview:self.wxBtn];
        // 3.split line
        [self addSubview:self.splitLine];
        // 4.registBtn
        [self addSubview:self.registBtn];
        // 5.titleLabel
        [self addSubview:self.titleLabel];
        // 6.leftLine
        [self addSubview:self.leftLine];
        // 7.rightLine
        [self addSubview:self.rightLine];
    }
    return self;
}

- (UIButton *)qqBtn {
    if (!_qqBtn) {
        _qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qqBtn setImage:[UIImage imageNamed:@"logon_qq"] forState:UIControlStateNormal];
        [_qqBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqBtn;
}

- (UIButton *)wxBtn {
    if (!_wxBtn) {
        _wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wxBtn setImage:[UIImage imageNamed:@"logon_wechat"] forState:UIControlStateNormal];
        [_wxBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wxBtn;
}

- (void)btnClick {
    !_btnBlock ? : _btnBlock();
}

- (UIView *)splitLine {
    if (!_splitLine) {
        _splitLine = [[UIView alloc] init];
        _splitLine.backgroundColor = RGB(177, 177, 177);
    }
    return _splitLine;
}

- (UIButton *)registBtn {
    if (!_registBtn) {
        _registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registBtn.titleLabel.font = PFR18Font;
        [_registBtn setTitleColor:SPColor forState:UIControlStateNormal];
        [_registBtn.titleLabel sizeToFit];
        [_registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"第三方登录";
        _titleLabel.font = PFR10Font;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = RGB(177, 177, 177);
    }
    return _titleLabel;
}

- (UIView *)leftLine {
    if (!_leftLine) {
        _leftLine = [[UIView alloc] init];
        _leftLine.backgroundColor = RGB(223, 223, 223);
    }
    return _leftLine;
}

- (UIView *)rightLine {
    if (!_rightLine) {
        _rightLine = [[UIView alloc] init];
        _rightLine.backgroundColor = RGB(223, 223, 223);
    }
    return _rightLine;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.wxBtn.mas_left).offset(-10);
        make.centerY.equalTo(self.wxBtn);
    }];
    
    [self.wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.splitLine.mas_left).offset(-20);
        make.centerY.equalTo(self.splitLine);
    }];
    
    [self.splitLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-40);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(1);
    }];
    
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.splitLine.mas_right).offset(20);
        make.centerY.equalTo(self.splitLine);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(50, 20));
    }];
    
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(self.titleLabel.mas_left).offset(-20);
        make.height.mas_equalTo(1);
    }];
    
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.left.mas_equalTo(self.titleLabel.mas_right).offset(20);
        make.right.mas_equalTo(self).offset(-20);
        make.height.mas_equalTo(1);
    }];
}

/**
 点击注册按钮
 */
- (void)registBtnClick {
    if ([self.delegate respondsToSelector:@selector(loginFooterViewDidClickRegistBtn:)]) {
        [self.delegate loginFooterViewDidClickRegistBtn:self];
    }
}

@end
