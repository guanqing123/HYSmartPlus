//
//  UIImage+SPExtension.m
//  HYSmartPlus
//
//  Created by information on 2017/11/15.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "UIImage+SPExtension.h"

@implementation UIImage (SPExtension)

+ (UIImage *)createImageWithColor:(UIColor *)color frame:(CGRect)frame {
    CGRect rect = CGRectMake(0, 0, frame.size.width, frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextFillRect(ctx, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
