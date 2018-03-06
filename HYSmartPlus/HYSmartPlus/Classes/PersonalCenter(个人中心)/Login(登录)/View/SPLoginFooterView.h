//
//  SPLoginFooterView.h
//  HYSmartPlus
//
//  Created by information on 2018/3/1.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPLoginFooterView;

@protocol SPLoginFooterViewDelegate <NSObject>
@optional

/**
 点击注册按钮

 @param loginFooterView 当前 footerView 对象
 */
- (void)loginFooterViewDidClickRegistBtn:(SPLoginFooterView *)loginFooterView;

@end

@interface SPLoginFooterView : UIView

@property (nonatomic, weak) id<SPLoginFooterViewDelegate> delegate;

+ (instancetype)footerView;

@end
