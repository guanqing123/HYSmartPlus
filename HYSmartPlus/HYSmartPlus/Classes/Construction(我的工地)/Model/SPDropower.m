//
//  SPDropower.m
//  HYSmartPlus
//
//  Created by information on 2018/5/8.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPDropower.h"
#import "MJExtension.h"

@implementation SPDropower

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"idNum" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"children":[SPDropowerDetail class]};
}

@end
