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

@interface SPLoginTool : NSObject

/**
 获取验证码

 @param codeParam 入参
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getVerifyCode:(SPCodeParam *)codeParam success:(void(^)(SPCodeResult *codeResult))success failure:(void(^)(NSError *error))failure;

@end
