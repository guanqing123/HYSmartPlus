//
//  SPAccountTool.h
//  HYSmartPlus
//
//  Created by information on 2017/9/11.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPLoginResult;

@interface SPAccountTool : NSObject

/**
 存储登录之后的信息

 @param loginResult 需要保存的登录信息
 */
+ (void)saveLoginResult:(SPLoginResult *)loginResult;

/**
 返回存储的登录信息

 @return loginResult
 */
+ (SPLoginResult *)loginResult;

/**
 删除登录信息
 */
+ (void)deleteLoginResult;

@end
