//
//  SPMoreButton.m
//  HYSmartPlus
//
//  Created by information on 2018/6/12.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPMoreButton.h"

@implementation SPMoreButton

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
    [self.titleLabel sizeToFit];
    
    /** 设置图片位置 */
    self.imageView.dc_x = CGRectGetMaxX(self.titleLabel.frame) + 5;
    [self.imageView sizeToFit];
}

@end
