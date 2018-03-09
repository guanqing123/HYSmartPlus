//
//  SPRegisterViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/3/6.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPRegisterViewController.h"
#import "SPUserAgreementViewController.h"
#import "SPCodeParam.h"
#import "SPRegisterParam.h"
#import "SPLoginTool.h"
#import "SPAccountTool.h"
#import "SPSmartPlusTool.h"

@interface SPRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *telephone;
@property (weak, nonatomic) IBOutlet UITextField *fisrtPwd;
@property (weak, nonatomic) IBOutlet UITextField *secondPwd;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UIButton *countDownBtn;
@property (weak, nonatomic) IBOutlet UITextField *invite;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
- (IBAction)obtainVerifyCode:(UIButton *)sender;
- (IBAction)contentChange;
- (IBAction)regist;
- (IBAction)doSelect:(UIButton *)sender;
- (IBAction)seeUserAgreement;

@property (nonatomic, strong)  SPRegisterParam *registerParam;
@property (nonatomic, strong)  SPCodeParam *codeParam;
@property (nonatomic, assign)  BOOL isSelect;
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
    // 3.默认同意协议
    self.isSelect = YES;
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
#pragma mark - lazyLoad
- (SPRegisterParam *)registerParam {
    if (!_registerParam) {
        _registerParam = [SPRegisterParam param:APP00001];
    }
    return _registerParam;
}

- (SPCodeParam *)codeParam {
    if (!_codeParam) {
        _codeParam = [SPCodeParam param:APP00000];
        _codeParam.ztemplate = SPRegisterTemplate;
    }
    return _codeParam;
}

#pragma mark - Action
- (IBAction)obtainVerifyCode:(UIButton *)sender {
    if (![SPSpeedy dc_isTelephone:self.telephone.text]) {
        [MBProgressHUD showMessage:@"请输入正确的手机号码!" toView:self.view];
        return;
    }
    WEAKSELF
    [SPLoginTool getVerifyCode:self.codeParam success:^(SPCodeResult *codeResult) {
        if (codeResult.error) {
            [MBProgressHUD showError:codeResult.errorMsg toView:weakSelf.view];
        }else{
            [MBProgressHUD showMessage:@"验证码已发送,请注意查收" toView:weakSelf.view];
            [weakSelf counDown];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"网络异常,验证码发送失败" toView:weakSelf.view];
    }];
}

- (void)counDown {
    __block NSInteger time = 59; //设置倒计时时间
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    WEAKSELF
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [weakSelf.countDownBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                weakSelf.countDownBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            NSInteger seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [weakSelf.countDownBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2ld)", (long)seconds] forState:UIControlStateNormal];
                weakSelf.countDownBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

- (IBAction)doSelect:(UIButton *)sender {
    self.isSelect = !self.isSelect;
    if (self.isSelect) {
        [sender setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
        self.registerBtn.backgroundColor = SPColor;
        self.registerBtn.userInteractionEnabled = YES;
    }else{
        [sender setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
        self.registerBtn.backgroundColor = RGB(223, 223, 223);
        self.registerBtn.userInteractionEnabled = NO;
    }
}

- (IBAction)seeUserAgreement {
    SPUserAgreementViewController *userAgreementVc = [[SPUserAgreementViewController alloc] init];
    [self.navigationController pushViewController:userAgreementVc animated:YES];
}

- (IBAction)contentChange {
    self.registerParam.num = self.telephone.text;
    self.codeParam.num = self.telephone.text;
    self.registerParam.pwd = self.secondPwd.text;
    self.registerParam.code = self.code.text;
    self.registerParam.inviter = self.invite.text;
}

- (IBAction)regist {
    if(![SPSpeedy dc_isTelephone:self.telephone.text]) {
        [MBProgressHUD showMessage:@"请输入正确的手机号" toView:self.view];
        return;
    }
    if([self.fisrtPwd.text length] < 1) {
        [MBProgressHUD showMessage:@"请输入密码" toView:self.view];
        return;
    }
    if([self.secondPwd.text length] < 1) {
        [MBProgressHUD showMessage:@"请确认密码" toView:self.view];
        return;
    }
    if(![self.fisrtPwd.text isEqualToString:self.secondPwd.text]) {
        [MBProgressHUD showMessage:@"两次输入密码不一致" toView:self.view];
        return;
    }
    if([self.code.text length] < 1) {
        [MBProgressHUD showMessage:@"验证码没有填写" toView:self.view];
        return;
    }
    
    [MBProgressHUD showWaitMessage:@"注册中..." toView:self.view];
    [SPLoginTool regist:self.registerParam success:^(SPLoginResult *loginResult) {
        [MBProgressHUD hideHUDForView:self.view];
        if (loginResult.error) {
            [MBProgressHUD showError:loginResult.errorMsg toView:self.view];
        }else{
            [MBProgressHUD showSuccess:@"注册成功" toView:self.view];
            // 1.存储模型数据
            [SPAccountTool saveLoginResult:loginResult];
            
            // 2.新特性\去首页
            [SPSmartPlusTool chooseRootController];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络异常,注册失败" toView:self.view];
    }];
}

#pragma mark - 屏幕横竖屏设置
- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
