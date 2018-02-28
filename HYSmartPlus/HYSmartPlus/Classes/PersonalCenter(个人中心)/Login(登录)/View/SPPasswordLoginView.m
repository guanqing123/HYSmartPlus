//
//  SPPasswordLoginView.m
//  HYSmartPlus
//
//  Created by information on 2018/2/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPPasswordLoginView.h"

@interface SPPasswordLoginView()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *passwordButton;

@end

@implementation SPPasswordLoginView

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
    
    self.codeTextField = [UITextField new];
    [self addSubview:self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(25);
        make.left.equalTo(self.label);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(ScreenW - 45 * 2 - 80);
    }];
    [self customTextField:self.codeTextField title:@"请输入密码"];
    [self drawBottomLine:self.codeTextField];
    self.codeTextField.delegate = self;
    [self.codeTextField addTarget:self action:@selector(EditChanged) forControlEvents:UIControlEventEditingChanged];
    self.codeTextField.secureTextEntry = YES;
    
    self.passwordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.passwordButton];
    [self.passwordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(30);
        make.right.equalTo(self.mas_right).offset(-50);
    }];
    self.passwordButton.userInteractionEnabled = YES;
    [self.passwordButton setImage:[UIImage imageNamed:@"close_eye"] forState:UIControlStateNormal];
    [self.passwordButton addTarget:self action:@selector(showPassword:) forControlEvents:UIControlEventTouchUpInside];
    
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
    [self.submitButton setTitle:@"登录" forState:UIControlStateNormal];
    self.submitButton.userInteractionEnabled = YES;
    [self.submitButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.submitButton.userInteractionEnabled = NO;
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

- (void)showPassword:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        [self.passwordButton setImage:[UIImage imageNamed:@"open_eye"] forState:UIControlStateNormal];
        self.codeTextField.secureTextEntry = NO;
    }else{
        [self.passwordButton setImage:[UIImage imageNamed:@"close_eye"] forState:UIControlStateNormal];
        self.codeTextField.secureTextEntry = YES;
    }
}

@end
