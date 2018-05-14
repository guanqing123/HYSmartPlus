//
//  SPMyCenterHeaderView.m
//  HYSmartPlus
//
//  Created by information on 2018/3/9.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPMyCenterHeaderView.h"
#import "SPAccountTool.h"
#import "SPLoginResult.h"

@interface SPMyCenterHeaderView()
@property (weak, nonatomic) IBOutlet UIButton *myIconBtn;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;
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

- (void)setData {
    UIImage *image = [UIImage imageWithContentsOfFile:SPHeadImagePath];
    if (image) {
        [self.myIconBtn setImage:image forState:UIControlStateNormal];
    }else{
        [self.myIconBtn setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
    }
    
    self.telephoneLabel.text = [SPAccountTool loginResult].userbase.phone;
}

@end
