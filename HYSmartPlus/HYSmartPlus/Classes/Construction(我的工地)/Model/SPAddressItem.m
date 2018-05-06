//
//  SPAddressItem.m
//  HYSmartPlus
//
//  Created by information on 2018/5/4.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPAddressItem.h"

@implementation SPAddressItem

- (instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
