//
//  SPNavSearchBarView.h
//  HYSmartPlus
//
//  Created by information on 2017/11/13.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPNavSearchBarView : UIView

/* 语言按钮 */
@property (nonatomic, weak) UIButton  *voiceImageBtn;
/* 占位文字 */
//@property (nonatomic, weak) UILabel  *placeholdLabel;
@property (nonatomic, weak) UITextField  *placeholdField;

/** 语音点击回调Block */
@property (nonatomic, copy) dispatch_block_t  voiceButtonClickBlock;
/** 搜索 */
@property (nonatomic, copy) dispatch_block_t  searchViewBlock;

/**
 intrinsicContentSize
 */
@property(nonatomic, assign) CGSize intrinsicContentSize;

@end
