//
//  SPNumericalScrollView.m
//  HYSmartPlus
//
//  Created by information on 2017/11/21.
//  Copyright © 2017年 hongyan. All rights reserved.
//
#define BtnTag 1000

#import "SPNumericalScrollView.h"

@interface SPNumericalScrollView()

/** 图片 */
@property (nonatomic, strong)  UIImageView *imageView;

@property (nonatomic, strong)  NSMutableArray *buttonArray;

@end

@implementation SPNumericalScrollView

- (instancetype)initWithFrame:(CGRect)frame andImage:(NSString *)imageName andDataTArray:(NSArray *)titlesArray withDataIArray:(NSArray *)imagesTitlesArray {
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.image = [UIImage imageNamed:imageName];
        self.imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:self.imageView];
        
        /** 图片约束 */
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(60, 30));
        }];
        
        /** 创建Button */
        if (titlesArray.count > 0) {
            for (int i = 0; i < titlesArray.count; i++) {
                /** 文字button */
                UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                titleBtn.tag = BtnTag + 1;
                [titleBtn setTitle:titlesArray[i] forState:UIControlStateNormal];
                [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [titleBtn addTarget:self action:@selector(titleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
                titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                titleBtn.titleLabel.font = PFR13Font;
                /** 图片button */
                UIButton *imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [imageBtn setTitle:imagesTitlesArray[i] forState:UIControlStateNormal];
                imageBtn.backgroundColor = [UIColor redColor];
                imageBtn.titleLabel.font = PFR10Font;
                [titleBtn addSubview:imageBtn];
                
                if (i != 0) {
                    CATransform3D trans = CATransform3DIdentity;
                    trans = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
                    trans = CATransform3DTranslate(trans, 0, -self.dc_height/2, -self.dc_height/2);
                    titleBtn.layer.transform = trans;
                }else{
                    CATransform3D trans = CATransform3DIdentity;
                    trans = CATransform3DMakeRotation(0, 1, 0, 0);
                    trans = CATransform3DTranslate(trans, 0, 0, -self.dc_height/2);
                    titleBtn.layer.transform = trans;
                }
                
                [self addSubview:titleBtn];
                [self.buttonArray addObject:titleBtn];
                
                /** 约束 */
                [imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    [make.left.mas_equalTo(self.imageView.mas_right) setOffset:SPMargin];
                    make.centerY.mas_equalTo(self);
                    make.size.mas_equalTo(CGSizeMake(45, 15));
                }];
                
                [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    [make.left.mas_equalTo(imageBtn.mas_right) setOffset:SPMargin];
                    make.centerY.mas_equalTo(self);
                    make.right.mas_equalTo(self);
                    make.height.mas_equalTo(self).multipliedBy(0.8);
                }];
            }
        }
    }
    return self;
}

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

#pragma mark - 开始
- (void)startTimer {
    if (!self.interval) {
        self.interval = 5;
    }
    NSTimer *timer = [NSTimer timerWithTimeInterval:self.interval target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

#pragma mark - 滚动
- (void)timerRun {
    if (self.buttonArray.count > 1) {
        [UIView animateWithDuration:self.interval/self.interval animations:^{
            
            UIButton *f_button = self.buttonArray[0];
            CATransform3D f_trans = CATransform3DIdentity;
            f_trans = CATransform3DMakeRotation(-M_PI_2, 1, 0, 0);
            f_trans = CATransform3DTranslate(f_trans, 0, self.dc_height/2, -self.dc_height/2);
            f_button.layer.transform = f_trans;
            
            UIButton *s_button = self.buttonArray[1];
            CATransform3D s_trans = CATransform3DIdentity;
            s_trans = CATransform3DMakeRotation(0, 1, 0, 0);
            s_trans = CATransform3DTranslate(s_trans, 0, 0, 0);
            s_button.layer.transform = s_trans;
            
        } completion:^(BOOL finished) {
            
            if (finished == YES) {
                UIButton *button = self.buttonArray[0];
                CATransform3D trans = CATransform3DIdentity;
                trans = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
                trans = CATransform3DTranslate(trans, 0, -self.dc_height/2, -self.dc_height/2);
                button.layer.transform = trans;
                
                [self.buttonArray addObject:button];
                [self.buttonArray removeObjectAtIndex:0];
            }
            
        }];
    }
}

#pragma mark - 点击事件
- (void)titleBtnAction:(UIButton *)sender {
    NSInteger tag = sender.tag - BtnTag;
    if ([self.delegate respondsToSelector:@selector(numericalScrollView:didSelectNoticeActionAtIndex:)]) {
        [self.delegate numericalScrollView:self didSelectNoticeActionAtIndex:tag];
    }
}

@end
