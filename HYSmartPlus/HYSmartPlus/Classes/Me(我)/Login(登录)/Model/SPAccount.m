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
        self.telphone = [decoder decodeObjectForKey:@"telphone"];
        self.score = [decoder decodeIntForKey:@"score"];
        self.nickname = [decoder decodeObjectForKey:@"nickname"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.telphone forKey:@"telphone"];
    [encoder encodeInt:self.score forKey:@"score"];
    [encoder encodeObject:self.nickname forKey:@"nickname"];
}

@end
