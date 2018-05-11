//
//  SPInviteFriendViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/4/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPInviteFriendViewController.h"
#import "SPInviteFriendView.h"

#import "SPAccountTool.h"
#import "SPLoginResult.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface SPInviteFriendViewController () <SPInviteFriendViewDelegate>
@property (nonatomic, weak) SPInviteFriendView  *inviteView;
@end

@implementation SPInviteFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请好友";
    // Do any additional setup after loading the view.
    SPInviteFriendView *inviteView = [SPInviteFriendView inviteView];
    inviteView.frame = CGRectMake(0, SPTopNavH, ScreenW, ScreenH - SPTopNavH);
    inviteView.delegate = self;
    _inviteView = inviteView;
    [self.view addSubview:inviteView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SPInviteFriendViewDelegate
- (void)inviteFriendViewDidShare:(SPInviteFriendView *)inviteView {
    //1、创建分享参数
    NSArray *imageArray = @[[UIImage imageNamed:@"shareImg"]];
    //(注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"注册成为水电工,赚取积分换大礼"
                                         images:imageArray
                                            url:[NSURL URLWithString:[NSString stringWithFormat:@"http://sge.cn/erp/app/register/%@",[SPAccountTool loginResult].userbase.uid]]
                                          title:@"注册水电工"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess:
                               {
                                   UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"恭喜" message:@"分享成功" preferredStyle:UIAlertControllerStyleAlert];
                                   [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                                   [self presentViewController:alertVc animated:YES completion:nil];
                                   break;
                               }
                           case SSDKResponseStateFail:
                               {
                                   UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"遗憾" message:@"分享失败" preferredStyle:UIAlertControllerStyleAlert];
                                   [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
                                   [self presentViewController:alertVc animated:YES completion:nil];
                                   break;
                               }
                           default:
                               break;
                       }
                   }];
    }

}

@end
