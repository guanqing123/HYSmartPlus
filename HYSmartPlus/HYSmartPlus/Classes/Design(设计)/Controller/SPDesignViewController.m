//
//  SPDesignViewController.m
//  HYSmartPlus
//
//  Created by information on 2021/4/21.
//  Copyright © 2021 hongyan. All rights reserved.
//

#import "SPDesignViewController.h"
#import "SPH5BrowseViewController.h"

#import "SPAccountTool.h"
#import "SPLoginResult.h"
// webview/js bridge
#import <WebKit/WebKit.h>
#import "WKWebViewJavascriptBridge.h"

@interface SPDesignViewController ()<WKUIDelegate, WKNavigationDelegate>
// webView
@property (nonatomic, weak) WKWebView  *webView;
/** UI */
@property (nonatomic, strong) UIProgressView *myProgressView;
// js bridge
@property (nonatomic, strong)  WKWebViewJavascriptBridge *bridge;
@end

@implementation SPDesignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1.background & Nav
    [self setupView];
    
    // 2.webView
    [self setWebView];
}

- (void)setupView {
    // 1.背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    self.navigationItem.rightBarButtonItem = refresh;
}

- (void)refresh {
    [self.webView reload];
}

- (void)setWebView {
    WKWebView *webView = [[WKWebView alloc] init];
    webView.frame = CGRectMake(0, SPTopNavH, ScreenW, ScreenH - SPTopNavH - SPBottomTabH);
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    _webView = webView;
                            //http://dev.sge.cn/hykj/ghome/ghome.html
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wx.hongyancloud.com/hyaj/gdesign/gdesign.html?uid=%@",[SPAccountTool loginResult].userbase.uid]
                                                       ]
                          ]
     ];
    [self.view addSubview:webView];
    [self.view addSubview:self.myProgressView];
    
    [WKWebViewJavascriptBridge enableLogging];
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:webView];
    [_bridge setWebViewDelegate:self];
    
    if (@available(iOS 11.0, *)){
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
//        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - getter and setter
- (UIProgressView *)myProgressView
{
//    https://www.jianshu.com/p/a727b945e9a8
    if (_myProgressView == nil) {
        _myProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, SPTopNavH, ScreenW, 0)];
        _myProgressView.tintColor = SPColor;
        _myProgressView.trackTintColor = [UIColor whiteColor];
    }
    return _myProgressView;
}

#pragma mark - event response
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.myProgressView.alpha = 1.0f;
        [self.myProgressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.myProgressView.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 [self.myProgressView setProgress:0 animated:NO];
                             }];
        }
    } else if (object == self.webView && [keyPath isEqualToString:@"title"]){
        self.navigationItem.title = self.webView.title;
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark 移除观察者
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

#pragma mark - delegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"webView.frame = %@",NSStringFromCGRect(self.webView.frame));
    if ([webView canGoBack]) {
        if (!self.navigationItem.leftBarButtonItem) {
            [self setupNavItem];
        }
        self.tabBarController.tabBar.hidden = YES;
        self.webView.frame = CGRectMake(0, SPTopNavH, ScreenW, ScreenH - SPTopNavH);
    }else{
        if (self.navigationItem.leftBarButtonItem) {
            self.navigationItem.leftBarButtonItem = nil;
        }
        self.tabBarController.tabBar.hidden = NO;
        self.webView.frame = CGRectMake(0, SPTopNavH, ScreenW, ScreenH - SPTopNavH - SPBottomTabH);
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    if ([webView canGoBack]) {
        if (!self.navigationItem.leftBarButtonItem) {
            [self setupNavItem];
        }
        self.tabBarController.tabBar.hidden = YES;
        self.webView.frame = CGRectMake(0, SPTopNavH, ScreenW, ScreenH - SPTopNavH);
    }else{
        if (self.navigationItem.leftBarButtonItem) {
            self.navigationItem.leftBarButtonItem = nil;
        }
        self.tabBarController.tabBar.hidden = NO;
        self.webView.frame = CGRectMake(0, SPTopNavH, ScreenW, ScreenH - SPTopNavH - SPBottomTabH);
    }
}

#pragma mark - WKNavigationDelegate method
// 如果不添加这个，那么wkwebview跳转不了AppStore
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    if ([navigationAction.request.URL.absoluteString hasPrefix:@"https://itunes.apple.com"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else if ([navigationAction.request.URL.absoluteString containsString:@"wpa.qq.com"] && [navigationAction.request.URL.absoluteString containsString:@"site=qq"]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else if ([[NSPredicate predicateWithFormat:@"SELF BEGINSWITH[cd] 'mailto:' OR SELF BEGINSWITH[cd] 'tel:' OR SELF BEGINSWITH[cd] 'telprompt:'"] evaluateWithObject:navigationAction.request.URL.absoluteString]) {
        
        if ([[UIApplication sharedApplication] canOpenURL:navigationAction.request.URL]) {
            if (@available(iOS 10.0, *)) {
                [UIApplication.sharedApplication openURL:navigationAction.request.URL options:@{} completionHandler:NULL];
            } else {
                [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
            }
        }
        decisionHandler(WKNavigationActionPolicyCancel);
    } else if (![[NSPredicate predicateWithFormat:@"SELF MATCHES[cd] 'https' OR SELF MATCHES[cd] 'http' OR SELF MATCHES[cd] 'file' OR SELF MATCHES[cd] 'about' OR SELF MATCHES[cd] 'post'"] evaluateWithObject:navigationAction.request.URL.scheme]) {
        if ([navigationAction.request.URL.scheme isEqualToString:@"wvjbscheme"]) {
            //decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
        
        if (@available(iOS 8.0, *)) { // openURL if ios version is low then 8 , app will crash
            if ([[UIApplication sharedApplication] canOpenURL:navigationAction.request.URL]) {
                if (@available(iOS 10.0, *)) {
                    [UIApplication.sharedApplication openURL:navigationAction.request.URL options:@{} completionHandler:NULL];
                } else {
                    [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
                }
            }
        }else{
            if ([[UIApplication sharedApplication] canOpenURL:navigationAction.request.URL]) {
                [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
            }
        }
        
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)setupNavItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"30"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
}

- (void)back {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
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

