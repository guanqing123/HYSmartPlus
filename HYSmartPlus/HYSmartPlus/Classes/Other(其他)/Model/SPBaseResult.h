//
//  SPBaseResult.h
//  HYSmartPlus
//
//  Created by information on 2018/3/7.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPBaseResult : NSObject

@property (nonatomic, assign) BOOL error;
@property (nonatomic, copy) NSString *errorMsg;

+ (instancetype)result;

@end
