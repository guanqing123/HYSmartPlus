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
#import "SPSiteCreateResult.h"

@interface SPConstructionTool : NSObject


+ (void)getDropowerAndDetailsFenye:(SPDropowerFenyeParam *)fenyeParam success:(void(^)(SPDropowerFenyeResult *fenyeResult))success failure:(void(^)(NSError *error))failure;

/**
 创建工地

 @param param 主表信息
 @param imageArray 图片数组
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)constructionSiteCreate:(SPSiteCreateParam *)param imageArray:(NSArray *)imageArray success:(void(^)(SPSiteCreateResult *result))success fail:(void(^)(NSError *error))failure;

@end
