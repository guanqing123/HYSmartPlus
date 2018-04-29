//
//  SPInviteFriendView.m
//  HYSmartPlus
//
//  Created by information on 2018/4/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPInviteFriendView.h"
#import <WebKit/WebKit.h>
#import "SPAccountTool.h"
#import "SPLoginResult.h"

#import "DGActivityIndicatorView.h"

@interface SPInviteFriendView()<WKUIDelegate,WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet UIView *prentView;
@property (nonatomic, strong)  WKWebView *webView;
/** 指示器 */
@property (nonatomic, weak) DGActivityIndicatorView  *indicatorView;
- (IBAction)share;
@end

@implementation SPInviteFriendView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    WKWebView *webView = [[WKWebView alloc] init];
    NSString *urlStr = [NSString stringWithFormat:@"http://sge.cn/erp/app/register/%@",[SPAccountTool loginResult].userbase.uid];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://pan.baidu.com/share/qrcode?w=500&h=500&url=%@",urlStr]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.scrollView.bounces = NO;
    
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    
    _webView = webView;
    [self.prentView addSubview:webView];
    
    DGActivityIndicatorView *indicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader tintColor:SPColor size:ScreenW * 0.1];
    _indicatorView = indicatorView;
    [self.prentView addSubview:indicatorView];
}

+ (instancetype)inviteView {
    return [[[NSBundle mainBundle] loadNibNamed:@"SPInviteView" owner:self options:nil] lastObject];
}

- (void)updateConstraints {
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.prentView);
    }];
    
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.prentView);
    }];
    
    [super updateConstraints];
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

//  分享
- (IBAction)share {
    if ([self.delegate respondsToSelector:@selector(inviteFriendViewDidShare:)]) {
        [self.delegate inviteFriendViewDidShare:self];
    }
}
@end
