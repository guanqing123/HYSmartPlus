//
//  SPConstructionTool.h
//  HYSmartPlus
//
//  Created by information on 2018/5/6.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SPDropowerFenyeParam.h"
#import "SPDropowerFenyeResult.h"

#import "SPSiteCreateParam.h"
#import "SPCommonResult.h"

#import "SPDeleteDropowerDetailParam.h"

#import "SPSaveDropowerDetailsParam.h"

@interface SPConstructionTool : NSObject

/**
 保存明细图

 @param saveDetailsParam 明细参数
 @param imageArray 图片数组
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)saveDropowerDetails:(SPSaveDropowerDetailsParam *)saveDetailsParam imageArray:(NSArray *)imageArray success:(void(^)(SPCommonResult *result))success failure:(void(^)(NSError *error))failure;

/**
 删除水电图主单和明细

 @param deleteParam 删除参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)deleteDropowerAndDetails:(SPDeleteDropowerDetailParam *)deleteParam success:(void(^)(SPCommonResult *result))success failure:(void(^)(NSError *error))failure;

/**
 删除水电图明细

 @param deleteParam 删除参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)deleteDropowerDetail:(SPDeleteDropowerDetailParam *)deleteParam success:(void(^)(SPCommonResult *result))success failure:(void(^)(NSError *error))failure;

/**
 获取水电图分页

 @param fenyeParam 分页参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getDropowerAndDetailsFenye:(SPDropowerFenyeParam *)fenyeParam success:(void(^)(SPDropowerFenyeResult *fenyeResult))success failure:(void(^)(NSError *error))failure;

/**
 创建工地

 @param param 主表信息
 @param imageArray 图片数组
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)constructionSiteCreate:(SPSiteCreateParam *)param imageArray:(NSArray *)imageArray success:(void(^)(SPCommonResult *result))success fail:(void(^)(NSError *error))failure;

@end
