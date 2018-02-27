//
//  SPGoodsHandheldCell.m
//  HYSmartPlus
//
//  Created by information on 2017/11/22.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPGoodsHandheldCell.h"

/** vendor */
#import "UIImageView+WebCache.h"

@interface SPGoodsHandheldCell()

/** 图片 */
@property (nonatomic, weak) UIImageView  *handheldImageView;

@end

@implementation SPGoodsHandheldCell

#pragma mark - intial
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    UIImageView *handheldImageView = [[UIImageView alloc] init];
    handheldImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:handheldImageView];
    self.handheldImageView = handheldImageView;
}

#pragma mark - layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.handheldImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark - setter getter methods
- (void)setHandheldImage:(NSString *)handheldImage {
    _handheldImage = handheldImage;
    [self.handheldImageView sd_setImageWithURL:[NSURL URLWithString:handheldImage]];
}

@end
