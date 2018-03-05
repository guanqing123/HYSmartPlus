//
//  SPPasswordLoginView.h
//  HYSmartPlus
//
//  Created by information on 2018/2/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPPasswordLoginView;

@protocol SPPasswordLoginViewDelegate <NSObject>
@optional
/**
 点击登录按钮

 @param passwordLoginView 当前对象
 */
- (void)passwordLoginViewDidSubmitButton:(SPPasswordLoginView *)passwordLoginView;
@end

@interface SPPasswordLoginView : UIView

+ (instancetype)passwordView;

@property (nonatomic, weak) id<SPPasswordLoginViewDelegate> delegate;

@property (nonatomic, strong)  NSDictionary *paramDict;
@end
