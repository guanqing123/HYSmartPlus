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

@property (nonatomic, assign) NSInteger idNum;

@property (nonatomic, copy) NSString *openId;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *userTel;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, strong)  NSArray *children;

@end
