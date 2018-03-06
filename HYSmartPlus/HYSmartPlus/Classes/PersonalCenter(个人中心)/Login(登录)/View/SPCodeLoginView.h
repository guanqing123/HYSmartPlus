//
//  SPCodeLoginView.h
//  HYSmartPlus
//
//  Created by information on 2018/2/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPCodeParam.h"
#import "SPLoginParam.h"

@class SPCodeLoginView;

@protocol SPCodeLoginViewDelegate <NSObject>
/**
 根据手机号获取验证码
 
 @param codeLoginView 当前对象
 */
- (void)codeLoginViewDidClickObtainVerifyCodeButton:(SPCodeLoginView *)codeLoginView;


/**
 根据 手机号和验证码 登录

 @param codeLoginView 当前对象
 */
- (void)codeLoginViewDidClickLoginButton:(SPCodeLoginView *)codeLoginView;

@end

@interface SPCodeLoginView : UIView
/**
 获取验证码的参数
 */
@property (nonatomic, strong)  SPCodeParam *codeParam;

/**
 登录参数
 */
@property (nonatomic, strong)  SPLoginParam *loginParam;

@property (nonatomic, weak) id<SPCodeLoginViewDelegate> delegate;

+ (instancetype)codeView;

- (void)countDown;

@end
