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

+ (void)constructionSiteCreate:(SPSiteCreateParam *)param imageArray:(NSArray *)imageArray success:(void (^)(SPSiteCreateResult *))success fail:(void (^)(NSError *))failure {
    
    NSString *urlStr = @"http://wx.hongyancloud.com/wxDev/file/saveDropowerAndDetails";
    
    NSDictionary *parameter = [param mj_keyValues];
    
    [SPHttpTool postWithURL:urlStr params:parameter formDataArray:imageArray success:^(id json) {
        SPSiteCreateResult *result = [SPSiteCreateResult mj_objectWithKeyValues:json];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
    
}

@end
