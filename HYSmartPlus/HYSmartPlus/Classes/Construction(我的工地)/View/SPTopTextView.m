//
//  SPMiddleTextView.m
//  HYSmartPlus
//
//  Created by information on 2018/5/7.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPTopTextView.h"

@interface SPTopTextView()
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userTel;
@property (weak, nonatomic) IBOutlet UITextView *detailAddress;
@property (weak, nonatomic) IBOutlet UITextView *comment;

@end

@implementation SPTopTextView

+ (instancetype)topTextView {
    return [[[NSBundle mainBundle] loadNibNamed:@"SPTopTextView" owner:nil options:nil] lastObject];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    //圆角处理
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = frame;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)setDropower:(SPDropower *)dropower {
    _dropower = dropower;
    self.idLabel.text = dropower.idNum;
    self.userName.text = dropower.userName;
    self.userTel.text = dropower.userTel;
    self.detailAddress.text = dropower.address;
    self.comment.text = dropower.comment;
}

@end
