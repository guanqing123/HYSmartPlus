//
//  SPBindBossViewController.h
//  HYSmartPlus
//
//  Created by information on 2018/5/11.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "LBXScanViewController.h"

@class SPBindBossViewController;

@protocol SPBindBossViewControllerDelegate <NSObject>
@required
- (void)bindBossViewController:(SPBindBossViewController *)bindBossVc resultStr:(NSString *)result;
@end

@interface SPBindBossViewController : LBXScanViewController

@property (nonatomic, weak) id<SPBindBossViewControllerDelegate> subDelegate;

@end
