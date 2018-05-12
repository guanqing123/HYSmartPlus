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

@interface SPAppiontmentViewController ()

@end

@implementation SPAppiontmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"预约服务";
    WKWebView *webView = [[WKWebView alloc] init];
    webView.frame = CGRectMake(0, SPTopNavH, ScreenW, ScreenH - SPTopNavH);
    [self.view addSubview:webView];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://wx.hongyancloud.com/honyar/templates/sjappiontment/appiontmentMap.html?uid=%@",[SPAccountTool loginResult].userbase.uid];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
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
