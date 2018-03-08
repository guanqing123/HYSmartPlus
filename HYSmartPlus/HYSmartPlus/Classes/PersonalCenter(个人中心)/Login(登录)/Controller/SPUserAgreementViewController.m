//
//  SPUserAgreementViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/3/8.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPUserAgreementViewController.h"
#import <WebKit/WebKit.h>

@interface SPUserAgreementViewController ()
@property (nonatomic, weak) WKWebView  *webView;
@end

@implementation SPUserAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupBgAndNav];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"licenseagreementchines" ofType:@"txt"];
    [webView loadFileURL:[NSURL fileURLWithPath:filePath] allowingReadAccessToURL:[NSURL fileURLWithPath:filePath]];
    _webView = webView;
    [self.view addSubview:webView];
}

- (void)setupBgAndNav {
    // 0.设置标题
    self.title = @"用户协议";
    // 1.背景
    self.view.backgroundColor = [UIColor whiteColor];
    // 2.导航栏
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"30"] withHighLightedImage:[UIImage imageNamed:@"30"] target:self action:@selector(back)];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
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
