//
//  SPIntegralTableViewCell.m
//  HYSmartPlus
//
//  Created by information on 2018/3/14.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPIntegralTableViewCell.h"

@interface SPIntegralTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *gradeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentIntegralLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextIntegralLabel;
@end

@implementation SPIntegralTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}

- (void)setResult:(SPPersonScoreResult *)result {
    _result = result;
    NSNumber *current = [[NSNumber alloc] init];
    NSNumber *next = [[NSNumber alloc] init];
    for (SPCurrentGradeInfo *info in result.list) {
        NSLog(@"class = %@",NSStringFromClass([info class]));
        if ([info.khdm isEqualToString:@"00000000"]) {
            self.gradeNameLabel.text = info.gradeName;
            self.currentIntegralLabel.text = [info.currentIntegral description];
            current = info.currentIntegral;
            break;
        }
    }
    self.nextIntegralLabel.text = [result.nextGradeInfo.integral description];
    next = result.nextGradeInfo.integral;
    CGFloat scale = next == 0 ? 0 : 0.6;//[current floatValue]/[next floatValue];
    [self.progress setProgress:scale animated:YES];
}

@end
