//
//  SPAccountTool.h
//  HYSmartPlus
//
//  Created by information on 2017/9/11.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPAccount;

@interface SPAccountTool : NSObject

/**
 存储账号信息

 @param account 需要存储的账号
 */
+ (void)saveAccount:(SPAccount *)account;


/**
 返回存储的账号信息

 @return account
 */
+ (SPAccount *)account;


/**
 退出账号信息
 */
+ (void)deleteAccount;

@end
