//
//  SPSiteCreateParam.h
//  HYSmartPlus
//
//  Created by information on 2018/5/6.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPSiteCreateParam : NSObject

// 水电工id
@property (nonatomic, copy) NSString *uid;

// 业主姓名
@property (nonatomic, copy) NSString *userName;

// 业主电话
@property (nonatomic, copy) NSString *userTel;

// 详细地址
@property (nonatomic, copy) NSString *address;

// 备注
@property (nonatomic, copy) NSString *comment;

@end
