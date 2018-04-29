//
//  SPInviteFriendView.h
//  HYSmartPlus
//
//  Created by information on 2018/4/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPInviteFriendView;

@protocol SPInviteFriendViewDelegate <NSObject>

/**
 分享

 @param inviteView 当前二维码view
 */
- (void)inviteFriendViewDidShare:(SPInviteFriendView *)inviteView;

@end


@interface SPInviteFriendView : UIView

@property (nonatomic, weak) id<SPInviteFriendViewDelegate>  delegate;

+ (instancetype)inviteView;

@end
