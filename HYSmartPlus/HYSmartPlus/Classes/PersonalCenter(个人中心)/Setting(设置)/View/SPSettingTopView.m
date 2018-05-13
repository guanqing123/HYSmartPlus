//
//  SPSettingTopView.m
//  HYSmartPlus
//
//  Created by information on 2018/5/12.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPSettingTopView.h"

@implementation SPSettingTopView

+ (instancetype)topView {
    return [[[NSBundle mainBundle] loadNibNamed:@"SPSettingTopView" owner:nil options:nil] lastObject];
}

@end
