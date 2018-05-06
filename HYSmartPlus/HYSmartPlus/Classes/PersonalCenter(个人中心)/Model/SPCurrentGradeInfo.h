//
//  SPCurrentGradeInfo.h
//  HYSmartPlus
//
//  Created by information on 2018/4/23.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPBaseResult.h"

@interface SPCurrentGradeInfo : NSObject
//类型：Number  必有字段  备注：当前积分
@property (nonatomic, assign) NSInteger currentIntegral;
//类型：Number  必有字段  备注：等级值
@property (nonatomic, assign) NSInteger grade;
@property (nonatomic, assign) NSInteger gradeId;
//类型：String  必有字段  备注：等级名称
@property (nonatomic, copy) NSString *gradeName;
//类型：String  必有字段  备注：经销商代码，品牌积分为“00000000”
@property (nonatomic, copy) NSString *khdm;
@property (nonatomic, copy) NSString *khmc;
@property (nonatomic, assign) NSInteger state;
//类型：Number  必有字段  备注：已消费积分
@property (nonatomic, assign) NSInteger totalExpense;
//类型：Number  必有字段  备注：总积分
@property (nonatomic, assign) NSInteger totalIntegral;
//类型：String  必有字段  备注：用户ID
@property (nonatomic, copy) NSString *userid;
//类型：Number  必有字段  备注：等级系数
@property (nonatomic, assign) NSInteger weighing;
@end
