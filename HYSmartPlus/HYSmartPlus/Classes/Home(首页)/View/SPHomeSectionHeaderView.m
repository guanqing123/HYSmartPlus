//
//  SPHomeSectionHeaderView.m
//  HYSmartPlus
//
//  Created by information on 2018/6/12.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPHomeSectionHeaderView.h"

@interface SPHomeSectionHeaderView()

- (IBAction)moreButtonClick;

@end

@implementation SPHomeSectionHeaderView

+ (instancetype)sectionHeaderView {
    return [[[NSBundle mainBundle] loadNibNamed:@"SPHomeSectionHeaderView" owner:nil options:nil] lastObject];
}

- (IBAction)moreButtonClick {
    !_moreButtonClickBlock ? : _moreButtonClickBlock();
}
@end
