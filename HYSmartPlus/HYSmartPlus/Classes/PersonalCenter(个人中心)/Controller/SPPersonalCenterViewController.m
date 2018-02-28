//
//  SPPersonalCenterViewController.m
//  HYSmartPlus
//
//  Created by information on 2017/11/24.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPPersonalCenterViewController.h"
#import "MJExtension.h"

@interface SPPersonalCenterViewController () <UITableViewDataSource,UITableViewDelegate>

/** 头部背景图片 */
@property (nonatomic, strong)  UIImageView *headerBgImageView;
/** tableView */
@property (nonatomic, strong)  UITableView *tableView;

@end

@implementation SPPersonalCenterViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpBase];
}

- (void)viewDidAppear:(BOOL)animated {
    //NSLog(@"contentInset = %@",NSStringFromUIEdgeInsets(self.collectionView.contentInset));
    
    //NSLog(@"safeAreaInsets = %@",NSStringFromUIEdgeInsets(self.collectionView.safeAreaInsets));
    
    
    //NSLog(@"adjustedContentInset = %@",NSStringFromUIEdgeInsets(self.collectionView.adjustedContentInset));
}

#pragma mark - initialize
- (void)setUpBase {
    self.view.backgroundColor = SPBGColor;
}

#pragma mark - LazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - SPTopNavH);
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UIImageView *)headerBgImageView {
    if (!_headerBgImageView) {
        _headerBgImageView = [[UIImageView alloc] init];
        
        NSInteger armNum = [SPSpeedy dc_getRandomNumber:1 to:9];
        [_headerBgImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"mine_main_bg_%zd",armNum]]];
        [_headerBgImageView setBackgroundColor:[UIColor greenColor]];
        [_headerBgImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_headerBgImageView setClipsToBounds:YES];
    }
    return _headerBgImageView;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cusCell = [UITableViewCell new];
    if (indexPath.section == 0) {
        //DCCenterItemCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterItemCellID forIndexPath:indexPath];
        //cusCell = cell;
    }else if(indexPath.section == 1){
        //DCCenterServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterServiceCellID forIndexPath:indexPath];
        //cell.serviceItemArray = [NSMutableArray arrayWithArray:_serviceItem];
        //cusCell = cell;
    }else if (indexPath.section == 2){
        //DCCenterBeaShopCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterBeaShopCellID forIndexPath:indexPath];
        //cusCell = cell;
    }else if (indexPath.section == 3){
        //DCCenterBackCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCenterBackCellID forIndexPath:indexPath];
        //cusCell = cell;
    }
    return cusCell;
}
@end
