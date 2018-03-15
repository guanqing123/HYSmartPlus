//
//  SPIntegralTableViewCell.m
//  HYSmartPlus
//
//  Created by information on 2018/3/14.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPIntegralTableViewCell.h"
#import "HXCharts.h"

@interface SPIntegralTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (nonatomic, strong)  HXGaugeChart *gauge;

@end

@implementation SPIntegralTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = RGB(235, 103, 97);
    [self.contentView addSubview:self.gauge];
}

- (HXGaugeChart *)gauge {
    if (!_gauge) {
        CGFloat width = ScreenW;
        CGFloat height = ScreenW * 0.7;
        CGFloat chartWidth = ScreenW * 0.7;
        CGFloat x = (width - chartWidth) / 2;
        CGFloat y = (height - chartWidth) / 2;
        _gauge = [[HXGaugeChart alloc] initWithFrame:CGRectMake(x, y+90, chartWidth, chartWidth) withMaxValue:300 value:225];
        _gauge.valueTitle = @"225";
        _gauge.colorArray = @[[self colorWithHexString:@"#33d24e" alpha:1],
                             [self colorWithHexString:@"#f8e71c" alpha:1],
                             [self colorWithHexString:@"#ff9500" alpha:1],
                             [self colorWithHexString:@"#ff4e65" alpha:1]];
        _gauge.locations = @[@0.15,@0.4,@0.65,@0.8];
        _gauge.markLabelCount = 5;
    }
    return _gauge;
}

#pragma mark 设置16进制颜色
- (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
