//
//  SPSmartPlusTool.m
//  HYSmartPlus
//
//  Created by information on 2017/9/11.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPSmartPlusTool.h"
#import "SPTabBarController.h"

@implementation SPSmartPlusTool

+(void)chooseRootController
{
    NSString *key = @"CFBundleVersion";
    
    //取出沙盒中存储的上次使用的软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:key];
    
    //获取当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[SPTabBarController alloc] init];
    } else { //新版本
        [UIApplication sharedApplication].keyWindow.rootViewController = [[SPTabBarController alloc] init];
        //存储新版本
        [defaults setObject:currentVersion forKey:key];
        [defaults synchronize];
    }
}

@end
