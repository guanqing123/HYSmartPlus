//
//  SPLoginResult.h
//  HYSmartPlus
//
//  Created by information on 2018/3/7.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPBaseResult.h"
#import "SPAccount.h"
#import "SPAccountDetail.h"

@interface SPLoginResult : SPBaseResult

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *token_expire_date;

@property (nonatomic, strong)  SPAccount *userbase;

@property (nonatomic, strong)  SPAccountDetail *userdetail;

@end
