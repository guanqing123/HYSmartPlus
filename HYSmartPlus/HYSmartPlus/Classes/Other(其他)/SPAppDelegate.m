//
//  AppDelegate.m
//  HYSmartPlus
//
//  Created by information on 2017/9/7.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件<
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加”-ObjC”

#import "SPAppDelegate.h"
#import "SPAccount.h"
#import "SPAccountTool.h"
#import "SPLoginTool.h"
#import "SPSmartPlusTool.h"
#import "SPNavigationController.h"
#import "SPLoginViewController.h"

#import "ATAppUpdater.h"

@interface SPAppDelegate ()

@end

@implementation SPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[ATAppUpdater sharedUpdater] showUpdateWithConfirmation];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyWindow];
    
    // 先判断有无存储账号信息
    SPLoginResult *result = [SPAccountTool loginResult];
    
    if (result) { //之前登录成功
        SPLoginParam *param = [SPLoginParam param:APP00005];
        param.uid = result.userbase.uid;
        param.token = result.token;
        WEAKSELF
        [SPLoginTool login:param success:^(SPLoginResult *loginResult) {
            if (loginResult.error) {
                // 1.实例化UIAlertController
                UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"警告" message:loginResult.errorMsg preferredStyle:UIAlertControllerStyleAlert];
                // 2.实例化UIAlertAction
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [SPAccountTool deleteLoginResult];
                    weakSelf.window.rootViewController = [[SPNavigationController alloc] initWithRootViewController:[[SPLoginViewController alloc] init]];
                }];
                [alertVc addAction:sureAction];
                // 3.显示UIAlertController
                [weakSelf.window.rootViewController presentViewController:alertVc animated:YES completion:nil];
            }
        } failure:^(NSError *error) {
        }];
        [SPSmartPlusTool chooseRootController];
    } else { //之前没有登录成功
        self.window.rootViewController = [[SPNavigationController alloc] initWithRootViewController:[[SPLoginViewController alloc] init]];
    }
    
    /**初始化ShareSDK应用
     
     @param activePlatforms
     使用的分享平台集合
     @param importHandler (onImport)
     导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
     @param configurationHandler (onConfiguration)
     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     */
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeQQ),
                                        @(SSDKPlatformTypeWechat)]
                             onImport:^(SSDKPlatformType platformType) {
                                            switch (platformType) {
                                                case SSDKPlatformTypeWechat:
                                                    [ShareSDKConnector connectWeChat:[WXApi class]];
                                                    break;
                                                case SSDKPlatformTypeQQ:
                                                    [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                                    break;
                                                case SSDKPlatformTypeSinaWeibo:
                                                    [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                                    break;
                                                default:
                                                    break;
                                            }
                             } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                 switch (platformType) {
                                     case SSDKPlatformTypeSinaWeibo:
                                         //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                                         [appInfo SSDKSetupSinaWeiboByAppKey:@"195789847"
                                                                   appSecret:@"1d3e2221a061bfdf2ee454b1d88f19d3"
                                                                 redirectUri:@"https://api.weibo.com/oauth2/default.html"
                                                                    authType:SSDKAuthTypeBoth];
                                         break;
                                    case SSDKPlatformTypeWechat:
                                         [appInfo SSDKSetupWeChatByAppId:@"wxbed6a5bcb1b6b3a6"
                                                               appSecret:@"cf1de0c0622e3723f7762369ae52ae8a"];
                                         break;
                                    case SSDKPlatformTypeQQ:
                                         [appInfo SSDKSetupQQByAppId:@"1106675071"
                                                              appKey:@"81H5M4YV78m9mOcO"
                                                            authType:SSDKAuthTypeBoth];
                                         break;
                                     default:
                                         break;
                                 }
                             }];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([[url absoluteString] containsString:@"hongyar://anjia"]) {
        [SPSmartPlusTool pressureChooseRootController];
        return YES;
    }
    return NO;
}
#else
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([[url absoluteString] containsString:@"hongyar://anjia"]) {
        [SPSmartPlusTool pressureChooseRootController];
        return YES;
    }
    return NO;
}
#endif
@end
