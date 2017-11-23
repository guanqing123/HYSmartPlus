//
//  SPCommodityViewController.m
//  HYSmartPlus
//
//  Created by information on 2017/11/23.
//  Copyright © 2017年 hongyan. All rights reserved.
//
#define tableViewW 100

#import "SPCommodityViewController.h"

/** model */
#import "SPClassGoodsItem.h"
#import "SPClassMainItem.h"

/** view */
#import "SPNavSearchBarView.h"
#import "SPClassCategoryCell.h"
#import "SPBrandSortHeadView.h"
#import "SPGoodsSortCell.h"
#import "SPBrandSortCell.h"

/** vendor */
#import "MJExtension.h"

@interface SPCommodityViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

/** tableView */
@property (nonatomic, strong)  UITableView *tableView;
/** collectionView */
@property (nonatomic, strong)  UICollectionView *collectionView;

/** 左边数据 */
@property (nonatomic, strong)  NSMutableArray<SPClassGoodsItem *> *titleItem;
/** 右边数据 */
@property (nonatomic, strong)  NSMutableArray<SPClassMainItem *> *mainItem;

@end

static NSString *const SPClassCategoryCellID = @"SPClassCategoryCell";
static NSString *const SPBrandSortHeadViewID = @"SPBrandSortHeadView";
static NSString *const SPGoodsSortCellID = @"SPGoodsSortCell";
static NSString *const SPBrandSortCellID = @"SPBrandSortCell";

@implementation SPCommodityViewController

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.navigationBar.barTintColor == RGBA(231, 23, 37, 1.0)) return;
    self.navigationController.navigationBar.barTintColor = RGBA(231, 23, 37, 1.0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNav];
    
    [self setUpTab];
    
    [self setUpData];
}

#pragma mark - 设置导航条
- (void)setUpNav {
    SPNavSearchBarView *searchBarVc = [[SPNavSearchBarView alloc] init];
    searchBarVc.placeholdField.text = @"快速查找商品";
    searchBarVc.frame = CGRectMake(20, 25, ScreenW * 0.88, 35);
    self.navigationItem.titleView = searchBarVc;
}

#pragma mark - initizlize
- (void)setUpTab {
    self.view.backgroundColor = SPBGColor;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - LazyLoad
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.frame = CGRectMake(0, 0, tableViewW, self.view.dc_height);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[SPClassCategoryCell class] forCellReuseIdentifier:SPClassCategoryCellID];
    }
    return _tableView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 3; //X
        layout.minimumLineSpacing = 5; //Y
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self.view addSubview:_collectionView];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.frame = CGRectMake(tableViewW, 0, self.view.dc_width - tableViewW, self.view.dc_height);
        
        //注册cell
        [_collectionView registerClass:[SPGoodsSortCell class] forCellWithReuseIdentifier:SPGoodsSortCellID];
        [_collectionView registerClass:[SPBrandSortCell class] forCellWithReuseIdentifier:SPBrandSortCellID];
        
        //注册header
        [_collectionView registerClass:[SPBrandSortHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPBrandSortHeadViewID];
    }
    return _collectionView;
}

#pragma mark - 加载数据
- (void)setUpData {
    _titleItem = [SPClassGoodsItem mj_objectArrayWithFilename:@"ClassifyTitles.plist"];
    _mainItem = [SPClassMainItem mj_objectArrayWithFilename:@"ClassiftyGoods01.plist"];
    //默认选择第一行（注意一定要在加载完数据之后）
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPClassCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:SPClassCategoryCellID forIndexPath:indexPath];
    cell.titleItem = _titleItem[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _mainItem = [SPClassMainItem mj_objectArrayWithFilename:_titleItem[indexPath.row].fileName];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _mainItem.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _mainItem[section].goods.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridCell = nil;
    if ([_mainItem[_mainItem.count - 1].title isEqualToString:@"热门品牌"]) {
        if (indexPath.section == _mainItem.count - 1) { //品牌
            SPBrandSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPBrandSortCellID forIndexPath:indexPath];
            cell.subItem = _mainItem[indexPath.section].goods[indexPath.row];
            gridCell = cell;
        }else{ //商品
            SPGoodsSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPGoodsSortCellID forIndexPath:indexPath];
            cell.subItem = _mainItem[indexPath.section].goods[indexPath.row];
            gridCell = cell;
        }
    }else{ //商品
        SPGoodsSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SPGoodsSortCellID forIndexPath:indexPath];
        cell.subItem = _mainItem[indexPath.section].goods[indexPath.row];
        gridCell = cell;
    }
    return gridCell;
}

#pragma mark - UICollectionViewDelegate
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        SPBrandSortHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SPBrandSortHeadViewID forIndexPath:indexPath];
        headerView.classMainItem = _mainItem[indexPath.section];
        reusableView = headerView;
    }
    return reusableView;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_mainItem[_mainItem.count - 1].title isEqualToString:@"热门品牌"]) {
        if (indexPath.section == _mainItem.count - 1) {//品牌
            return CGSizeMake((ScreenW - tableViewW - 6)/3, 60);
        }else{//商品
            return CGSizeMake((ScreenW - tableViewW - 6)/3, (ScreenW - tableViewW - 6)/3 + 20);
        }
    }else{
        return CGSizeMake((ScreenW - tableViewW - 6)/3, (ScreenW - tableViewW - 6)/3 + 20);
    }
    return CGSizeZero;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenW, 25);
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

#pragma 设置StatusBar为白色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
