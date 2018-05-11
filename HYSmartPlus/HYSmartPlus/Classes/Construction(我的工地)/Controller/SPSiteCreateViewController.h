//
//  SPSiteCreateViewController.h
//  HYSmartPlus
//
//  Created by information on 2018/5/2.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPSiteCreateViewController;

@protocol SPSiteCreateViewControllerDelegate <NSObject>

/**
 完成工地创建

 @param siteCreateVc 工地新建控制器
 */
- (void)siteCreateVcFinishSave:(SPSiteCreateViewController *)siteCreateVc;

@end

@interface SPSiteCreateViewController : UIViewController

@property (nonatomic, weak) id<SPSiteCreateViewControllerDelegate>  delegate;

@end
