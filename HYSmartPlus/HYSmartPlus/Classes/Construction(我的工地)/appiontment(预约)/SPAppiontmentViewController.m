//
//  SPAppiontmentViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/5/12.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPAppiontmentViewController.h"
#import <WebKit/WebKit.h>
#import "SPAccountTool.h"
#import "SPLoginResult.h"
#import "DGActivityIndicatorView.h"

@interface SPAppiontmentViewController ()<WKUIDelegate,WKNavigationDelegate>
/** webView */
@property (nonatomic, weak) WKWebView  *webView;
/** 指示器 */
@property (nonatomic, weak) DGActivityIndicatorView  *indicatorView;
@end

@implementation SPAppiontmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"预约服务";
    WKWebView *webView = [[WKWebView alloc] init];
    webView.frame = CGRectMake(0, SPTopNavH, ScreenW, ScreenH - SPTopNavH);
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    _webView = webView;
    [self.view addSubview:webView];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://wx.hongyancloud.com/honyar/templates/sjappiontment/appiontmentMap.html?uid=%@",[SPAccountTool loginResult].userbase.uid];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    
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

@end
