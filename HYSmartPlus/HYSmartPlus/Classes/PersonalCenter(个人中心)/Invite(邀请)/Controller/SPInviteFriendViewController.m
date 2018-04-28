//
//  SPInviteFriendViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/4/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPInviteFriendViewController.h"
#import "SPInviteFriendView.h"

@interface SPInviteFriendViewController () <SPInviteFriendViewDelegate>
@property (nonatomic, weak) SPInviteFriendView  *inviteView;
@end

@implementation SPInviteFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void)inviteFriendView:(SPInviteFriendView *)inviteView platFromType:(UMSocialPlatformType)platfromType {
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    messageObject.text = @"测试";
    
    [[UMSocialManager defaultManager] shareToPlatform:platfromType messageObject:messageObject currentViewController:self completion:^(id result, NSError *error) {
        
    }];
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
