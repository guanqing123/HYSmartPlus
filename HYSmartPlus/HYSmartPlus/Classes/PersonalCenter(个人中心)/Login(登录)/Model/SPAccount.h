//
//  SPAccount.h
//  HYSmartPlus
//
//  Created by information on 2017/9/11.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPAccount : NSObject <NSCoding>

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *locked;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *pwd;
@property (nonatomic, assign) NSInteger valid;

@end
