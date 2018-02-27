//
//  DCMySelfHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "SPMySelfHeadView.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface SPMySelfHeadView ()



@end

@implementation SPMySelfHeadView

#pragma mark - Intial
- (void)awakeFromNib {
    [super awakeFromNib];

    [SPSpeedy dc_chageControlCircularWith:_headImageButton AndSetCornerRadius:self.headImageButton.dc_width * 0.5 SetBorderWidth:1.5 SetBorderColor:[UIColor whiteColor] canMasksToBounds:YES];

//    DCUserInfo *userInfo = UserInfoData;
//    UIImage *image = ([userInfo.userimage isEqualToString:@"icon"]) ? [UIImage imageNamed:@"icon"] : [DCSpeedy Base64StrToUIImage:userInfo.userimage];
//    self.nickNameLabel.text = userInfo.nickname;
    UIImage *image = [UIImage imageNamed:@"icon"];
    [self.headImageButton setImage:image forState:UIControlStateNormal];
    
}

#pragma mark - Setter Getter Methods

#pragma mark - 点击事件
- (IBAction)imageButtonClick {
    !_myHeadImageViewClickBlock ? : _myHeadImageViewClickBlock();
}

@end
