//
//  SPSlideshowHeadView.m
//  HYSmartPlus
//
//  Created by information on 2017/9/12.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPSlideshowHeadView.h"
#import "DGActivityIndicatorView.h"
#import "SPHomeTool.h"
#import <SDCycleScrollView.h>

@interface SPSlideshowHeadView()<SDCycleScrollViewDelegate>

/* 指示器 */
@property (nonatomic, strong)  DGActivityIndicatorView *indicatorView;
/* 轮播图 */
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
/* 刷新页面 */
@property (nonatomic, strong)  UIView *refreshView;

@end

@implementation SPSlideshowHeadView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGB(230, 230, 230);
        // 1.指示器
        [self addSubview:self.indicatorView];
        // 2.滚动页
        [self addSubview:self.cycleScrollView];
        // 3.添加刷新按钮
        [self addSubview:self.refreshView];
        // 4.加载数据
        [self loadData];
    }
    return self;
}

- (DGActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeLineScalePulseOut tintColor:[UIColor lightGrayColor] size:30.0f];
        _indicatorView.alpha = 0;
    }
    return _indicatorView;
}

- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"slide_backgroud_icon"]];
        _cycleScrollView.alpha = 0;
        _cycleScrollView.delegate = self;
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        _cycleScrollView.autoScrollTimeInterval = 3.0;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    }
    return _cycleScrollView;
}

- (UIView *)refreshView {
    if (!_refreshView) {
        _refreshView = [[UIView alloc] init];
        _refreshView.alpha = 0;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"世界上最遥远的距离就是断网";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = PFR12Font;
        [_refreshView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_refreshView);
            make.bottom.mas_equalTo(_refreshView.mas_centerY).offset(-SPMargin/2);
            make.width.equalTo(_refreshView);
            make.height.mas_equalTo(16);
        }];
        
        UIButton *refreshBtn = [[UIButton alloc] init];
        [refreshBtn setTitle:@"刷新" forState:UIControlStateNormal];
        refreshBtn.titleLabel.font = PFR10Font;
        [refreshBtn setImage:[UIImage imageNamed:@"slide_refresh_icon"] forState:UIControlStateNormal];
        refreshBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        refreshBtn.backgroundColor = [UIColor lightGrayColor];
        refreshBtn.layer.cornerRadius = 10;
        [refreshBtn addTarget:self action:@selector(refreshBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_refreshView addSubview:refreshBtn];
        [refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 20));
            make.centerX.equalTo(_refreshView);
            make.top.mas_equalTo(_refreshView.mas_centerY).offset(SPMargin/2);
        }];
    }
    return _refreshView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsZero);
    }];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsZero);
    }];
    [self.refreshView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsZero);
    }];
}

- (void)loadData {
    self.refreshView.alpha = 0;
    self.cycleScrollView.alpha = 0;
     __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:1.0 animations:^{
        weakSelf.indicatorView.alpha = 1;
        [weakSelf.indicatorView startAnimating];
    }];
    SPSliderParam *param = [SPSliderParam param:slider];
    [SPHomeTool homeSliderWithParam:param success:^(NSArray *sliderResult) {
        [weakSelf.indicatorView stopAnimating];
        weakSelf.indicatorView.alpha = 0;
        NSMutableArray *resultArray = [NSMutableArray array];
        [sliderResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SPSliderResult *result = obj;
            [resultArray addObject:result.path];
        }];
        weakSelf.cycleScrollView.imageURLStringsGroup = resultArray;
        [UIView animateWithDuration:2.0 animations:^{
            weakSelf.cycleScrollView.alpha = 1;
        }];
    } failure:^(NSError *error) {
        [weakSelf.indicatorView stopAnimating];
        weakSelf.indicatorView.alpha = 0;
        [UIView animateWithDuration:1.0 animations:^{
            weakSelf.refreshView.alpha = 1;
        }];
    }];
}

- (void)refreshBtnClick {
    [self loadData];
}

@end
