//
//  SPDropower.h
//  HYSmartPlus
//
//  Created by information on 2018/5/8.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPDropowerDetail.h"

@interface SPDropower : NSObject

@property (nonatomic, copy) NSString *idNum;

@property (nonatomic, copy) NSString *openId;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *userTel;

@property (nonatomic, copy) NSString *sysj;

@property (nonatomic, copy) NSString *bysj;

@property (nonatomic, copy) NSString *ksyl;

@property (nonatomic, copy) NSString *jsyl;

@property (nonatomic, copy) NSString *yj;

@property (nonatomic, copy) NSString *jg;

@property (nonatomic, copy) NSString *validate;

@property (nonatomic, copy) NSString *validateDate;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, strong)  NSArray *children;

@end
