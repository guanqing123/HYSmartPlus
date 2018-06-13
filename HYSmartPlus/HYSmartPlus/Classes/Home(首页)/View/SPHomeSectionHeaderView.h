//
//  SPHomeSectionHeaderView.h
//  HYSmartPlus
//
//  Created by information on 2018/6/12.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPHomeSectionHeaderView : UIView

@property (nonatomic, copy) dispatch_block_t moreButtonClickBlock;

+ (instancetype)sectionHeaderView;

@end
