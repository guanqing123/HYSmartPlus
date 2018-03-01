//
//  SPPasswordLoginView.m
//  HYSmartPlus
//
//  Created by information on 2018/2/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPPasswordLoginView.h"

@interface SPPasswordLoginView()

@property (nonatomic, weak) UILabel *telLabel;
@property (nonatomic, weak) UITextField *phoneTextField;
@property (nonatomic, weak) UIView  *firstLine;

@property (nonatomic, weak) UITextField *passwordTextField;
@property (nonatomic, weak) UIView  *secondLine;
@property (nonatomic, weak) UIButton *passwordButton;

@property (nonatomic, weak) UIButton *submitButton;
@property (nonatomic, weak) UIButton *forgetButton;

@end

@implementation SPPasswordLoginView

+ (instancetype)passwordView {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customView];
    }
    return self;
}

- (void)customView {
    self.backgroundColor = [UIColor whiteColor];
    
    UILabel *telLabel = [[UILabel alloc] init];
    telLabel.text = @"+86";
    telLabel.textColor = RGB(62, 62, 62);
    telLabel.font = [UIFont systemFontOfSize:17];
    _telLabel = telLabel;
    [self addSubview:telLabel];
    
    UITextField *phoneTextField = [[UITextField alloc] init];
    [phoneTextField addTarget:self action:@selector(contentChanged) forControlEvents:UIControlEventEditingChanged];
    phoneTextField.placeholder = @"请输入手机号";
    _phoneTextField = phoneTextField;
    [self addSubview:phoneTextField];
    
    UIView *firstLine = [[UIView alloc] init];
    firstLine.backgroundColor = RGB(223, 223, 223);
    _firstLine = firstLine;
    [self addSubview:firstLine];
    
    UITextField *passwordTextField = [[UITextField alloc] init];
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.secureTextEntry = YES;
    [passwordTextField addTarget:self action:@selector(contentChanged) forControlEvents:UIControlEventEditingChanged];
    _passwordTextField = passwordTextField;
    [self addSubview:passwordTextField];
    
    UIView *secondLine = [[UIView alloc] init];
    secondLine.backgroundColor = RGB(223, 223, 223);
    _secondLine = secondLine;
    [self addSubview:secondLine];
    
    UIButton *passwordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [passwordButton setImage:[UIImage imageNamed:@"close_eye"] forState:UIControlStateNormal];
    [passwordButton addTarget:self action:@selector(showPassword:) forControlEvents:UIControlEventTouchUpInside];
    _passwordButton = passwordButton;
    [self addSubview:passwordButton];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setTitle:@"登录" forState:UIControlStateNormal];
    submitButton.layer.cornerRadius = 8;
    submitButton.layer.masksToBounds = YES;
    submitButton.backgroundColor = RGB(207, 235, 221);
    [submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    submitButton.userInteractionEnabled = NO;
    _submitButton = submitButton;
    [self addSubview:submitButton];
    
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetButton.titleLabel.font = PFR14Font;
    [forgetButton setTitleColor:SPColor forState:UIControlStateNormal];
    _forgetButton = forgetButton;
    [self addSubview:forgetButton];
}

- (void)updateConstraints {
    // 1.constraints
    [self.telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(25);
        make.left.equalTo(self).offset(45);
        make.height.mas_equalTo(34);
    }];
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(25);
        make.left.equalTo(self.telLabel.mas_right).offset(15);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(ScreenW - 45 * 2 - 31 - 15);
    }];
    
    [self.firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.phoneTextField.mas_bottom);
        make.left.equalTo(self).offset(45);
        make.right.equalTo(self).offset(-45);
        make.height.mas_equalTo(1);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(25);
        make.left.equalTo(self.telLabel);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(ScreenW - 45 * 2 - 80);
    }];
    
    [self.secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.passwordTextField.mas_bottom);
        make.left.equalTo(self).offset(45);
        make.right.equalTo(self).offset(-45);
        make.height.mas_equalTo(1);
    }];
    
    [self.passwordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(30);
        make.right.equalTo(self.mas_right).offset(-50);
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(40);
        make.width.mas_equalTo(ScreenW - 45 * 2);
        make.height.mas_equalTo(44);
        make.left.equalTo(self).offset(45);
    }];
    
    [self.forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(45);
        make.top.equalTo(self.submitButton.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(58, 17));
    }];
    
    // 2.更新
    [super updateConstraints];
}

- (void)contentChanged {
    if (self.phoneTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
        self.submitButton.userInteractionEnabled = YES;
        self.submitButton.backgroundColor = SPColor;
    }else{
        self.submitButton.userInteractionEnabled = NO;
        self.submitButton.backgroundColor = RGB(207, 235, 221);
    }
    self.telphone = self.phoneTextField.text;
    self.password = self.passwordTextField.text;
}

- (void)showPassword:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        [self.passwordButton setImage:[UIImage imageNamed:@"open_eye"] forState:UIControlStateNormal];
        self.passwordTextField.secureTextEntry = NO;
    }else{
        [self.passwordButton setImage:[UIImage imageNamed:@"close_eye"] forState:UIControlStateNormal];
        self.passwordTextField.secureTextEntry = YES;
    }
}

- (void)submitButtonClick {
    if ([self.delegate respondsToSelector:@selector(passwordLoginViewDidSubmitButton:)]) {
        [self.delegate passwordLoginViewDidSubmitButton:self];
    }
}

@end
