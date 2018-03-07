//
//  SPAccount.m
//  HYSmartPlus
//
//  Created by information on 2017/9/11.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPAccount.h"

@implementation SPAccount

/**
 *  从文件中解析对象的时候调用
 */
- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.email = [decoder decodeObjectForKey:@"email"];
        self.locked = [decoder decodeObjectForKey:@"locked"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
        self.pwd = [decoder decodeObjectForKey:@"pwd"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.valid = [decoder decodeIntegerForKey:@"valid"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.locked forKey:@"locked"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeObject:self.pwd forKey:@"pwd"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeInteger:self.valid forKey:@"valid"];
}

@end
