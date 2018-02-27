//
//  SPZuoWenRightButton.m
//  HYSmartPlus
//
//  Created by information on 2017/11/21.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPZuoWenRightButton.h"

@implementation SPZuoWenRightButton

#pragma mark - intial
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    /** 设置label */
    self.titleLabel.dc_x = 0;
    self.titleLabel.dc_centerY = self.dc_centerY;
    [self.titleLabel sizeToFit];
    
    /** 设置图片位置 */
    self.imageView.dc_x = CGRectGetMaxX(self.titleLabel.frame) + 5;
    self.imageView.dc_centerY = self.dc_centerY;
    [self.imageView sizeToFit];
}

@end
