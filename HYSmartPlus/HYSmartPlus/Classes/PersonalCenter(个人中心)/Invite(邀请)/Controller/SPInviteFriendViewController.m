//
//  SPInviteFriendViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/4/27.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPInviteFriendViewController.h"
#import <WebKit/WebKit.h>

@interface SPInviteFriendViewController ()
@property (weak, nonatomic) IBOutlet UIView *prentView;

@property (nonatomic, strong)  WKWebView *webView;

@end

@implementation SPInviteFriendViewController

- (void)awakeFromNib {
    NSLog(@"aaaaaaaaa");
    [super awakeFromNib];
    WKWebView *webView = [[WKWebView alloc] init];
    webView.backgroundColor = [UIColor redColor];
    _webView = webView;
    [self.prentView addSubview:webView];
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.prentView);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"bbbbbb");
    // Do any additional setup after loading the view from its nib.
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = YES;
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
