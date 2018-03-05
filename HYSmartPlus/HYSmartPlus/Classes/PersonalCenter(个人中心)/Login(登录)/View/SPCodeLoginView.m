//
//  SPCodeLoginView.m
//  HYSmartPlus
//
//  Created by information on 2018/2/28.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPCodeLoginView.h"

@interface SPCodeLoginView () <UITextFieldDelegate>

@property (nonatomic, weak) UILabel *telLabel;
@property (nonatomic, weak) UITextField *phoneTextField;
@property (nonatomic, weak) UIView  *firstLine;

@property (nonatomic, weak) UIButton *countDownButton;
@property (nonatomic, weak) UITextField *codeTextField;
@property (nonatomic, weak) UIView  *secondLine;

@property (nonatomic, weak) UIButton *submitButton;

@end

@implementation SPCodeLoginView

+ (instancetype)codeView {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customView];
    }
    return self;
}

- (void)customView {
    self.backgroundColor = [UIColor whiteColor];
    self.codeParam = [SPCodeParam param:APP00000];
    self.codeParam.ztemplate = @"SMS_109740618";
    
    UILabel *telLabel = [[UILabel alloc] init];
    telLabel.text = @"+86";
    telLabel.textColor = RGB(62, 62, 62);
    telLabel.font = [UIFont systemFontOfSize:17];
    _telLabel = telLabel;
    [self addSubview:self.telLabel];
    
    UITextField *phoneTextField = [[UITextField alloc] init];
    phoneTextField.placeholder = @"请输入手机号";
    phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    [phoneTextField addTarget:self action:@selector(contentChanged) forControlEvents:UIControlEventEditingChanged];
    _phoneTextField = phoneTextField;
    [self addSubview:phoneTextField];
    
    UIView *firstLine = [[UIView alloc] init];
    firstLine.backgroundColor = RGB(223, 223, 223);
    _firstLine = firstLine;
    [self addSubview:firstLine];
    
    UIButton *countDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [countDownButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    countDownButton.backgroundColor = SPColor;
    countDownButton.layer.cornerRadius = 7;
    countDownButton.layer.masksToBounds = YES;
    countDownButton.titleLabel.font = PFR14Font;
    [countDownButton addTarget:self action:@selector(obtainVerifyCode) forControlEvents:UIControlEventTouchUpInside];
    _countDownButton = countDownButton;
    [self addSubview:countDownButton];
    
    UITextField *codeTextField = [[UITextField alloc] init];
    codeTextField.placeholder = @"请输入验证码";
    
    [codeTextField addTarget:self action:@selector(contentChanged) forControlEvents:UIControlEventEditingChanged];
    _codeTextField = codeTextField;
    [self addSubview:codeTextField];
    
    UIView *secondLine = [[UIView alloc] init];
    secondLine.backgroundColor = RGB(223, 223, 223);
    _secondLine = secondLine;
    [self addSubview:secondLine];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.layer.cornerRadius = 8;
    submitButton.layer.masksToBounds = YES;
    submitButton.backgroundColor = RGB(207, 235, 221);
    [submitButton setTitle:@"登录" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(startRegisterButtonClick) forControlEvents:UIControlEventTouchUpInside];
    submitButton.userInteractionEnabled = NO;
    _submitButton = submitButton;
    [self addSubview:submitButton];
    
    /*
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getVerifyCodeSucess) name:@"getVerifyCodeSucess" object:nil];
     */
}

- (void)updateConstraints {
    //1.remake/update constraints here
    [self.telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(25);
        make.left.equalTo(self).offset(45);
        make.height.mas_equalTo(34);
    }];
    
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(25);
        make.left.equalTo(self.telLabel.mas_right).offset(15);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(ScreenW - 45 * 2 - 31 - 15);
    }];
    
    [self.firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.phoneTextField.mas_bottom);
        make.left.equalTo(self).offset(45);
        make.right.equalTo(self).offset(-45);
        make.height.mas_equalTo(1);
    }];
    
    [self.countDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(17);
        make.right.equalTo(self.phoneTextField.mas_right);
        make.height.mas_equalTo(38);
        make.width.mas_equalTo(110);
    }];
    
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).offset(25);
        make.left.equalTo(self.telLabel);
        make.height.mas_equalTo(34);
        make.right.equalTo(self.countDownButton.mas_left).offset(-20);
    }];
    
    [self.secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.codeTextField.mas_bottom);
        make.left.equalTo(self).offset(45);
        make.right.equalTo(self.countDownButton.mas_left).offset(-20);
        make.height.mas_equalTo(1);
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeTextField.mas_bottom).offset(40);
        make.left.equalTo(self).offset(45);
        make.width.mas_equalTo(ScreenW - 45 * 2);
        make.height.mas_equalTo(44);
    }];
    
    //2.according to apple super should be called at end of method
    [super updateConstraints];
}

- (void)contentChanged {
    if (self.phoneTextField.text.length > 0 && self.codeTextField.text.length > 0) {
        self.submitButton.userInteractionEnabled = YES;
        self.submitButton.backgroundColor = SPColor;
    }else{
        self.submitButton.userInteractionEnabled = NO;
        self.submitButton.backgroundColor = RGB(207, 235, 221);
    }
    self.codeParam.num = self.phoneTextField.text;
}

- (void)obtainVerifyCode {
    if (![SPSpeedy dc_isTelephone:self.codeParam.num]) {
        [MBProgressHUD showMessage:@"请输入正确的手机号码!"];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(codeLoginViewDidClickObtainVerifyCodeButton:)]) {
        [self.delegate codeLoginViewDidClickObtainVerifyCodeButton:self];
    }
    __block NSInteger time = 59; //设置倒计时时间
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    WEAKSELF
    dispatch_source_set_event_handler(_timer, ^{
        if (time <= 0) { //倒计时结束,关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [weakSelf.countDownButton setTitle:@"重新发送" forState:UIControlStateNormal];
                weakSelf.countDownButton.userInteractionEnabled = YES;
            });
        }else{
            NSInteger seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{

                //设置按钮显示读秒效果
                [weakSelf.countDownButton setTitle:[NSString stringWithFormat:@"重新发送(%.2ld)", (long)seconds] forState:UIControlStateNormal];
                weakSelf.countDownButton.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

@end
