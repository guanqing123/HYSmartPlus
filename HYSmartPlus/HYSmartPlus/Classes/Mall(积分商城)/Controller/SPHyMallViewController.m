//
//  SPHyMallViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/4/27.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPHyMallViewController.h"
#import <WebKit/WebKit.h>
#import "DGActivityIndicatorView.h"

#import "SPAccountTool.h"
#import "SPLoginResult.h"

@interface SPHyMallViewController () <WKUIDelegate,WKNavigationDelegate>
/** webView */
@property (nonatomic, weak) WKWebView  *webView;
/** 指示器 */
@property (nonatomic, weak) DGActivityIndicatorView  *indicatorView;
@end

@implementation SPHyMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, SPTopNavH, ScreenW, ScreenH - SPTopNavH - SPBottomTabH)];
    webView.scrollView.showsVerticalScrollIndicator = YES;
    NSString *urlStr = [NSString stringWithFormat:@"http://wx.hongyancloud.com/hymall/work/lists.html?userid=%@",[SPAccountTool loginResult].userbase.uid];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    _webView = webView;
    [self.view addSubview:webView];
    
    [self setupRightNavItem];
    
    [self setupIndicatorView];
}

- (void)setupRightNavItem {
    UIBarButtonItem *shopCar = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"car"] withHighLightedImage:[UIImage imageNamed:@"car"] target:self action:@selector(goShopCar)];
    
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] init];
    flex.width = 25;
    
    UIBarButtonItem *order = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"order"] withSelected:[UIImage imageNamed:@"order"] target:self action:@selector(order)];
    
    self.navigationItem.rightBarButtonItems = @[order,flex,shopCar];
}

- (void)goShopCar {
    NSString *urlStr = [NSString stringWithFormat:@"http://wx.hongyancloud.com/hymall/work/buycar.html?userid=%@",[SPAccountTool loginResult].userbase.uid];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

- (void)order {
    NSString *urlStr = [NSString stringWithFormat:@"http://wx.hongyancloud.com/hymall/work/order.html?userid=%@",[SPAccountTool loginResult].userbase.uid];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

- (void)setupIndicatorView {
    DGActivityIndicatorView *indicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader tintColor:SPColor size:self.view.dc_width * 0.1];
    _indicatorView = indicatorView;
    [self.view addSubview:indicatorView];
    [indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)setupNavItem {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"30"] withHighLightedImage:[UIImage imageNamed:@"30"] target:self action:@selector(back)];
}

- (void)back {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
