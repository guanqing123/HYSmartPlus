//
//  SPCodeLoginView.m
//  HYSmartPlus
//
//  Created by information on 2018/2/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPCodeLoginView.h"

@interface SPCodeLoginView () <UITextFieldDelegate>

@property (nonatomic, weak) UILabel *telLabel;
@property (nonatomic, weak) UITextField *phoneTextField;
@property (nonatomic, weak) UIView  *firstLine;

@property (nonatomic, weak) UIButton *countDownButton;
@property (nonatomic, weak) UITextField *codeTextField;
@property (nonatomic, weak) UIView  *secondLine;

@property (nonatomic, weak) UIButton *submitButton;

@end

@implementation SPCodeLoginView

+ (instancetype)codeView {
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
    [self addSubview:self.telLabel];
    
    UITextField *phoneTextField = [[UITextField alloc] init];
    phoneTextField.placeholder = @"请输入手机号";
    [self.phoneTextField addTarget:self action:@selector(phoneEditChange) forControlEvents:UIControlEventEditingChanged];
    _phoneTextField = phoneTextField;
    [self addSubview:phoneTextField];
    
    UIView *firstLine = [[UIView alloc] init];
    firstLine.backgroundColor = RGB(223, 223, 223);
    _firstLine = firstLine;
    [self addSubview:firstLine];
    
    UIButton *countDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [countDownButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    countDownButton.backgroundColor = SPColor;
    countDownButton.layer.cornerRadius = 7;
    countDownButton.layer.masksToBounds = YES;
    countDownButton.titleLabel.font = PFR14Font;
    [countDownButton addTarget:self action:@selector(obtainVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    _countDownButton = countDownButton;
    [self addSubview:countDownButton];
    
    UITextField *codeTextField = [[UITextField alloc] init];
    codeTextField.placeholder = @"请输入验证码";
    [codeTextField addTarget:self action:@selector(EditChanged) forControlEvents:UIControlEventEditingChanged];
    _codeTextField = codeTextField;
    [self addSubview:codeTextField];
    
    UIView *secondLine = [[UIView alloc] init];
    secondLine.backgroundColor = RGB(223, 223, 223);
    _secondLine = secondLine;
    [self addSubview:secondLine];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.layer.cornerRadius = 8;
    submitButton.layer.masksToBounds = YES;
    submitButton.backgroundColor = RGB(207, 235, 221);
    [submitButton setTitle:@"登录" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(startRegisterButtonClick) forControlEvents:UIControlEventTouchUpInside];
    submitButton.userInteractionEnabled = NO;
    _submitButton = submitButton;
    [self addSubview:submitButton];
    
    /*
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getVerifyCodeSucess) name:@"getVerifyCodeSucess" object:nil];
     */
}

- (void)updateConstraints {
    //1.remake/update constraints here
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
    
    [self.countDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(17);
        make.right.equalTo(self.phoneTextField.mas_right);
        make.height.mas_equalTo(38);
        make.width.mas_equalTo(110);
    }];
    
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(25);
        make.left.equalTo(self.telLabel);
        make.height.mas_equalTo(34);
        make.right.equalTo(self.countDownButton.mas_left).offset(-20);
    }];
    
    [self.secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.codeTextField.mas_bottom);
        make.left.equalTo(self).offset(45);
        make.right.equalTo(self.countDownButton.mas_left).offset(-20);
        make.height.mas_equalTo(1);
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeTextField.mas_bottom).offset(40);
        make.left.equalTo(self).offset(45);
        make.width.mas_equalTo(ScreenW - 45 * 2);
        make.height.mas_equalTo(44);
    }];
    
    //2.according to apple super should be called at end of method
    [super updateConstraints];
}

@end
