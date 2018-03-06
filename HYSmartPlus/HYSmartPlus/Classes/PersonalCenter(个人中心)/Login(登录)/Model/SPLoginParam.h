//
//  SPLoginParam.h
//  HYSmartPlus
//
//  Created by information on 2018/3/5.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPBaseParam.h"

@interface SPLoginParam : SPBaseParam

@property (nonatomic, copy) NSString *num;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *pwd;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *token;

@end
