//
//  SPLoginViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/2/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//
#import "SPRegisterViewController.h"
#import "SPForgetPwdViewController.h"
#import "SPLoginViewController.h"
#import "SPLoginHeaderView.h"
#import "SPLoginFooterView.h"

#import "SPCodeLoginView.h"
#import "SPPasswordLoginView.h"

#import "SPAccountTool.h"
#import "SPSmartPlusTool.h"
#import "SPLoginTool.h"

@interface SPLoginViewController () <UIScrollViewDelegate,SPPasswordLoginViewDelegate,SPCodeLoginViewDelegate,SPLoginFooterViewDelegate>
@property (nonatomic, strong) SPLoginHeaderView  *headerView;
@property (nonatomic, strong) SPLoginFooterView  *footerView;

@property (nonatomic, weak) SPPasswordLoginView  *passwordLoginView;
@property (nonatomic, weak) SPCodeLoginView  *codeLoginView;

@property (nonatomic, strong)  UIView *middleView;
/* 上一次选中的按钮 */
@property (strong , nonatomic)UIButton *selectBtn;
/* indicatorView */
@property (strong , nonatomic)UIView *indicatorView;
/* titleView */
@property (strong , nonatomic)UIView *titleView;
/* contentView */
@property (strong , nonatomic)UIScrollView *contentView;
@end

@implementation SPLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    // 1.设置头部View
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
    
    // 2.设置底部View
    [self.view addSubview:self.footerView];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
    
    // 3.设置中部View
    [self setupMiddleView];
}

#pragma mark - lazyLoad
- (SPLoginHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [SPLoginHeaderView headerView];
    }
    return _headerView;
}

- (SPLoginFooterView *)footerView {
    if (!_footerView) {
        _footerView = [SPLoginFooterView footerView];
        _footerView.delegate = self;
        WEAKSELF
        _footerView.btnBlock = ^{
            [MBProgressHUD showSuccess:@"暂不支持第三方登录" toView:weakSelf.view];
        };
    }
    return _footerView;
}

- (void)setupMiddleView {
    UIView *middleView = [[UIView alloc] init];
    _middleView = middleView;
    [self.view addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.footerView.mas_top);
        make.right.equalTo(self.view.mas_right);
    }];
    
    UIView *titleView = [[UIView alloc] init];
    _titleView = titleView;
    [middleView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleView.mas_top).offset(30);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(35);
    }];
    
    NSArray *titleArray = @[@"密码登录",@"动态码登录"];
    CGFloat buttonW = (ScreenW - 30) / 2;
    CGFloat buttonH = 32;
    CGFloat buttonX = 15;
    CGFloat buttonY = 0;
    for (NSInteger i = 0; i < titleArray.count; i++) {
        UIButton *button = [UIButton  buttonWithType:UIButtonTypeCustom];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = PFR16Font;
        button.tag = i;
        [button setTitleColor:RGB(177, 177, 177) forState:UIControlStateNormal];
        button.frame = CGRectMake((i * buttonW) + buttonX, buttonY, buttonW, buttonH);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
    }
    
    UIButton *firstButton = titleView.subviews[0];
    [self buttonClick:firstButton];
    [firstButton.titleLabel sizeToFit];
    
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    [titleView addSubview:indicatorView];
    _indicatorView = indicatorView;
    [indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(firstButton.titleLabel.mas_width);
        make.top.equalTo(firstButton.mas_bottom);
        make.centerX.equalTo(firstButton.mas_centerX);
        make.height.mas_equalTo(2);
    }];
    
    self.contentView.contentSize = CGSizeMake(ScreenW * titleArray.count, 0);
    [self setupContentView];
}

#pragma mark - SPLoginFooterViewDelegate
- (void)loginFooterViewDidClickRegistBtn:(SPLoginFooterView *)loginFooterView {
    SPRegisterViewController *registerVc = [[SPRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVc animated:YES];
}

#pragma mark - SPPasswordLoginViewDelegate
- (void)passwordLoginViewDidSubmitButton:(SPPasswordLoginView *)passwordLoginView {
    [MBProgressHUD showWaitMessage:@"登录中..." toView:self.view];
    [SPLoginTool login:passwordLoginView.loginParam success:^(SPLoginResult *loginResult) {
        [MBProgressHUD hideHUDForView:self.view];
        if (loginResult.error) {
            [MBProgressHUD showError:loginResult.errorMsg toView:self.view];
        }else{
            [MBProgressHUD showSuccess:@"登录成功" toView:self.view];
            // 1.存储模型数据
            [SPAccountTool saveLoginResult:loginResult];
            
            // 2.新特性\去首页
            [SPSmartPlusTool chooseRootController];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络异常,登录失败" toView:self.view];
    }];
}

- (void)passwordLoginViewforgetPwd:(SPPasswordLoginView *)passwordLoginView {
    SPForgetPwdViewController *forgetPwdVc = [[SPForgetPwdViewController alloc] init];
    [self.navigationController pushViewController:forgetPwdVc animated:YES];
}

- (void)passwordLoginViewRegistUser:(SPPasswordLoginView *)passwordLoginView {
    SPRegisterViewController *registerVc = [[SPRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVc animated:YES];
}

#pragma mark - 内容
- (void)setupContentView {
    
    [self.middleView addSubview:_contentView];
    WEAKSELF
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.indicatorView.mas_bottom);
        make.left.equalTo(weakSelf.middleView);
        make.bottom.equalTo(weakSelf.middleView);
        make.right.equalTo(weakSelf.middleView);
    }];
    
    /** 密码登录 */
    SPPasswordLoginView *passwordLoginView = [SPPasswordLoginView passwordView];
    passwordLoginView.delegate = self;
    _passwordLoginView = passwordLoginView;
    [_contentView addSubview:passwordLoginView];
    
    [passwordLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top).offset(0);
        make.left.equalTo(weakSelf.contentView.mas_left).offset(0);
        make.height.mas_equalTo(weakSelf.contentView);
        make.width.mas_equalTo(ScreenW);
    }];
    
    /** 短信登录 */
    SPCodeLoginView *codeLoginView = [SPCodeLoginView codeView];
    codeLoginView.delegate = self;
    _codeLoginView = codeLoginView;
    [_contentView addSubview:codeLoginView];
    
    [codeLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_top).offset(0);
        make.left.equalTo(passwordLoginView.mas_right).offset(0);
        make.height.mas_equalTo(weakSelf.contentView);
        make.width.mas_equalTo(ScreenW);
    }];
}

#pragma mark - SPCodeLoginViewDelegate
- (void)codeLoginViewDidClickObtainVerifyCodeButton:(SPCodeLoginView *)codeLoginView {
    if (![SPSpeedy dc_isTelephone:codeLoginView.codeParam.num]) {
        [MBProgressHUD showMessage:@"请输入正确的手机号码!" toView:self.view];
        return;
    }
    WEAKSELF
    [SPLoginTool getVerifyCode:codeLoginView.codeParam success:^(SPCodeResult *codeResult) {
        if (codeResult.error) {
            [MBProgressHUD showError:codeResult.errorMsg toView:weakSelf.view];
        }else{
            [MBProgressHUD showSuccess:@"验证码已发送,请注意查收" toView:weakSelf.view];
            [codeLoginView countDown];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络异常,验证码发送失败" toView:weakSelf.view];
    }];
}

- (void)codeLoginViewDidClickLoginButton:(SPCodeLoginView *)codeLoginView {
    WEAKSELF
    [MBProgressHUD showWaitMessage:@"登录中..." toView:weakSelf.view];
    [SPLoginTool login:codeLoginView.loginParam success:^(SPLoginResult *loginResult) {
        [MBProgressHUD hideHUDForView:self.view];
        if (loginResult.error) {
            [MBProgressHUD showError:loginResult.errorMsg toView:weakSelf.view];
        }else{
            [MBProgressHUD showSuccess:@"登录成功" toView:weakSelf.view];
            
            // 1.存储模型数据
            [SPAccountTool saveLoginResult:loginResult];
            
            // 2.新特性\去首页
            [SPSmartPlusTool chooseRootController];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view];
        [MBProgressHUD showError:@"网络异常,登录失败" toView:weakSelf.view];
    }];
}

#pragma mark - 按钮点击
- (void)buttonClick:(UIButton *)button{
    button.selected = !button.selected;
    [_selectBtn setTitleColor:RGB(177, 177, 177) forState:UIControlStateNormal];
    [button setTitleColor:SPColor forState:UIControlStateNormal];
    
    _selectBtn = button;
    
    WEAKSELF
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.indicatorView.dc_width = button.titleLabel.dc_width;
        weakSelf.indicatorView.dc_centerX = button.dc_centerX;
    }];
    
    CGPoint offset = _contentView.contentOffset;
    offset.x = _contentView.dc_width * button.tag;
    [_contentView setContentOffset:offset animated:YES];
}

#pragma mark - LazyLoad
- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.pagingEnabled = YES;
        _contentView.bounces = NO;
        _contentView.delegate = self;
    }
    return _contentView;
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.dc_width;
    UIButton *button = self.titleView.subviews[index];
    [self buttonClick:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 屏幕横竖屏设置
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
