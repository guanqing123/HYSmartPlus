//
//  SPCommentViewController.h
//  HYSmartPlus
//
//  Created by information on 2019/10/25.
//  Copyright © 2019 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPDropower.h"
NS_ASSUME_NONNULL_BEGIN
@class SPCommentViewController;

@protocol SPCommentViewControllerDelegate <NSObject>
@optional
- (void)commentViewController:(SPCommentViewController *)commentVc;

@end

@interface SPCommentViewController : UIViewController

@property (nonatomic, strong) SPDropower *dropower;

- (instancetype)initWithDropower:(SPDropower *)dropower;

@property (nonatomic, weak) id<SPCommentViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
