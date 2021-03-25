//
//  SPPersonCenterHeaderView.h
//  HYSmartPlus
//
//  Created by information on 2018/5/14.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPPersonCenterHeaderView : UIView

@property (nonatomic, copy) dispatch_block_t headImageBlock;

@property (nonatomic, copy) dispatch_block_t certificateBlock;

+ (instancetype)headerView;

- (void)setData;

- (void)setState:(NSInteger)state;

@end
