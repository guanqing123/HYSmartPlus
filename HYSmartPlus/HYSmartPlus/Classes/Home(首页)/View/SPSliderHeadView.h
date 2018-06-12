//
//  SPSliderHeadView.h
//  HYSmartPlus
//
//  Created by information on 2018/6/11.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPHomePage;

typedef void(^imageClick) (SPHomePage *homePage);

@interface SPSliderHeadView : UIView

@property (nonatomic, copy) imageClick imageClickBlock;

+ (instancetype)headerView;

@end
