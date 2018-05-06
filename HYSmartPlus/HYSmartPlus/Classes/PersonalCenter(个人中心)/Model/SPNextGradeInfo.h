//
//  SPNextGradeInfo.h
//  HYSmartPlus
//
//  Created by information on 2018/4/23.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPNextGradeInfo : NSObject

@property (nonatomic, assign) NSInteger grade;
@property (nonatomic, copy) NSString *gradeName;
@property (nonatomic, assign) NSInteger gtype;
@property (nonatomic, assign) NSInteger idStr;
@property (nonatomic, assign) NSInteger integral;
@property (nonatomic, assign) NSInteger isDefault;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *weighing;

@end
