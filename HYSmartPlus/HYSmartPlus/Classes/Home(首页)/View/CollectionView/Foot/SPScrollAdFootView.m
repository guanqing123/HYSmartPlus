//
//  SPScrollAdFootView.m
//  HYSmartPlus
//
//  Created by information on 2017/11/22.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPScrollAdFootView.h"

/** vendor */
#import "SDCycleScrollView.h"

@interface SPScrollAdFootView()<SDCycleScrollViewDelegate>

/** 轮播图 */
@property (nonatomic, strong)  SDCycleScrollView *cycleScrollView;

@end

@implementation SPScrollAdFootView

#pragma mark - intial
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenW, self.dc_height) delegate:self placeholderImage:nil];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    _cycleScrollView.imageURLStringsGroup = @[@"http://gfs4.gomein.net.cn/T1DZAvBQbg1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1CoJvBXV_1RCvBVdK.jpg",@"http://gfs3.gomein.net.cn/T1C.EvBjJ_1RCvBVdK.jpg"];
    
    [self addSubview:_cycleScrollView];
}

#pragma mark - 点击广告跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd广告图",index);
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
