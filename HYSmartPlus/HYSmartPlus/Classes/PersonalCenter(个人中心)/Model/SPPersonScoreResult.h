//
//  SPPersonScoreResult.h
//  HYSmartPlus
//
//  Created by information on 2018/4/23.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPBaseResult.h"
#import "SPNextGradeInfo.h"
#import "SPCurrentGradeInfo.h"

@interface SPPersonScoreResult : SPBaseResult

@property (nonatomic, strong)  NSArray *list;

@property (nonatomic, strong)  SPNextGradeInfo *nextGradeInfo;

@end
