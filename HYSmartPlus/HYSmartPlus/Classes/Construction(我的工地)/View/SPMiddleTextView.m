//
//  SPMiddleTextView.m
//  HYSmartPlus
//
//  Created by information on 2018/5/7.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPMiddleTextView.h"

@implementation SPMiddleTextView

+ (instancetype)middleTextView {
    return [[[NSBundle mainBundle] loadNibNamed:@"SPMiddleTextView" owner:nil options:nil] lastObject];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    //圆角处理
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = frame;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
