//
//  SPH5BrowseViewController.m
//  HYSmartPlus
//
//  Created by information on 2021/3/25.
//  Copyright © 2021 hongyan. All rights reserved.
//

#import "SPH5BrowseViewController.h"

#import "SPAccountTool.h"
#import "SPLoginResult.h"

// webview/js bridge
#import <WebKit/WebKit.h>
#import "WKWebViewJavascriptBridge.h"

@interface SPH5BrowseViewController () <WKUIDelegate, WKNavigationDelegate>
// webView
@property (nonatomic, weak) WKWebView  *webView;
/** UI */
@property (nonatomic, strong) UIProgressView *myProgressView;
// js bridge
@property (nonatomic, strong)  WKWebViewJavascriptBridge *bridge;
@end

@implementation SPH5BrowseViewController

- (instancetype)initWithUrl:(NSString *)url {
    if (self = [super init]) {
        _url = url;
    }
    return self;
}

#pragma mark - lifeCicle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 1.background & Nav
    [self setupView];
    
    // 2.webView
    [self setWebView];
}

#pragma mark - init
- (void)setupView {
    // 1.背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 2.回退
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"30"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    // 3.右
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
}

- (void)refresh {
    [self.webView reload];
}

- (void)back {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - webView
- (void)setWebView {
    WKWebView *webView = [[WKWebView alloc] init];
    webView.frame = CGRectMake(0, SPTopNavH, ScreenW, ScreenH - SPTopNavH);
    
    NSLog(@"bounds = %@",NSStringFromCGRect(self.view.bounds));
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    _webView = webView;
    
    if ([_url rangeOfString:@"?"].location != NSNotFound) {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&uid=%@",_url,[SPAccountTool loginResult].userbase.uid]]]];
    } else {
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?uid=%@",_url,[SPAccountTool loginResult].userbase.uid]]]];
    }
    
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
    
    // 1.goBack
    WEAKSELF
    [_bridge registerHandler:@"goBack" handler:^(id data, WVJBResponseCallback responseCallback) {
        [weakSelf goBack];
    }];
}

- (void)goBack {
    !_h5BrowseVcBlock ? : _h5BrowseVcBlock();
    [self.navigationController popViewControllerAnimated:YES];
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
        self.title = self.webView.title;
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
