//
//  SPPasswordLoginView.h
//  HYSmartPlus
//
//  Created by information on 2018/2/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PasswordLoginViewDelegate <NSObject>

- (void)passwordLoginComplete;

@end

@interface SPPasswordLoginView : UIView

@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIButton *submitButton;


@property (nonatomic, weak) id<PasswordLoginViewDelegate> delegate;

- (void)addLoadCycle;

- (void)pauseAnimation;

@end
