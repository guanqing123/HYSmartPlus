//
//  SPIndexTool.h
//  HYSmartPlus
//
//  Created by information on 2018/6/12.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SPHomePageResult.h"

#import "SPSellActivityParam.h"
#import "SPSellActivityResult.h"

@interface SPIndexTool : NSObject

/**
 获取轮播图列表

 @param success 成功回答
 @param failure 失败回调
 */
+ (void)getHomePageListSuccess:(void(^)(SPHomePageResult *result))success failure:(void(^)(NSError *error))failure;


/**
 获取营销活动列表(安家APP)Top 5

 @param sellActivityParam 请求参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getSellingActivityTopFive:(SPSellActivityParam *)sellActivityParam success:(void(^)(SPSellActivityResult *result))success failure:(void(^)(NSError *error))failure;

@end
