//
//  SPMyCenterHeaderView.m
//  HYSmartPlus
//
//  Created by information on 2018/3/9.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPMyCenterHeaderView.h"

@interface SPMyCenterHeaderView()
@property (weak, nonatomic) IBOutlet UIButton *myIconBtn;
@end

@implementation SPMyCenterHeaderView

#pragma mark - initialize
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [SPSpeedy dc_chageControlCircularWith:self.myIconBtn AndSetCornerRadius:self.myIconBtn.dc_width * 0.5 SetBorderWidth:1 SetBorderColor:[UIColor whiteColor] canMasksToBounds:YES];
}


+ (instancetype)headerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"SPMyCenterHeaderView" owner:nil options:nil] lastObject];
}

@end
