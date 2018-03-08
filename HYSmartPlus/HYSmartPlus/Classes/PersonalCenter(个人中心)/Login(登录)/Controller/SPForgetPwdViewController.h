//
//  SPForgetPwdViewController.h
//  HYSmartPlus
//
//  Created by information on 2018/3/8.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPCodeParam.h"
#import "SPModifyPwdParam.h"

@interface SPForgetPwdViewController : UIViewController

/**
 获取验证码参数
 */
@property (nonatomic, strong)  SPCodeParam *codeParam;

/**
 修改密码参数
 */
@property (nonatomic, strong)  SPModifyPwdParam *modifyPwdParam;

@end
