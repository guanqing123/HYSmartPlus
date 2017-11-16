//
//  UIImage+SPExtension.h
//  HYSmartPlus
//
//  Created by information on 2017/11/15.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SPExtension)


/**
 根据颜色值生成纯色图片
 
 @param color 颜色
 @param frame 尺寸
 @return 图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color frame:(CGRect)frame;

@end
