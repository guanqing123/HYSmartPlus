//
//  SPRegisterParam.h
//  HYSmartPlus
//
//  Created by information on 2018/3/6.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPBaseParam.h"

@interface SPRegisterParam : SPBaseParam

@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *pwd;
@property (nonatomic, copy) NSString *inviter;
@property (nonatomic, copy) NSString *inviterid;
@property (nonatomic, copy) NSString *valid;

@end
