//
//  SPTopLineFootView.m
//  HYSmartPlus
//
//  Created by information on 2017/11/21.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPTopLineFootView.h"
#import "SPNumericalScrollView.h"

@interface SPTopLineFootView()

/** 滚动 */
@property (nonatomic, weak) SPNumericalScrollView *numericalScrollView;
/** 底部 */
@property (nonatomic, weak) UIView *bottomLineView;

@end

@implementation SPTopLineFootView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setUpUI];
        
        [self setUpBase];
    }
    return self;
}

- (void)setUpUI {
    NSArray *titles  = @[@"每日签到领取积分~",
                        @"鸿雁安家值得信赖~",
                        @"系统持续升级中~"];
    NSArray *buttons = @[@"签到",
                         @"honyar",
                         @"点赞"];
    /** 初始化 */
    SPNumericalScrollView *numericalScrollView = [[SPNumericalScrollView alloc] initWithFrame:CGRectMake(0, 0, self.dc_width, self.dc_height) andImage:@"shouye_img_toutiao" andDataTArray:titles withDataIArray:buttons];
    [self addSubview:numericalScrollView];
    self.numericalScrollView = numericalScrollView;
    
    /** 开始循环 */
    [numericalScrollView startTimer];
    
    UIView *bottomLineView = [[UIView alloc] init];
    bottomLineView.frame = CGRectMake(0, self.dc_height - 8, ScreenW, 8);
    bottomLineView.backgroundColor = SPBGColor;
    [self addSubview:bottomLineView];
    self.bottomLineView = bottomLineView;
    
}

- (void)setUpBase {
    self.backgroundColor = [UIColor whiteColor];
}

@end
