//
//  UIBarButtonItem+SPBarButtonItem.m
//  HYSmartPlus
//
//  Created by information on 2017/11/13.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "UIBarButtonItem+SPBarButtonItem.h"

@implementation UIBarButtonItem (SPBarButtonItem)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image withHighLightedImage:(UIImage *)highLightedImage target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highLightedImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *contentView = [[UIView alloc] initWithFrame:btn.frame];
    [contentView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:contentView];
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image withSelected:(UIImage *)selectedImage target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *contentView = [[UIView alloc] initWithFrame:btn.frame];
    [contentView addSubview:btn];
    
    return [[UIBarButtonItem alloc] initWithCustomView:contentView];
}

@end
