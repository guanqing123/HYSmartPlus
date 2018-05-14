//
//  SPMyCenterHeaderView.h
//  HYSmartPlus
//
//  Created by information on 2018/3/9.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPMyCenterHeaderView : UIView

@property (nonatomic, copy) dispatch_block_t myIconBtnClick;

+ (instancetype)headerView;

- (void)setData;

@end
