//
//  SPHyShopTool.m
//  HYSmartPlus
//
//  Created by information on 2020/3/27.
//  Copyright © 2020 hongyan. All rights reserved.
//

#import "SPHyShopTool.h"
#import "SPHttpTool.h"

@implementation SPHyShopTool

+ (void)getHyShopAddress:(NSDictionary *)params success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    NSString *urlStr = @"https://wx.hongyancloud.com/wxDev/sso/hyshop";
    
    [SPHttpTool postWithURL:urlStr params:params success:^(id json) {
        success(json);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
