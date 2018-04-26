//
//  SPPersonCenterTool.h
//  HYSmartPlus
//
//  Created by information on 2018/4/23.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SPPersonScoreParam.h"
#import "SPPersonScoreResult.h"

#import "SPProblemParam.h"
#import "SPProblemResult.h"
#import "SPProblem.h"

@interface SPPersonCenterTool : UIView

/**
 根据参数获取积分相关信息

 @param personScoreParam 参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getPersonScore:(SPPersonScoreParam *)personScoreParam success:(void(^)(SPPersonScoreResult *result))success failure:(void(^)(NSError *error))failure;


+ (void)getProblem:(SPProblemParam *)problemParam success:(void(^)(SPProblemResult *result))success failure:(void(^)(NSError *error))failure;

@end
