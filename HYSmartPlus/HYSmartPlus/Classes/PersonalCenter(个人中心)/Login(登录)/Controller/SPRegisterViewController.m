//
//  SPRegisterViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/3/6.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPRegisterViewController.h"
#import "SPRegisterParam.h"

@interface SPRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *telphone;
@property (weak, nonatomic) IBOutlet UITextField *fisrtPwd;
@property (weak, nonatomic) IBOutlet UITextField *secondPwd;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UITextField *invite;
- (IBAction)contentChange;
- (IBAction)register;

@property (nonatomic, strong)  SPRegisterParam *registerParam;
@end

@implementation SPRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupBgAndNav];
}

- (void)setupBgAndNav {
    // 0.设置标题
    self.title = @"注册";
    // 1.背景
    self.view.backgroundColor = [UIColor whiteColor];
    // 2.导航栏
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"30"] withHighLightedImage:[UIImage imageNamed:@"30"] target:self action:@selector(back)];
}

#pragma mark - 后退
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (SPRegisterParam *)registerParam {
    if (!_registerParam) {
        _registerParam = [[SPRegisterParam alloc] init];
    }
    return _registerParam;
}

- (IBAction)contentChange {
    self.registerParam.num = self.telphone.text;
    self.registerParam.pwd = self.secondPwd.text;
    self.registerParam.code = self.code.text;
    self.registerParam.inviter = self.invite.text;
}

- (IBAction)register {
    if(![SPSpeedy dc_isTelephone:self.telphone.text]) {
        [MBProgressHUD showMessage:@"请输入正确的手机号" toView:self.view];
        return;
    }
    if(![self.fisrtPwd.text isEqualToString:self.secondPwd.text]) {
        [MBProgressHUD showMessage:@"两次输入密码不一致" toView:self.view];
        return;
    }
}
@end
