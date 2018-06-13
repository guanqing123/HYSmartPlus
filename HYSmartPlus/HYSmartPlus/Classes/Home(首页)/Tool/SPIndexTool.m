//
//  SPIndexTool.m
//  HYSmartPlus
//
//  Created by information on 2018/6/12.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPIndexTool.h"
#import "SPHttpTool.h"
#import "MJExtension.h"

@implementation SPIndexTool

+ (void)getHomePageListSuccess:(void (^)(SPHomePageResult *))success failure:(void (^)(NSError *))failure {
    
    NSString *urlStr = @"http://wx.hongyancloud.com/wxDev/homepage/getHomePageList";
    
    [SPHttpTool getWithURL:urlStr params:nil success:^(id json) {
        SPHomePageResult *result = [SPHomePageResult mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)getSellingActivityTopFive:(SPSellActivityParam *)sellActivityParam success:(void (^)(SPSellActivityResult *))success failure:(void (^)(NSError *))failure {
    
    NSString *urlStr = @"http://wx.hongyancloud.com/wxDev/sellactivity/getSellingActivityTopFive";
    
    NSDictionary *parameter = [sellActivityParam mj_keyValues];
    
    [SPHttpTool getWithURL:urlStr params:parameter success:^(id json) {
        SPSellActivityResult *result = [SPSellActivityResult mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)getSellingActivityFenye:(SPSellActivityFenyeParam *)sellActivityFenyeParam success:(void (^)(SPSellActivityFenyeResult *))success failure:(void (^)(NSError *))failure {
    
    NSString *urlStr = @"http://wx.hongyancloud.com/wxDev/sellactivity/getSellingActivityFenye";
    
    NSDictionary *parameter = [sellActivityFenyeParam mj_keyValues];
    
    [SPHttpTool getWithURL:urlStr params:parameter success:^(id json) {
        SPSellActivityFenyeResult *result = [SPSellActivityFenyeResult mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

@end
