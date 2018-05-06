//
//  SPAddressItem.h
//  HYSmartPlus
//
//  Created by information on 2018/5/4.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPAddressItem : NSObject

@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * sheng;
@property (nonatomic,copy) NSString * di;
@property (nonatomic,copy) NSString * xian;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * level;
@property (nonatomic,assign) BOOL  isSelected;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
