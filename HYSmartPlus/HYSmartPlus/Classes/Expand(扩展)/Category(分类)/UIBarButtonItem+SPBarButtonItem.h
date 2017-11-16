//
//  UIBarButtonItem+SPBarButtonItem.h
//  HYSmartPlus
//
//  Created by information on 2017/11/13.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SPBarButtonItem)


/**
 根据 normal/highLighted 图片创建 UIBarButtonItem

 @param image 正常图片
 @param highLightedImage 高亮图片
 @param target 事件对象
 @param action 事件方法
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image withHighLightedImage:(UIImage *)highLightedImage target:(id)target action:(SEL)action;


/**
 根据 normal/selected 图片创建 UIBarButtonItem

 @param image 正常图片
 @param selectedImage 选中图片
 @param target 事件对象
 @param action 事件方法
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image withSelected:(UIImage *)selectedImage target:(id)target action:(SEL)action;

@end
