//
//  SPHomeTool.h
//  HYSmartPlus
//
//  Created by information on 2017/9/19.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SPSliderParam.h"
#import "SPSliderResult.h"

@interface SPHomeTool : NSObject

+ (void)homeSliderWithParam:(SPSliderParam *)sliderParam success:(void(^)(NSArray *sliderResult))success failure:(void(^)(NSError *error))failure;

@end
