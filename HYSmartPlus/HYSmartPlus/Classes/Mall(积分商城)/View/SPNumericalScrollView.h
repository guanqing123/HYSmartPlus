//
//  SPNumericalScrollView.h
//  HYSmartPlus
//
//  Created by information on 2017/11/21.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPNumericalScrollView;

@protocol SPNumericalScrollViewDelegate <NSObject>
@optional
/**
 点击滚动页
 
 @param index 当前显示索引
 */
- (void)numericalScrollView:(SPNumericalScrollView *)numericalScrollView didSelectNoticeActionAtIndex:(NSInteger)index;

@end

@interface SPNumericalScrollView : UIView

/** 定时器的循环时间 */
@property (nonatomic , assign) NSInteger interval;

@property (nonatomic, weak) id<SPNumericalScrollViewDelegate>  delegate;

/**
 根据图片和数组创建对象

 @param frame 尺寸
 @param imageName 头条图片
 @param titlesArray 标题数组
 @param imagesTitlesArray 图片数组
 @return 当前对象
 */
- (instancetype)initWithFrame:(CGRect)frame andImage:(NSString *)imageName andDataTArray:(NSArray *)titlesArray withDataIArray:(NSArray *)imagesTitlesArray;

/**
 创建定时器并run
 */
- (void)startTimer;

@end
