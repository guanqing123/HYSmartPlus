//
//  SPProblemTableViewCell.m
//  HYSmartPlus
//
//  Created by information on 2018/3/14.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPProblemTableViewCell.h"
#import "SPNumberScrollView.h"

@interface SPProblemTableViewCell()
@property (nonatomic, strong)  UIView *totalView;
@property (nonatomic, strong) UILabel  *titleLabel;
@property (nonatomic, strong) SPNumberScrollView  *numberScrollView;
@property (nonatomic, strong)  UIButton *moreProblemBtn;

@end

@implementation SPProblemTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"SPProblemTableViewCellID";
    SPProblemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SPProblemTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        // 0.添加父
        [self.contentView addSubview:self.totalView];
        // 1.标题
        [self.totalView addSubview:self.titleLabel];
        // 2.滚动
        [self.totalView addSubview:self.numberScrollView];
        // 3.按钮
        [self.totalView addSubview:self.moreProblemBtn];
    }
    return self;
}

- (UIView *)totalView {
    if (!_totalView) {
        _totalView = [[UIView alloc] init];
        _totalView.backgroundColor = [UIColor whiteColor];
    }
    return _totalView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"常见问题:";
        _titleLabel.font = PFR12Font;
    }
    return _titleLabel;
}

- (SPNumberScrollView *)numberScrollView {
    if (!_numberScrollView) {
        _numberScrollView = [SPNumberScrollView scrollView];
    }
    return _numberScrollView;
}

- (UIButton *)moreProblemBtn {
    if (!_moreProblemBtn) {
        _moreProblemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreProblemBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_moreProblemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _moreProblemBtn.titleLabel.font = PFR12Font;
    }
    return _moreProblemBtn;
}

- (void)setScrollArray:(NSArray *)scrollArray {
    _scrollArray = scrollArray;
    [self.numberScrollView setScrollArray:scrollArray];
    [self.numberScrollView startTimer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.totalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self).offset(-SPMargin);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.totalView).offset(SPMargin);
        make.centerY.equalTo(self.totalView.mas_centerY);
        make.width.mas_equalTo(60);
    }];
    
    [self.moreProblemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.totalView).offset(-SPMargin);
        make.centerY.equalTo(self.totalView.mas_centerY);
        make.width.mas_equalTo(80);
    }];
    
    [self.numberScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(SPMargin);
        make.right.equalTo(self.moreProblemBtn.mas_left).offset(-SPMargin);
        make.centerY.equalTo(self.totalView.mas_centerY);
    }];
}

@end
