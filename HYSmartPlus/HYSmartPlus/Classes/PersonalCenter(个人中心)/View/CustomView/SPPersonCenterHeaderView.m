//
//  SPPersonCenterHeaderView.m
//  HYSmartPlus
//
//  Created by information on 2018/5/14.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPPersonCenterHeaderView.h"
#import "SPAccountTool.h"
#import "SPLoginResult.h"

@interface SPPersonCenterHeaderView()
@property (weak, nonatomic) IBOutlet UIButton *headImageBtn;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *certificateBtn;
- (IBAction)certificate;

- (IBAction)headImageClick;

@end

@implementation SPPersonCenterHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [SPSpeedy dc_setUpBezierPathCircularLayerWith:self.headImageBtn size:CGSizeMake(self.headImageBtn.dc_width * 0.5, self.headImageBtn.dc_height * 0.5)];
    [SPSpeedy dc_chageControlCircularWith:_certificateBtn AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[UIColor clearColor] canMasksToBounds:YES];
}

+ (instancetype)headerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"SPPersonCenterHeaderView" owner:nil options:nil] lastObject];
}

- (void)setData {
    UIImage *image = [UIImage imageWithContentsOfFile:SPHeadImagePath];
    if (image) {
        [self.headImageBtn setImage:image forState:UIControlStateNormal];
    }else{
        [self.headImageBtn setImage:[UIImage imageNamed:@"icon"] forState:UIControlStateNormal];
    }
    self.telephoneLabel.text = [SPAccountTool loginResult].userbase.phone;
}

- (void)setState:(NSInteger)state {
    switch (state) {
        case 0: {
            [self.certificateBtn setTitle:@"未认证" forState:UIControlStateNormal];
            break;
        }
        case 1: {
            [self.certificateBtn setTitle:@"等待审核" forState:UIControlStateNormal];
            break;
        }
        case 2: {
            [self.certificateBtn setTitle:@"已认证" forState:UIControlStateNormal];
            break;
        }
        case 3: {
            [self.certificateBtn setTitle:@"认证被拒" forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }
}

- (IBAction)headImageClick {
    !_headImageBlock ? : _headImageBlock();
}

- (IBAction)certificate {
    !_certificateBlock ? : _certificateBlock();
}
@end
