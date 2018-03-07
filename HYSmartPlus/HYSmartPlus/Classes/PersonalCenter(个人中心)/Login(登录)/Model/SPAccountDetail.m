//
//  SPAccountDetail.m
//  HYSmartPlus
//
//  Created by information on 2018/3/7.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPAccountDetail.h"

@implementation SPAccountDetail

/**
 *  从文件中解析对象的时候调用
 */
- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.alipay_id = [decoder decodeObjectForKey:@"alipay_id"];
        self.area_id = [decoder decodeObjectForKey:@"area_id"];
        self.area_name = [decoder decodeObjectForKey:@"area_name"];
        self.birth = [decoder decodeObjectForKey:@"birth"];
        self.gender = [decoder decodeObjectForKey:@"gender"];
        self.inviter = [decoder decodeObjectForKey:@"inviter"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.nick_modify = [decoder decodeObjectForKey:@"nick_modify"];
        self.nick_name = [decoder decodeObjectForKey:@"nick_name"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.wechat_id = [decoder decodeObjectForKey:@"wechat_id"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.alipay_id forKey:@"alipay_id"];
    [encoder encodeObject:self.area_id forKey:@"area_id"];
    [encoder encodeObject:self.area_name forKey:@"area_name"];
    [encoder encodeObject:self.birth forKey:@"birth"];
    [encoder encodeObject:self.gender forKey:@"gender"];
    [encoder encodeObject:self.inviter forKey:@"inviter"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.nick_modify forKey:@"nick_modify"];
    [encoder encodeObject:self.nick_name forKey:@"nick_name"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.wechat_id forKey:@"wechat_id"];
}

@end
