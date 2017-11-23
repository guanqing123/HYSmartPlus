//
//  SPClassCategoryCell.m
//  HYSmartPlus
//
//  Created by information on 2017/11/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPClassCategoryCell.h"

/** model */
#import "SPClassGoodsItem.h"

@interface SPClassCategoryCell()

/** 标题 */
@property (nonatomic, weak) UILabel  *titleLabel;
/** 指示View */
@property (nonatomic, weak) UIView  *indicatorView;

@end

@implementation SPClassCategoryCell

#pragma mark - intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = PFR15Font;
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.hidden = NO;
    indicatorView.backgroundColor = [UIColor redColor];
    [self addSubview:indicatorView];
    self.indicatorView = indicatorView;
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
    
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(self);
        make.width.mas_equalTo(5);
    }];
}

#pragma mark - cell 点击
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.indicatorView.hidden = NO;
        self.titleLabel.textColor = [UIColor redColor];
        self.backgroundColor = [UIColor whiteColor];
    }else{
        self.indicatorView.hidden = YES;
        self.titleLabel.textColor = [UIColor blackColor];
        self.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark - setter getter methods
- (void)setTitleItem:(SPClassGoodsItem *)titleItem {
    _titleItem = titleItem;
    self.titleLabel.text = titleItem.title;
}

@end
