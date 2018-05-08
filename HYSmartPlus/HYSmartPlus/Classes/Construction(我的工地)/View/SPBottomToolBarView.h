//
//  SPBottomToolBarView.h
//  HYSmartPlus
//
//  Created by information on 2018/5/8.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ToolBarButtonTypeCamera,
    ToolBarButtonTypeDelete
}ToolBarButtonType;

@interface SPBottomToolBarView : UIImageView

@property (nonatomic, weak) UIButton  *cameraBtn;
@property (nonatomic, weak) UIButton  *deleteBtn;

@end
