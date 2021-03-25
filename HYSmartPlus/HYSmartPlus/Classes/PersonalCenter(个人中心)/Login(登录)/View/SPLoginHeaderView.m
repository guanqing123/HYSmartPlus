//
//  SPLoginHeaderView.m
//  HYSmartPlus
//
//  Created by information on 2018/2/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPLoginHeaderView.h"

@interface SPLoginHeaderView()
@property (nonatomic, weak) UIImageView  *titleView;
@end

@implementation SPLoginHeaderView

+ (instancetype)headerView {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *titleView = [[UIImageView alloc] init];
        titleView.image = [UIImage imageNamed:@"sign_in_logo"];
        _titleView = titleView;
        [self addSubview:titleView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
        
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.centerX.equalTo(self.mas_centerX);
    }];
}

@end
