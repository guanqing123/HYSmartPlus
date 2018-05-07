//
//  SPConstructionTool.h
//  HYSmartPlus
//
//  Created by information on 2018/5/6.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SPSiteCreateParam.h"
#import "SPSiteCreateResult.h"

@interface SPConstructionTool : NSObject

+ (void)constructionSiteCreate:(SPSiteCreateParam *)param imageArray:(NSArray *)imageArray success:(void(^)(SPSiteCreateResult *result))success fail:(void(^)(NSError *error))failure;

@end
