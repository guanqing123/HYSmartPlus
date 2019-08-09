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
- (IBAction)bpBtnClick;
@property (nonatomic, weak) NSString  *khdm;

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
            self.bpIntegralLabel.text = [NSString stringWithFormat:@"%ld",info.currentIntegral];
            self.khdm = info.khdm;
            break;
        }
    }
}

- (IBAction)bpBtnClick {
    if ([self.delegate respondsToSelector:@selector(bpTableViewCell:bpBtnClick:)]) {
        [self.delegate bpTableViewCell:self bpBtnClick:self.khdm];
    }
}
@end
