//
//  SPHyShopViewController.m
//  HYSmartPlus
//
//  Created by information on 2020/3/27.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "SPHyShopViewController.h"
#import "SPHyShopTool.h"
#import <WebKit/WebKit.h>
#import "DGActivityIndicatorView.h"

#import "SPAccountTool.h"
#import "SPLoginResult.h"

@interface SPHyShopViewController ()<WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate>
/** webView */
@property (nonatomic, weak) WKWebView  *webView;
/** 指示器 */
@property (nonatomic, weak) DGActivityIndicatorView  *indicatorView;
/** UI */
@property (nonatomic, strong) UIProgressView *myProgressView;

@property(nonatomic,assign) CGFloat historyY;

@end

@implementation SPHyShopViewController

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, SPTopNavH, ScreenW, ScreenH - SPTopNavH)];
    webView.scrollView.delegate = self;
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    _webView = webView;
    [self.view addSubview:webView];
    
    [self.view addSubview:self.myProgressView];
    
//    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.size.mas_equalTo(self.view.dc_size);
//    }];
    
    // 加载器
    [self setupIndicatorView];
    
    // 请求数据
    [self getHyShop];
}

#pragma mark - getter and setter
- (UIProgressView *)myProgressView
{
//    https://www.jianshu.com/p/a727b945e9a8
    if (_myProgressView == nil) {
        _myProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, SPTopNavH, ScreenW, 0)];
        _myProgressView.tintColor = RGB(20, 200, 197);
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
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)getHyShop {
    [self.indicatorView startAnimating];
    WEAKSELF
    [SPHyShopTool getHyShopAddress:[NSDictionary dictionaryWithObject:[SPAccountTool loginResult].userbase.phone forKey:@"telephone"] success:^(id  _Nonnull json) {
        [weakSelf.indicatorView stopAnimating];
        [weakSelf.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[json objectForKey:@"data"]]]];
    } failure:^(NSError * _Nonnull error) {
        [weakSelf.indicatorView stopAnimating];
    }];
}

- (void)setupIndicatorView {
    DGActivityIndicatorView *indicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader tintColor:SPColor size:self.view.dc_width * 0.1];
    _indicatorView = indicatorView;
    [self.view addSubview:indicatorView];
    [indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
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


#pragma mark - delegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if ([webView canGoBack]) {
        if (!self.navigationItem.leftBarButtonItem) {
            [self setupNavItem];
        }
    }else{
        if (self.navigationItem.leftBarButtonItem) {
            self.navigationItem.leftBarButtonItem = nil;
        }
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.indicatorView stopAnimating];
    if ([webView canGoBack]) {
        if (!self.navigationItem.leftBarButtonItem) {
            [self setupNavItem];
        }
    }else{
        if (self.navigationItem.leftBarButtonItem) {
            self.navigationItem.leftBarButtonItem = nil;
        }
    }
}

- (void)setupNavItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"30"] withHighLightedImage:[UIImage imageNamed:@"30"] target:self action:@selector(back)];
}

- (void)back {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
}

#pragma mark -  滚动tableview 完毕之后
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    if (translation.y < 0) {
        [self setTabBarVisible:NO animated:YES];
    } else {
        [self setTabBarVisible:YES animated:YES];
    }
}

- (void)setTabBarVisible:(BOOL)visible animated:(BOOL)animated {
    if (visible && self.tabBarController.tabBar.hidden) {
        self.tabBarController.tabBar.hidden = NO;
    }
//    CGRect frame = self.tabBarController.tabBar.frame;
//    CGFloat height = frame.size.height;
//    CGFloat offsetY = (visible)? -height : height;

    
    if (visible) {
        [UIView animateWithDuration:0.5 animations:^{
            self.tabBarController.tabBar.alpha = 1;
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.tabBarController.tabBar.alpha = 0;
        }];
    }
//    [UIView animateWithDuration:duration animations:^{
//         self.tabBarController.tabBar.frame = CGRectOffset(frame, 0, offsetY);
//     }];
}

// 记得取消监听
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
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
