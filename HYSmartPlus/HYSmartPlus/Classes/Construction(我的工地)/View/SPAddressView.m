//
//  SPAddressView.m
//  HYSmartPlus
//
//  Created by information on 2018/5/4.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPAddressView.h"

static  CGFloat  const  HYBarItemMargin = 20;
@interface SPAddressView()

@property (nonatomic, strong)  NSMutableArray *btnArray;

@end

@implementation SPAddressView

- (NSMutableArray *)btnArray {
    
    NSMutableArray *btnArray = [NSMutableArray array];
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            [btnArray addObject:subView];
        }
    }
    
    _btnArray = btnArray;
    return _btnArray;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (NSInteger i = 0; i <= self.btnArray.count - 1; i++) {
        UIView *subView = self.btnArray[i];
        if (i == 0) {
            subView.dc_x = HYBarItemMargin;
        }
        if (i > 0) {
            UIView *preView = self.btnArray[i - 1];
            subView.dc_x = HYBarItemMargin + preView.dc_right;
        }
    }
    
}

@end
