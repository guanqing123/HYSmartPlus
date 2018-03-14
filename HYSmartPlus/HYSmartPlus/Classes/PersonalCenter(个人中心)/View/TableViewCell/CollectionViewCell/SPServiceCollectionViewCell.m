//
//  SPServiceCollectionViewCell.m
//  HYSmartPlus
//
//  Created by information on 2018/3/14.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPServiceCollectionViewCell.h"
#import "SPServiceItem.h"

@interface SPServiceCollectionViewCell()
/** imageView */
@property (nonatomic, weak) UIImageView  *imageView;
/** titleLabel */
@property (nonatomic, weak) UILabel  *titleLabel;
@end

@implementation SPServiceCollectionViewCell

#pragma mark - initial
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = PFR12Font;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(SPMargin);
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.centerX.mas_equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self.imageView.mas_bottom)setOffset:5];
    }];
}

#pragma mark - Setter Getter Methods
- (void)setServiceItem:(SPServiceItem *)serviceItem {
    _serviceItem = serviceItem;
    /** 图片 */
    [self.imageView setImage:[UIImage imageNamed:serviceItem.iconImage]];
    /** 标题 */
    self.titleLabel.text = serviceItem.gridTitle;
}
@end
