//
//  SPCenterTopToolView.h
//  HYSmartPlus
//
//  Created by information on 2018/3/9.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TopToolBarButtonTypeScan,
    TopToolBarButtonTypeSetting
}TopToolBarButtonType;

@class SPCenterTopToolView;

@protocol SPCenterTopToolViewDelegate <NSObject>

/**
 按钮点击

 @param topToolView topToolView
 @param buttonType 按钮类型
 */
- (void)centerTopToolView:(SPCenterTopToolView *)topToolView buttonType:(TopToolBarButtonType)buttonType;

@end

@interface SPCenterTopToolView : UIView

@property (nonatomic, weak) id<SPCenterTopToolViewDelegate>  delegate;

@end
