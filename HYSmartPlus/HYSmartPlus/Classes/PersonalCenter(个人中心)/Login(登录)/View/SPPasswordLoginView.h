//
//  SPPasswordLoginView.h
//  HYSmartPlus
//
//  Created by information on 2018/2/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPLoginParam.h"
@class SPPasswordLoginView;

@protocol SPPasswordLoginViewDelegate <NSObject>
@optional
/**
 点击登录按钮

 @param passwordLoginView 当前对象
 */
- (void)passwordLoginViewDidSubmitButton:(SPPasswordLoginView *)passwordLoginView;


/**
 点击忘记密码按钮

 @param passwordLoginView 当前对象
 */
- (void)passwordLoginViewforgetPwd:(SPPasswordLoginView *)passwordLoginView;


/**
 点击注册按钮

 @param passwordLoginView 当前对象
 */
- (void)passwordLoginViewRegistUser:(SPPasswordLoginView *)passwordLoginView;

@end

@interface SPPasswordLoginView : UIView

/**
 登录参数
 */
@property (nonatomic, strong)  SPLoginParam *loginParam;

@property (nonatomic, weak) id<SPPasswordLoginViewDelegate> delegate;

+ (instancetype)passwordView;

@end
