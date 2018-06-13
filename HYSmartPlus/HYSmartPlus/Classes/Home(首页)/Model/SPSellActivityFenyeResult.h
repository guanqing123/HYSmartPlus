//
//  SPSellActivityFenyeResult.h
//  HYSmartPlus
//
//  Created by information on 2018/6/13.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPSellActivityFenye.h"

@interface SPSellActivityFenyeResult : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong)  SPSellActivityFenye *sellActivityFenye;

@end
