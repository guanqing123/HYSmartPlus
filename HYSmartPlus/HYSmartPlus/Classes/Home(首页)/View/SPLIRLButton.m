//
//  SPLIRLButton.m
//  HYSmartPlus
//
//  Created by information on 2017/11/22.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPLIRLButton.h"

@implementation SPLIRLButton

#pragma mark - intial
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    self.titleLabel.dc_centerX = self.dc_width * 0.55;
    self.imageView.dc_x = self.titleLabel.dc_x - self.imageView.dc_width - 5;
}

@end
