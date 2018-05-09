//
//  SPConstructionTool.m
//  HYSmartPlus
//
//  Created by information on 2018/5/6.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPConstructionTool.h"
#import "MJExtension.h"
#import "SPHttpTool.h"

@implementation SPConstructionTool

+ (void)deleteDropowerAndDetails:(SPDeleteDropowerDetailParam *)deleteParam success:(void (^)(SPCommonResult *))success failure:(void (^)(NSError *))failure {
    
    NSString *urlStr = @"http://wx.hongyancloud.com/wxDev/file/deleteDropowerAndDetails";
    
    NSDictionary *parameter = [deleteParam mj_keyValues];
    
    [SPHttpTool postWithURL:urlStr params:parameter success:^(id json) {
        SPCommonResult *result = [SPCommonResult mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

+ (void)deleteDropowerDetail:(SPDeleteDropowerDetailParam *)deleteParam success:(void (^)(SPCommonResult *result))success failure:(void (^)(NSError *))failure {
    
    NSString *urlStr = @"http://wx.hongyancloud.com/wxDev/file/deleteDropowerDetail";
    
    NSDictionary *parameter = [deleteParam mj_keyValues];
    
    [SPHttpTool postWithURL:urlStr params:parameter success:^(id json) {
        SPCommonResult *result = [SPCommonResult mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)getDropowerAndDetailsFenye:(SPDropowerFenyeParam *)fenyeParam success:(void (^)(SPDropowerFenyeResult *))success failure:(void (^)(NSError *))failure {
    
    NSString *urlStr = @"http://wx.hongyancloud.com/wxDev/file/getDropowerAndDetailsFenye";
    
    NSDictionary *parameter = [fenyeParam mj_keyValues];
    
    [SPHttpTool getWithURL:urlStr params:parameter success:^(id json) {
        SPDropowerFenyeResult *result = [SPDropowerFenyeResult mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


+ (void)constructionSiteCreate:(SPSiteCreateParam *)param imageArray:(NSArray *)imageArray success:(void (^)(SPCommonResult *))success fail:(void (^)(NSError *))failure {
    
    NSString *urlStr = @"http://wx.hongyancloud.com/wxDev/file/saveDropowerAndDetails";
    
    NSDictionary *parameter = [param mj_keyValues];
    
    [SPHttpTool postWithURL:urlStr params:parameter formDataArray:imageArray success:^(id json) {
        SPCommonResult *result = [SPCommonResult mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

@end
