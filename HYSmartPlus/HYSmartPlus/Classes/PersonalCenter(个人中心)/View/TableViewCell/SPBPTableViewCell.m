//
//  SPBPTableViewCell.m
//  HYSmartPlus
//
//  Created by information on 2018/3/14.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPBPTableViewCell.h"

@interface SPBPTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *bpIntegralLabel;

@end

@implementation SPBPTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setResult:(SPPersonScoreResult *)result {
    _result = result;
    for (SPCurrentGradeInfo *info in result.list) {
        if (![info.khdm isEqualToString:@"00000000"]) {
            self.bpIntegralLabel.text = [NSString stringWithFormat:@"%d",info.currentIntegral];
            break;
        }
    }
}

@end
