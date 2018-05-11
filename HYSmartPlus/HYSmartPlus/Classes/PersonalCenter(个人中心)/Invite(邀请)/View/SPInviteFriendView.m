//
//  SPInviteFriendView.m
//  HYSmartPlus
//
//  Created by information on 2018/4/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPInviteFriendView.h"
#import "SPAccountTool.h"
#import "SPLoginResult.h"
#import "LBXScanNative.h"

@interface SPInviteFriendView()
@property (weak, nonatomic) IBOutlet UIImageView *prentView;

- (IBAction)share;
@end

@implementation SPInviteFriendView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://sge.cn/erp/app/register/%@",[SPAccountTool loginResult].userbase.uid];
    UIImage *image = [LBXScanNative createQRWithString:urlStr QRSize:self.prentView.bounds.size];
    [self.prentView setImage:image];
}

+ (instancetype)inviteView {
    return [[[NSBundle mainBundle] loadNibNamed:@"SPInviteView" owner:self options:nil] lastObject];
}

//  分享
- (IBAction)share {
    if ([self.delegate respondsToSelector:@selector(inviteFriendViewDidShare:)]) {
        [self.delegate inviteFriendViewDidShare:self];
    }
}
@end
