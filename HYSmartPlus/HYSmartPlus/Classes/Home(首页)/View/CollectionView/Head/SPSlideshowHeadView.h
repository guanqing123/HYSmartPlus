//
//  SPSlideshowHeadView.h
//  HYSmartPlus
//
//  Created by information on 2017/9/12.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPSlideshowHeadView : UICollectionReusableView

- (void)loading;

- (void)show:(NSArray *)slideImgArray;

@property (nonatomic, strong)  NSArray *imageURLStringsGroup;

@end
