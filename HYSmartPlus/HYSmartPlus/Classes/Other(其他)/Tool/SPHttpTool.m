//
//  SPHttpTool.m
//  HYSmartPlus
//
//  Created by information on 2017/9/13.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPHttpTool.h"
#import "AFNetworking.h"

@implementation SPHttpTool

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.发送请求
    [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
