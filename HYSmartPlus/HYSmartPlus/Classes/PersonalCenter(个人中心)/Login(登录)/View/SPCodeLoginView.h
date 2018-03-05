//
//  SPCodeLoginView.h
//  HYSmartPlus
//
//  Created by information on 2018/2/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPCodeParam.h"

@class SPCodeLoginView;

@protocol SPCodeLoginViewDelegate <NSObject>
/**
 根据手机号获取验证码
 
 @param codeLoginView 当前对象
 */
- (void)codeLoginViewDidClickObtainVerifyCodeButton:(SPCodeLoginView *)codeLoginView;

@end

@interface SPCodeLoginView : UIView
/**
 获取验证码的参数
 */
@property (nonatomic, strong)  SPCodeParam *codeParam;

@property (nonatomic, weak) id<SPCodeLoginViewDelegate> delegate;

+ (instancetype)codeView;

@end
