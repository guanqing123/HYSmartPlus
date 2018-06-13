//
//  SPLoadingView.h
//  HYSmartPlus
//
//  Created by information on 2018/6/13.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPLoadingView : UIView

@property (nonatomic, copy) dispatch_block_t refreshBlock;

+ (instancetype)loadingView;

- (void)loading;

- (void)success;

- (void)failure;

@end
