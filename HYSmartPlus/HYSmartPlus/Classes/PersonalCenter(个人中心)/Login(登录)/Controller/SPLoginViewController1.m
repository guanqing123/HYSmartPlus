//
//  SPLoginViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/2/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPLoginViewController1.h"
#import "SPCodeLoginView.h"
#import "SPPasswordLoginView.h"

@interface SPLoginViewController1 ()
@property (nonatomic, strong)  SPCodeLoginView *codeLoginView;
@property (nonatomic, strong)  SPPasswordLoginView *passwordLoginView;

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong)  UIButton *passwordLoginButton;
@property (nonatomic, strong)  UIButton *codeLoginButton;
@property (nonatomic, strong) UIButton *forgetButton;
@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) UIButton *qqButton;
@property (nonatomic, strong) UIButton *wxButton;

@end

@implementation SPLoginViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.topImageView = [UIImageView new];
    [self.view addSubview:self.topImageView];
    self.view.userInteractionEnabled = YES;
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(79);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    self.topImageView.image = [UIImage imageNamed:@"sign_in_logo"];
    
    self.passwordLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.passwordLoginButton];
    [self.passwordLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageView.mas_bottom).offset(50);
        make.left.equalTo(self.view).offset(72);
    }];
    [self customButton:self.passwordLoginButton title:@"动态码登录" font:16 color:SPColor];
    [self.passwordLoginButton addTarget:self action:@selector(codeLoginClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.codeLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.codeLoginButton];
    [self.codeLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.passwordLoginButton);
        make.left.equalTo(self.passwordLoginButton.mas_right).offset(75);
    }];
    [self customButton:self.codeLoginButton title:@"密码登录" font:16 color:RGB(177, 177, 177)];
    [self.codeLoginButton addTarget:self action:@selector(passwordLoginClick) forControlEvents:UIControlEventTouchUpInside];
    
    __weak typeof(self) weakSelf = self;
    self.codeLoginView.delegate = self;
    
    //验证码模块
    self.codeLoginView = [[SPCodeLoginView alloc] initWithFrame:CGRectMake(0, 193, ScreenW, 194)];
    [self.view addSubview:self.codeLoginView];
    
    // 密码登录
    self.passwordLoginView = [[SPPasswordLoginView alloc] initWithFrame:CGRectMake(0, 193, ScreenW, 194)];
    [self.view addSubview:self.passwordLoginView];
    self.passwordLoginView.hidden = YES;
    self.passwordLoginView.delegate = self;
    
    self.forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetButton.frame = CGRectMake(45, 410, 58, 17);
    [self.view addSubview:self.forgetButton];
    [self customButton:self.forgetButton title:@"忘记密码" font:14 color:SPColor];
    [self.forgetButton addTarget:self action:@selector(forgetButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.wxButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.wxButton];
    [self.wxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-26);
        make.left.mas_equalTo((ScreenW - 137)/2);
    }];
    [self.wxButton setImage:[UIImage imageNamed:@"logon_qq"] forState:UIControlStateNormal];
    
    self.qqButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.qqButton];
    [self.qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-26);
        make.left.equalTo(self.wxButton.mas_right).offset(8);
    }];
    [self.qqButton setImage:[UIImage imageNamed:@"logon_wechat"] forState:UIControlStateNormal];
    
    UIView *lineView = [UIView new];
    [self.view addSubview:lineView];
    lineView.backgroundColor = RGB(177, 177, 177);
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.qqButton.mas_right).offset(17);
        make.bottom.equalTo(self.view.mas_bottom).offset(-29);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(1);
    }];
    
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right).offset(16);
        make.bottom.equalTo(self.view.mas_bottom).offset(-25);
    }];
    [self customButton:self.registerButton title:@"注册" font:17 color:SPColor];
    [self.registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)customButton:(UIButton *)button title:(NSString *)titleString font:(CGFloat)fontSize color:(UIColor *)color {
    [button setTitle:titleString forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button.titleLabel sizeToFit];
}

- (void)passwordLoginClick {
    [self.passwordLoginButton setTitleColor:RGB(177, 177, 177) forState:UIControlStateNormal];
    [self.codeLoginButton setTitleColor:SPColor forState:UIControlStateNormal];
    self.codeLoginView.hidden = YES;
    self.passwordLoginView.hidden = NO;
}

- (void)codeLoginClick {
    [self.passwordLoginButton setTitleColor:SPColor forState:UIControlStateNormal];
    [self.codeLoginButton setTitleColor:RGB(177, 177, 177) forState:UIControlStateNormal];
    self.codeLoginView.hidden = NO;
    self.passwordLoginView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
