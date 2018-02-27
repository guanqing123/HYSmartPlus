//
//  SPCountDownHeadView.m
//  HYSmartPlus
//
//  Created by information on 2017/11/21.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPCountDownHeadView.h"
#import "SPZuoWenRightButton.h"

@interface SPCountDownHeadView()

/** 红色块 */
@property (nonatomic, weak) UIView  *redView;
/** 时间 */
@property (nonatomic, weak) UILabel  *timeLabel;
/* 倒计时 */
@property (nonatomic, weak) UILabel *countDownLabel;
/** 好货秒抢 */
@property (nonatomic, weak) SPZuoWenRightButton  *quickButton;

@end

@implementation SPCountDownHeadView

#pragma mark - intial
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [self addSubview:redView];
    self.redView = redView;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"6点场";
    timeLabel.font = PFR16Font;
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *countDownLabel = [[UILabel alloc] init];
    countDownLabel.textColor = [UIColor redColor];
    countDownLabel.text = @"05 : 58 : 33";
    countDownLabel.font = PFR14Font;
    [self addSubview:countDownLabel];
    self.countDownLabel = countDownLabel;
    
    SPZuoWenRightButton *quickButton = [SPZuoWenRightButton buttonWithType:UIButtonTypeCustom];
    quickButton.titleLabel.font = PFR12Font;
    [quickButton setImage:[UIImage imageNamed:@"shouye_icon_jiantou"] forState:UIControlStateNormal];
    [quickButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [quickButton setTitle:@"好货秒抢" forState:UIControlStateNormal];
    [self addSubview:quickButton];
    self.quickButton = quickButton;
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.redView.frame = CGRectMake(0, 10, 8, 20);
    self.timeLabel.frame = CGRectMake(20, 0, 60, self.dc_height);
    self.countDownLabel.frame = CGRectMake(CGRectGetMaxX(self.timeLabel.frame), 0, 100, self.dc_height);
    self.quickButton.frame = CGRectMake(self.dc_width - 70, 0, 70, self.dc_height);
}

@end
