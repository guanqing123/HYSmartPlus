//
//  SPSellActivityDetailViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/6/13.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPSellActivityDetailViewController.h"
#import <WebKit/WebKit.h>

@interface SPSellActivityDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) WKWebView  *webView;
@end

@implementation SPSellActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"安家帮详情";
    
    // 客户端添加meta标签eg
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);var imgs = document.getElementsByTagName('img');for (var i in imgs){imgs[i].style.maxWidth='100%';imgs[i].style.height='auto';}";
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    
    //创建网页配置对象
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.userContentController = wkUController;
    
    WKPreferences *preference = [[WKPreferences alloc] init];
    preference.minimumFontSize = 14;
    config.preferences = preference;
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView = webView;
    [self.parentView addSubview:webView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect tempRect = self.parentView.frame;
    tempRect.origin.y += SPTopNavH;
    tempRect.size.height -= SPTopNavH;
    self.parentView.frame = tempRect;
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.parentView.mas_left);
        make.right.mas_equalTo(self.parentView.mas_right);
        make.bottom.mas_equalTo(self.parentView.mas_bottom).offset(-SPTopNavH);
    }];
}

- (void)setSellActivity:(SPSellActivity *)sellActivity {
    _sellActivity = sellActivity;
    
    self.titleLabel.text = sellActivity.title;
    
    if ([sellActivity.startDate length] > 0) {
        self.timeLabel.text = [NSString stringWithFormat:@"活动日期: %@ - %@",sellActivity.startDate, sellActivity.endDate];
    }else{
        self.timeLabel.text = sellActivity.createDate;
    }
    
    [self.webView loadHTMLString:sellActivity.content baseURL:nil];
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
