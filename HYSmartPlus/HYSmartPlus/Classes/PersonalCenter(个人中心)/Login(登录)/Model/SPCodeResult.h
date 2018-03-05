//
//  SPCodeResult.h
//  HYSmartPlus
//
//  Created by information on 2018/3/5.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPCodeResult : NSObject

@property (nonatomic, assign) BOOL success;

@property (nonatomic, assign) BOOL error;
@property (nonatomic, copy) NSString *errorMsg;

+ (instancetype)result;

@end
