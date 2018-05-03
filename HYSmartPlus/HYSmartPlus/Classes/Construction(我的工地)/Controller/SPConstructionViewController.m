//
//  SPConstructionViewController.m
//  HYSmartPlus
//
//  Created by information on 2018/5/1.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#define searchViewH 44.0f

#import "SPConstructionViewController.h"
#import "SPSiteCreateViewController.h"

#import "SPSearchBar.h"

@interface SPConstructionViewController ()

@end

@implementation SPConstructionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1.设置导航与背景
    [self setupNavBar];
    
    //2.设置搜索框
    [self setupSearchBar];
}

#pragma mark - 设置导航与背景
- (void)setupNavBar {
    self.view.backgroundColor = SPBGColor;
    
    // rightItem
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"add"] withHighLightedImage:[UIImage imageNamed:@"add"] target:self action:@selector(add)];
}

#pragma mark - 创建工地
- (void)add {
    SPSiteCreateViewController *siteVc = [[SPSiteCreateViewController alloc] init];
    siteVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:siteVc animated:YES];
}

#pragma mark - 设置搜索框
- (void)setupSearchBar {
    UIView *searchView = [[UIView alloc] init];
    searchView.backgroundColor = [UIColor whiteColor];
    searchView.frame = CGRectMake(0, SPTopNavH, ScreenW, searchViewH);
    [self.view addSubview:searchView];
    
    SPSearchBar *searchBar = [SPSearchBar searchBar];
    searchBar.keyboardType = UIKeyboardTypeDefault;
    searchBar.returnKeyType = UIReturnKeyDone;
    searchBar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    searchBar.layer.borderWidth = 0.2;
    searchBar.layer.cornerRadius = 4;
    searchBar.backgroundColor = RGB(244, 244, 244);
    [searchView addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(searchView).with.insets(UIEdgeInsetsMake(SPMargin*0.5, SPMargin, SPMargin*0.5, SPMargin));
    }];
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

@end
