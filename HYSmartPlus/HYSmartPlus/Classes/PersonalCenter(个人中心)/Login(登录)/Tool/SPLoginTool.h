//
//  SPLoginTool.h
//  HYSmartPlus
//
//  Created by information on 2018/3/5.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SPCodeParam.h"
#import "SPCodeResult.h"

#import "SPRegisterParam.h"

#import "SPLoginParam.h"
#import "SPLoginResult.h"

@interface SPLoginTool : NSObject

/**
 获取验证码

 @param codeParam 入参
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getVerifyCode:(SPCodeParam *)codeParam success:(void(^)(SPCodeResult *codeResult))success failure:(void(^)(NSError *error))failure;

/**
 用户注册

 @param registerParam 入参
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)regist:(SPRegisterParam *)registerParam success:(void(^)(SPLoginResult *loginResult))success failure:(void(^)(NSError *error))failure;

/**
 用户登录

 @param loginParam 入参
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)login:(SPLoginParam *)loginParam success:(void(^)(SPLoginResult *loginResult))success failure:(void(^)(NSError *error))failure;

@end
