//
//  SPCodeLoginView.m
//  HYSmartPlus
//
//  Created by information on 2018/2/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPCodeLoginView.h"

@interface SPCodeLoginView () <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *countDownButton;

@end

@implementation SPCodeLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customView];
    }
    return self;
}

- (void)customView {
    self.backgroundColor = [UIColor whiteColor];
    
    self.label = [UILabel new];
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(25);
        make.left.equalTo(self).offset(45);
        make.height.mas_equalTo(34);
    }];
    self.label.text = @"+86";
    self.label.textColor = RGB(62, 62, 62);
    self.label.font = [UIFont systemFontOfSize:17];
    
    self.phoneTextField = [UITextField new];
    [self addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(25);
        make.left.equalTo(self.label.mas_right).offset(15);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(ScreenW - 45 * 2 - 31 - 15);
    }];
    [self customTextField:self.phoneTextField title:@"请输入手机号"];
    [self drawBottomLine:self.phoneTextField];
    [self.phoneTextField addTarget:self action:@selector(phoneEditChange) forControlEvents:UIControlEventEditingChanged];
    
    self.countDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.countDownButton];
    [self.countDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(17);
        make.right.equalTo(self.phoneTextField.mas_right);
        make.height.mas_equalTo(38);
        make.width.mas_equalTo(110);
    }];
    [self.countDownButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.countDownButton.backgroundColor = SPColor;
    self.countDownButton.layer.cornerRadius = 7;
    self.countDownButton.layer.masksToBounds = YES;
    self.countDownButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.countDownButton addTarget:self action:@selector(obtainVerifyCode) forControlEvents:UIControlEventTouchUpInside];

    self.codeTextField = [UITextField new];
    [self addSubview:self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(25);
        make.left.equalTo(self.label);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(ScreenW - 45 * 2 - 115 - 10);
    }];
    [self.codeTextField addTarget:self action:@selector(EditChanged) forControlEvents:UIControlEventEditingChanged];
    [self customTextField:self.codeTextField title:@"请输入验证码"];
    [self drawShortBottomLine:self.codeTextField];
    
    self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.submitButton];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeTextField.mas_bottom).offset(40);
        make.width.mas_equalTo(ScreenW - 45 * 2);
        make.height.mas_equalTo(44);
        make.left.equalTo(self).offset(45);
    }];
    self.submitButton.layer.cornerRadius = 8;
    self.submitButton.layer.masksToBounds = YES;
    self.submitButton.backgroundColor = RGB(207, 235, 221);
    self.submitButton.userInteractionEnabled = YES;
    [self.submitButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.submitButton addTarget:self action:@selector(startRegisterButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.submitButton.userInteractionEnabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getVerifyCodeSucess) name:@"getVerifyCodeSucess" object:nil];
}

- (void)customTextField:(UITextField *)textField title:(NSString *)titleString {
    textField.placeholder = titleString;
}

- (void)drawBottomLine:(UITextField *)textField {
    UIView *lineView = [UIView new];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(textField.mas_bottom);
        make.left.equalTo(self).offset(45);
        make.right.equalTo(self).offset(-45);
        make.height.mas_equalTo(1);
    }];
    lineView.backgroundColor = RGB(223, 223, 223);
}

- (void)drawShortBottomLine:(UITextField *)textField {
    UIView *lineView = [UIView new];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(textField.mas_bottom);
        make.left.equalTo(self).offset(45);
        make.right.equalTo(self.countDownButton.mas_left).offset(-20);
        make.height.mas_equalTo(1);
    }];
    lineView.backgroundColor = RGB(223, 223, 223);
}

@end
