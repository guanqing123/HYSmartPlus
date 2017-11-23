//
//  SPBrandSortHeadView.m
//  HYSmartPlus
//
//  Created by information on 2017/11/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPBrandSortHeadView.h"

/** model */
#import "SPClassMainItem.h"

@interface SPBrandSortHeadView()

/** 头部标题Label */
@property (nonatomic, weak) UILabel  *headLabel;

@end

@implementation SPBrandSortHeadView

#pragma mark - intial
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI {
    UILabel *headLabel = [[UILabel alloc] init];
    headLabel.font = PFR13Font;
    headLabel.textColor = [UIColor darkGrayColor];
    [self addSubview:headLabel];
    self.headLabel = headLabel;
    
    self.headLabel.frame = CGRectMake(SPMargin, 0, self.dc_width, self.dc_height);
}

#pragma mark - setter getter methods
- (void)setClassMainItem:(SPClassMainItem *)classMainItem {
    _classMainItem = classMainItem;
    _headLabel.text = classMainItem.title;
}

@end
