//
//  SPCommentViewController.m
//  HYSmartPlus
//
//  Created by information on 2019/10/25.
//  Copyright © 2019 hongyan. All rights reserved.
//

#import "SPCommentViewController.h"
#import "SPConstructionTool.h"

@interface SPCommentViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)modifyComment:(UIButton *)sender;
@end

@implementation SPCommentViewController

- (instancetype)initWithDropower:(SPDropower *)dropower {
    if (self = [super init]) {
        self.dropower = dropower;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"备注修改";
    self.textView.text = self.dropower.comment;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGRect tempRect = self.contentView.frame;
    tempRect.origin.y = SPTopNavH;
    self.contentView.frame = tempRect;
}

- (IBAction)modifyComment:(UIButton *)sender {
    [self.textView endEditing:YES];
    WEAKSELF
    [MBProgressHUD showWaitMessage:@"修改中..." toView:self.view];
    NSDictionary *params = [NSDictionary dictionaryWithObjects:@[self.dropower.idNum,self.textView.text] forKeys:@[@"id", @"comment"]];
    [SPConstructionTool modifyComment:params success:^(SPCommonResult *result) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([result.code isEqualToString:@"00000"]) {
            [MBProgressHUD showSuccess:@"保存成功" toView:self.view];
            if ([weakSelf.delegate respondsToSelector:@selector(commentViewController:)]) {
                [weakSelf.delegate commentViewController:weakSelf];
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        } else {
            [MBProgressHUD showError:result.msg toView:self.view];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:@"网络异常" toView:self.view];
    }];
}
@end
