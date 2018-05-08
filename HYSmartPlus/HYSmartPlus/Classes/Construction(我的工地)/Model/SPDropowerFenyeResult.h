//
//  SPDropowerFenyeResult.h
//  HYSmartPlus
//
//  Created by information on 2018/5/8.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPDropowerFenye.h"

@interface SPDropowerFenyeResult : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong)  SPDropowerFenye *dropowerFenye;

@end
