//
//  SPLoginResult.m
//  HYSmartPlus
//
//  Created by information on 2018/3/7.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPLoginResult.h"

@implementation SPLoginResult

/**
 *  从文件中解析对象的时候调用
 */
- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.token_expire_date = [decoder decodeObjectForKey:@"token_expire_date"];
        self.token = [decoder decodeObjectForKey:@"token"];
        self.userbase = [decoder decodeObjectForKey:@"userbase"];
        self.userdetail = [decoder decodeObjectForKey:@"userdetail"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.token_expire_date forKey:@"token_expire_date"];
    [encoder encodeObject:self.token forKey:@"token"];
    [encoder encodeObject:self.userbase forKey:@"userbase"];
    [encoder encodeObject:self.userdetail forKey:@"userdetail"];
}

@end
