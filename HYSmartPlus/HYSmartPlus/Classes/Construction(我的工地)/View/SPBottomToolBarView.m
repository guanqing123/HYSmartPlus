//
//  SPBottomToolBarView.m
//  HYSmartPlus
//
//  Created by information on 2018/5/8.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPBottomToolBarView.h"

@interface SPBottomToolBarView()
@property (nonatomic, strong)  NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *dividers;
@end

@implementation SPBottomToolBarView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 1.设置图片
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        // 2.添加按钮
        self.cameraBtn = [self setupBtnWithTitle:@"照片" image:@"cameraBtn"];
        self.cameraBtn.tag = ToolBarButtonTypeCamera;
        self.pressureBtn = [self setupBtnWithTitle:@"试压" image:@"pressureBtn"];
        self.pressureBtn.tag = ToolBarButtonTypePressure;
        self.deleteBtn = [self setupBtnWithTitle:@"删除" image:@"deleteBtn"];
        self.deleteBtn.tag = ToolBarButtonTypeDelete;
        
        // 3.添加分割线
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}


/**
 初始化按钮

 @param title 按钮标题
 @param image 按钮图片
 @return 按钮
 */
- (UIButton *)setupBtnWithTitle:(NSString *)title image:(NSString *)image{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.adjustsImageWhenHighlighted = NO;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    // 添加按钮到数组
    [self.btns addObject:btn];
    
    return btn;
}


/**
 按钮点击事件

 @param button 按钮
 */
- (void)btnClick:(UIButton *)button {
    if([self.delegate respondsToSelector:@selector(bottomToolBar:buttonType:)]) {
        [self.delegate bottomToolBar:self buttonType:(int)button.tag];
    }
}


/**
 *  初始化分割线
 */
- (void)setupDivider{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    CGRect tempRound = (CGRect){CGPointZero,frame.size};
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:tempRound byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = tempRound;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 1.设置按钮的frame
    int dividerCount = (int)self.dividers.count; //分割线的个数
    CGFloat dividerW = 2; // 分割线的宽度
    int btnCount = (int)self.btns.count;
    CGFloat btnW = (self.frame.size.width - dividerCount * dividerW) / btnCount;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnY = 0;
    for (int i = 0; i < btnCount; i++) {
        UIButton *btn = self.btns[i];
        
        // 设置frame
        CGFloat btnX = i * (btnW + dividerW);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    // 2.设置分割线的frame
    CGFloat dividerH = btnH;
    CGFloat dividerY = 0;
    for (int j = 0; j < dividerCount; j++) {
        UIImageView *divider = self.dividers[j];
        
        //设置frame
        UIButton *btn = self.btns[j];
        CGFloat dividerX = CGRectGetMaxX(btn.frame);
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
}

#pragma mark - lazyLoad
- (NSMutableArray *)btns{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers{
    if (_dividers == nil) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

@end
