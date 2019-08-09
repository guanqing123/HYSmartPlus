//
//  SPBottomToolBarView.h
//  HYSmartPlus
//
//  Created by information on 2018/5/8.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPBottomToolBarView;

typedef enum {
    ToolBarButtonTypeCamera,
    ToolBarButtonTypePressure,
    ToolBarButtonTypeDelete
}ToolBarButtonType;

@protocol SPBottomToolBarViewDelegate <NSObject>

/**
 点击底部按钮

 @param toolBar 工具栏
 @param buttonType 按钮类别
 */
- (void)bottomToolBar:(SPBottomToolBarView *)toolBar buttonType:(ToolBarButtonType)buttonType;

@end

@interface SPBottomToolBarView : UIImageView

@property (nonatomic, weak) UIButton  *cameraBtn;
@property (nonatomic, weak) UIButton  *pressureBtn;
@property (nonatomic, weak) UIButton  *deleteBtn;

@property (nonatomic, weak) id<SPBottomToolBarViewDelegate>  delegate;

@end
