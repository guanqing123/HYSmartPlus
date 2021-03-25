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
#import "SPCommentViewController.h"
#import "SPUploadPhotoCollectionViewController.h"
#import "SPSearchBar.h"
#import "SPConstructionTableCell.h"
#import "MJRefresh.h"
#import "SPConstructionTool.h"
#import "SPAccountTool.h"
#import "SPLoginResult.h"
#import "IQKeyboardManager.h"
#import "SPAppiontmentViewController.h"

@interface SPConstructionViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,SPConstructionTableCellDelegate,SPSiteCreateViewControllerDelegate,SPCommentViewControllerDelegate>
// 搜索条
@property (nonatomic, weak)  UIView *searchView;
// 搜索内容
@property (nonatomic, copy) NSString *searchText;
// tableView
@property (nonatomic, weak) UITableView  *tableView;

@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, strong)  NSMutableArray *dropowerArray;

@end

@implementation SPConstructionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1.设置导航与背景
    [self setupNavBar];
    
    //2.设置搜索框
    [self setupSearchBar];
    
    //3.初始化 UITableView
    [self setupTableView];
}

#pragma mark - 设置导航与背景
- (void)setupNavBar {
    // 0.我的工地
    self.title = @"我的工地";
    
    // 1.背景色
    self.view.backgroundColor = SPBGColor;
        
    // 2.左
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"30"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    // 3.右
    UIBarButtonItem *yue = [[UIBarButtonItem alloc] initWithTitle:@"预约" style:UIBarButtonItemStyleDone target:self action:@selector(appiontment)];
    UIBarButtonItem *add = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"add"] withHighLightedImage:[UIImage imageNamed:@"add"] target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItems = @[add, yue];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - appiontment
- (void)appiontment {
    SPAppiontmentViewController *appiontmentVc = [[SPAppiontmentViewController alloc] init];
    [self.navigationController pushViewController:appiontmentVc animated:YES];
}

#pragma mark - 创建工地
- (void)add {
    SPSiteCreateViewController *siteVc = [[SPSiteCreateViewController alloc] init];
    siteVc.delegate = self;
    [self.navigationController pushViewController:siteVc animated:YES];
}

#pragma mark - SPSiteCreateViewControllerDelegate
- (void)siteCreateVcFinishSave:(SPSiteCreateViewController *)siteCreateVc {
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 设置搜索框
- (void)setupSearchBar {
    UIView *searchView = [[UIView alloc] init];
    searchView.backgroundColor = [UIColor whiteColor];
    searchView.frame = CGRectMake(0, SPTopNavH, ScreenW, searchViewH);
    _searchView = searchView;
    [self.view addSubview:searchView];
    
    SPSearchBar *searchBar = [SPSearchBar searchBar];
    searchBar.placeholder = @"业主电话";
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
    searchBar.delegate = self;
    [searchBar addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    searchBar.inputAccessoryView = [[UIView alloc] init];
    searchBar.returnKeyType = UIReturnKeySearch;
}

#pragma mark - 搜索框文本变化
- (void)textFieldDidChange:(UITextField *)textField {
    self.searchText = textField.text;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self.tableView.mj_header beginRefreshing];
    return YES;
}

#pragma mark - setupTableView
- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, self.searchView.dc_bottom, ScreenW, ScreenH - self.searchView.dc_bottom);
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.backgroundColor = RGB(244, 244, 244);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    [self.tableView.mj_header beginRefreshing];
    self.pageNum = 1;
    self.pageSize = 5;
    
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
}

- (void)headerRefreshing {
    _pageNum = 1;
    SPDropowerFenyeParam *fenyeParam = [[SPDropowerFenyeParam alloc] init];
    fenyeParam.uid = [SPAccountTool loginResult].userbase.uid;
    fenyeParam.pageNum = self.pageNum;
    fenyeParam.pageSize = self.pageSize;
    fenyeParam.content = self.searchText;
    [SPConstructionTool getDropowerAndDetailsFenye:fenyeParam success:^(SPDropowerFenyeResult *fenyeResult) {
        if (![fenyeResult.code isEqualToString:@"00000"]) {
            [self.tableView.mj_header endRefreshing];
            [MBProgressHUD showError:fenyeResult.msg toView:self.view];
        }else{
            [self.dropowerArray removeAllObjects];
            [self.dropowerArray addObjectsFromArray:fenyeResult.dropowerFenye.list];
            if (fenyeResult.dropowerFenye.pages > 1) {
                _pageNum ++;
                [self setupFooterRefreshing];
            }else{
                self.tableView.mj_footer = nil;
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD showError:@"网络异常" toView:self.view];
    }];
}

- (void)setupFooterRefreshing {
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
}

- (void)footerRefreshing {
    SPDropowerFenyeParam *fenyeParam = [[SPDropowerFenyeParam alloc] init];
    fenyeParam.uid = [SPAccountTool loginResult].userbase.uid;
    fenyeParam.pageNum = self.pageNum;
    fenyeParam.pageSize = self.pageSize;
    fenyeParam.content = self.searchText;
    [SPConstructionTool getDropowerAndDetailsFenye:fenyeParam success:^(SPDropowerFenyeResult *fenyeResult) {
        if (![fenyeResult.code isEqualToString:@"00000"]) {
            [self.tableView.mj_footer endRefreshing];
            [MBProgressHUD showError:fenyeResult.msg toView:self.view];
        }else{
            [self.dropowerArray addObjectsFromArray:fenyeResult.dropowerFenye.list];
            [self.tableView reloadData];
            _pageNum ++;
            NSInteger totalPage = fenyeResult.dropowerFenye.pages;
            if (_pageNum > totalPage) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD showError:@"网络异常" toView:self.view];
    }];
}

#pragma mark lazyLoad
- (NSMutableArray *)dropowerArray {
    if (!_dropowerArray) {
        _dropowerArray = [NSMutableArray array];
    }
    return _dropowerArray;
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dropowerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPConstructionTableCell *cell = [SPConstructionTableCell cellWithTableView:tableView];
    cell.delegate = self;
    
    SPDropower *dropower = self.dropowerArray[indexPath.row];
    cell.dropower = dropower;
    
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SPDropower *dropower = self.dropowerArray[indexPath.row];
    SPCommentViewController *commentVc = [[SPCommentViewController alloc] initWithDropower:dropower];
    commentVc.delegate = self;
    [self.navigationController pushViewController:commentVc animated:YES];
}

#pragma mark -SPCommentViewController Delegate
- (void)commentViewController:(SPCommentViewController *)commentVc {
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - SPConstructionTableCellDelegate
- (void)constructionTableCell:(SPConstructionTableCell *)tableViewCell deleteDropowerDetail:(SPDropowerDetail *)dropDetail {
    SPDeleteDropowerDetailParam *deleteParam = [[SPDeleteDropowerDetailParam alloc] init];
    deleteParam.uid = [SPAccountTool loginResult].userbase.uid;
    deleteParam.idStr = dropDetail.idStr;
    [MBProgressHUD showWaitMessage:@"删除中..." toView:self.view];
    [SPConstructionTool deleteDropowerDetail:deleteParam success:^(SPCommonResult *result) {
        [MBProgressHUD hideHUDForView:self.view];
        if(![result.code isEqualToString:@"00000"]) {
            [MBProgressHUD showError:result.msg toView:self.view];
        }else{
            [MBProgressHUD showSuccess:@"删除成功" toView:self.view];
            [self.tableView.mj_header beginRefreshing];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"网络异常" toView:self.view];
    }];
}

- (void)constructionTableCell:(SPConstructionTableCell *)tableViewCell dropower:(SPDropower *)dropower buttonType:(ToolBarButtonType)buttonType {
    switch (buttonType) {
            case ToolBarButtonTypeCamera:{
                [self uploadPhotos:dropower];
            }
            break;
            case ToolBarButtonTypePressure:{
                [self pressureConstruction:dropower];
            }
            break;
            case ToolBarButtonTypeDelete:{
                [self deleteDropowerAndDetails:dropower];
            }
            break;
        default:
            break;
    }
}

- (void)uploadPhotos:(SPDropower *)dropower {
    SPUploadPhotoCollectionViewController *uploadPhotoVc = [[SPUploadPhotoCollectionViewController alloc] init];
    uploadPhotoVc.dropower = dropower;
    WEAKSELF
    uploadPhotoVc.finishPhotoUpload = ^{
        [weakSelf.tableView.mj_header beginRefreshing];
    };
    [self.navigationController pushViewController:uploadPhotoVc animated:YES];
}

- (void)pressureConstruction:(SPDropower *)dropower {
    NSString *urlStr = [NSString stringWithFormat:@"smart://pressure?dh=%@&username=%@&usertel=%@&address=%@",dropower.idNum,dropower.userName,dropower.userTel,dropower.address];
    NSString *encoding = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:encoding]]) {
        if (@available(iOS 10.0,*)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:encoding] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:encoding]];
        }
    } else {
        // 1.实例化UIAlertController
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"试压APP没有安装" preferredStyle:UIAlertControllerStyleAlert];
        
        // 2.实例化UIAlertAction
        WEAKSELF
        UIAlertAction *installAction = [UIAlertAction actionWithTitle:@"现在安装" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf install];
        }];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVc addAction:installAction];
        [alertVc addAction:cancleAction];
        // 3.显示UIAlertController
        [self presentViewController:alertVc animated:YES completion:nil];
   }
}

- (void)install {
    NSString *urlStr = [NSString stringWithFormat:@"https://apps.apple.com/cn/app/鸿雁试压/id1477032242"];
    NSString *encoding = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if (@available(iOS 10.0,*)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:encoding] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:encoding]];
    }
}

- (void)deleteDropowerAndDetails:(SPDropower *)dropower {
    //删除提示框
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"警告" message:@"确定要删除?" preferredStyle:UIAlertControllerStyleActionSheet];
    WEAKSELF
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        SPDeleteDropowerDetailParam *deleteParam = [[SPDeleteDropowerDetailParam alloc] init];
        deleteParam.uid = [SPAccountTool loginResult].userbase.uid;
        deleteParam.idStr = dropower.idNum;
        [MBProgressHUD showWaitMessage:@"删除中..." toView:weakSelf.view];
        [SPConstructionTool deleteDropowerAndDetails:deleteParam success:^(SPCommonResult *result) {
            [MBProgressHUD hideHUDForView:weakSelf.view];
            if(![result.code isEqualToString:@"00000"]) {
                [MBProgressHUD showError:result.msg toView:weakSelf.view];
            }else{
                [MBProgressHUD showSuccess:@"删除成功" toView:weakSelf.view];
                [weakSelf.tableView.mj_header beginRefreshing];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:weakSelf.view];
            [MBProgressHUD showError:@"网络异常" toView:weakSelf.view];
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //添加按钮
    [alertVc addAction:sureAction];
    [alertVc addAction:cancelAction];
    
    //显示控制器
    [self presentViewController:alertVc animated:YES completion:nil];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (ScreenW - (column + 1) * margin)/column + topTextViewH + bottomToolBarViewH + 4 * margin;
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
