//
//  SPClassMainItem.h
//  HYSmartPlus
//
//  Created by information on 2017/11/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SPClassSubItem;
@interface SPClassMainItem : NSObject

/** 文标题 */
@property (nonatomic, copy) NSString *title;

/** goods */
@property (nonatomic, strong)  NSArray<SPClassSubItem *> *goods;

@end
