//
//  SPCodeLoginView.h
//  HYSmartPlus
//
//  Created by information on 2018/2/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^verifyHandler)(void);

@protocol CodeLoginViewDelegate <NSObject>

- (void)codeLoginComplete;

@end

@interface SPCodeLoginView : UIView

@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, copy) verifyHandler handler;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, weak) id<CodeLoginViewDelegate> delegate;

- (void)addLoadCycle;

- (void)pauseAnimation;

@end
