//
//  SPInviteFriendView.h
//  HYSmartPlus
//
//  Created by information on 2018/4/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UMShare/UMShare.h>

@class SPInviteFriendView;

@protocol SPInviteFriendViewDelegate <NSObject>

- (void)inviteFriendView:(SPInviteFriendView *)inviteView platFromType:(UMSocialPlatformType)platfromType;

@end


@interface SPInviteFriendView : UIView

@property (nonatomic, weak) id<SPInviteFriendViewDelegate>  delegate;

+ (instancetype)inviteView;

@end
