//
//  SPLoadingView.m
//  HYSmartPlus
//
//  Created by information on 2018/6/13.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPLoadingView.h"
#import "DGActivityIndicatorView.h"

@interface SPLoadingView()

/* 指示器 */
@property (nonatomic, strong)  DGActivityIndicatorView *indicatorView;

/* 刷新按钮 */
@property (nonatomic, strong)  UIView *refreshView;

@end

@implementation SPLoadingView

+ (instancetype)loadingView {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.alpha = 0;
        // 添加指示器
        [self addSubview:self.indicatorView];
        
        // 添加刷新按钮
        [self addSubview:self.refreshView];
    }
    return self;
}

- (DGActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeLineScalePulseOut tintColor:[UIColor lightGrayColor] size:30.0f];
    }
    return _indicatorView;
}

- (UIView *)refreshView {
    if (!_refreshView) {
        _refreshView = [[UIView alloc] init];
        _refreshView.alpha = 0;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"世界上最遥远的距离就是断网";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = RGB(85, 85, 85);
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
    [self.refreshView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsZero);
    }];
}

- (void)loading {
    self.alpha = 1;
    self.refreshView.alpha = 0;
    [self.indicatorView startAnimating];
}

- (void)success {
    self.alpha = 0;
    self.refreshView.alpha = 0;
    [self.indicatorView stopAnimating];
}

- (void)failure {
    self.alpha = 1;
    self.refreshView.alpha = 1;
    [self.indicatorView stopAnimating];
}

- (void)refreshBtnClick {
    !_refreshBlock ? : _refreshBlock();
}

@end
