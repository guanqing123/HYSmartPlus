//
//  SPChooseLocationView.h
//  HYSmartPlus
//
//  Created by information on 2018/5/3.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPChooseLocationView;

@protocol SPChooseLocationViewDelegate <NSObject>

/**
 完成地区之后的回调

 @param chooseLocationView 当前选择界面
 @param address 地址
 */
- (void)chooseLocationView:(SPChooseLocationView *)chooseLocationView address:(NSString *)address;
@end

@interface SPChooseLocationView : UIView

@property (nonatomic, copy) NSString * address;

@property (nonatomic, copy) void(^chooseFinish)(void);

@property (nonatomic, weak) id<SPChooseLocationViewDelegate>  delegate;

/* 省ID */
@property (nonatomic, copy) NSString *provinceId;

/* 市ID */
@property (nonatomic, copy) NSString *cityId;

/* 区ID */
@property (nonatomic, copy) NSString *districtId;

@end
