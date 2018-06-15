//
//  SPDiscountViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/4/27.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPDiscountViewController.h"
#import <WebKit/WebKit.h>
#import "DGActivityIndicatorView.h"

#import "SPAccountTool.h"
#import "SPLoginResult.h"

@interface SPDiscountViewController () <WKUIDelegate,WKNavigationDelegate>
/** webView */
@property (nonatomic, weak) WKWebView  *webView;
/** 指示器 */
@property (nonatomic, weak) DGActivityIndicatorView  *indicatorView;
@end

@implementation SPDiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    NSString *urlStr = [NSString stringWithFormat:@"http://wx.hongyancloud.com/honyar/templates/code/sdCode.html?userid=%@",[SPAccountTool loginResult].userbase.uid];*/
    NSString *urlStr = [NSString stringWithFormat:@"http://wx.hongyancloud.com/wxDev/qrcode/getQrcode?type=1&uid=%@",[SPAccountTool loginResult].userbase.uid];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:webView];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    _webView = webView;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(@(280));
        make.width.equalTo(@(280));
    }];
    
    [self setupIndicatorView];
}

- (void)setupIndicatorView {
    DGActivityIndicatorView *indicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader tintColor:SPColor size:self.view.dc_width * 0.1];
    _indicatorView = indicatorView;
    [self.view addSubview:indicatorView];
    [indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

#pragma mark - navigationDelegate
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.indicatorView stopAnimating];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.indicatorView startAnimating];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.indicatorView stopAnimating];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.indicatorView stopAnimating];
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
