//
//  SPPersonScoreResult.m
//  HYSmartPlus
//
//  Created by information on 2018/4/23.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPPersonScoreResult.h"
#import "MJExtension.h"

@implementation SPPersonScoreResult

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list" : [SPCurrentGradeInfo class]};
}

@end
