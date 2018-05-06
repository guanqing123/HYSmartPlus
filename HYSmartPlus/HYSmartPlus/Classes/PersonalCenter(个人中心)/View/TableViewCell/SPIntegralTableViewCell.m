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
@property (weak, nonatomic) IBOutlet UILabel *upgradeIntegralLabel;
@end

@implementation SPIntegralTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}

- (void)setResult:(SPPersonScoreResult *)result {
    _result = result;
    NSInteger current = 0;
    NSInteger next = 0;
    for (SPCurrentGradeInfo *info in result.list) {
        if ([info.khdm isEqualToString:@"00000000"]) {
            self.gradeNameLabel.text = info.gradeName;
            self.currentIntegralLabel.text = [NSString stringWithFormat:@"%d",info.currentIntegral];
            current = info.currentIntegral;
            break;
        }
    }
    self.nextIntegralLabel.text = [NSString stringWithFormat:@"%d",result.nextGradeInfo.integral];
    next = result.nextGradeInfo.integral;
    CGFloat scale = next == 0 ? 0 : (float) current / next;
    self.upgradeIntegralLabel.text = [NSString stringWithFormat:@"%d",next - current];
    [self.progress setProgress:scale animated:YES];
}

@end
