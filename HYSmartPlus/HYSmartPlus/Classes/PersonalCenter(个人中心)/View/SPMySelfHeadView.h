//
//  DCMySelfHeadView.h
//  CDDMall
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPMySelfHeadView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIButton *headImageButton;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

/** 头像点击事件 */
@property (nonatomic, copy) dispatch_block_t myHeadImageViewClickBlock;

@end
