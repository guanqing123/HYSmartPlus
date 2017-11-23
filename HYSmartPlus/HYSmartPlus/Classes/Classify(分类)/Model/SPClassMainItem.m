//
//  SPClassMainItem.m
//  HYSmartPlus
//
//  Created by information on 2017/11/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPClassMainItem.h"
#import "MJExtension.h"
#import "SPClassSubItem.h"

@implementation SPClassMainItem

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"goods" : [SPClassSubItem class]};
}

@end
