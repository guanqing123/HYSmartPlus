//
//  SPChooseLocationView.m
//  HYSmartPlus
//
//  Created by information on 2018/5/3.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPChooseLocationView.h"
#import "SPAddressView.h"
#import "SPCitiesDataTool.h"
#import "SPAddressTableViewCell.h"
#import "SPAddressItem.h"

static  CGFloat  const  kHYTopViewHeight = 40; //顶部视图的高度
static  CGFloat  const  kHYTopTabbarHeight = 40; //地址标签栏的高度

@interface SPChooseLocationView()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)  SPAddressView   *topTabbar;
@property (nonatomic,   weak)  UIScrollView    *contentView;
@property (nonatomic, strong)  NSMutableArray  *tableViews;
@property (nonatomic, strong)  NSMutableArray  *topTabbarItems;

@property (nonatomic, weak)  UIView  *underLine;
@property (nonatomic,strong) NSArray *dataSouce;
@property (nonatomic,strong) NSArray *cityDataSouce;
@property (nonatomic,strong) NSArray * districtDataSouce;

@property (nonatomic, weak) UIButton  *selectedBtn;



@end

@implementation SPChooseLocationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

#pragma mark - setUp UI
- (void)setUp {
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.dc_width, kHYTopViewHeight)];
    [self addSubview:topView];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"所在地区";
    [titleLabel sizeToFit];
    [topView addSubview:titleLabel];
    titleLabel.dc_centerY = topView.dc_height * 0.5;
    titleLabel.dc_centerX = topView.dc_width * 0.5;

    UIView *separateLineH = [self separateLine];
    [topView addSubview: separateLineH];
    separateLineH.dc_y = topView.dc_height - separateLineH.dc_height;
    topView.backgroundColor = [UIColor whiteColor];
    
    SPAddressView *topTabbar = [[SPAddressView alloc] initWithFrame:CGRectMake(0, topView.dc_height, self.dc_width, kHYTopTabbarHeight)];
    topTabbar.backgroundColor = [UIColor whiteColor];
    _topTabbar = topTabbar;
    [self addSubview:topTabbar];
    
    [self addTopBarItem];
    
    UIView *separateLineB = [self separateLine];
    separateLineB.dc_y = topTabbar.dc_height - separateLineB.dc_height;
    [topTabbar addSubview:separateLineB];
    [_topTabbar layoutIfNeeded];
    
    UIView *underLine = [[UIView alloc] initWithFrame:CGRectZero];
    [topTabbar addSubview:underLine];
    _underLine = underLine;
    _underLine.backgroundColor = [UIColor redColor];
    underLine.dc_height = 2.0f;
    UIButton * btn = self.topTabbarItems.lastObject;
    [self changeUnderLineFrame:btn];
    underLine.dc_y = separateLineB.dc_y - underLine.dc_height;
    
    _underLine.backgroundColor = [UIColor redColor];
    
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topTabbar.dc_bottom, self.dc_width, self.dc_height - kHYTopViewHeight - kHYTopTabbarHeight)];
    contentView.contentSize = CGSizeMake(ScreenH, 0);
    contentView.showsHorizontalScrollIndicator = NO;
    _contentView = contentView;
    _contentView.pagingEnabled = YES;
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.delegate = self;
    [self addSubview:contentView];
    
    [self addTableView];

}

- (void)addTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.tableViews.count * ScreenW, 0, ScreenW, _contentView.dc_height)];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    [tableView registerNib:[UINib nibWithNibName:@"SPAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"SPAddressTableViewCell"];
    [_contentView addSubview:tableView];
    
    [self.tableViews addObject:tableView];
}

- (void)addTopBarItem {
    UIButton *topBarItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [topBarItem setTitle:@"请选择" forState:UIControlStateNormal];
    [topBarItem setTitleColor:RGB(43, 43, 43) forState:UIControlStateNormal];
    topBarItem.titleLabel.font = PFR16Font;
    [topBarItem setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [topBarItem sizeToFit];
    topBarItem.dc_centerY = _topTabbar.dc_height * 0.5;
    [self.topTabbarItems addObject:topBarItem];
    [_topTabbar addSubview:topBarItem];
    [topBarItem addTarget:self action:@selector(topBarItemClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.tableViews indexOfObject:tableView] == 0) {
        return self.dataSouce.count;
    }else if([self.tableViews indexOfObject:tableView] == 1) {
        return self.cityDataSouce.count;
    }else if([self.tableViews indexOfObject:tableView] == 2) {
        return self.districtDataSouce.count;
    }
    return self.dataSouce.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SPAddressTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SPAddressItem *item;
    //省级别
    if ([self.tableViews indexOfObject:tableView] == 0) {
        item = self.dataSouce[indexPath.row];
    //市级别
    }else if ([self.tableViews indexOfObject:tableView] == 1) {
        item = self.cityDataSouce[indexPath.row];
    //县级别
    }else if ([self.tableViews indexOfObject:tableView] == 2) {
        item = self.districtDataSouce[indexPath.row];
    }
    cell.item = item;
    return cell;
}

#pragma mark - TableViewDelegate
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.tableViews indexOfObject:tableView] == 0) {
        //1.1 获取下一级别的数据源(市级别,如果是直辖市时,下级则为区级别)
        SPAddressItem *provinceItem = self.dataSouce[indexPath.row];
        self.cityDataSouce = [[SPCitiesDataTool sharedManager] queryAllRecordWithShengID:[provinceItem.code substringWithRange:(NSRange){0,2}]];
        if(self.cityDataSouce.count == 0){
            for (int i = 0; i < self.tableViews.count && self.tableViews.count != 1; i++) {
                [self removeLastItem];
            }
            [self setUpAddress:provinceItem.name];
            return indexPath;
        }
        //1.1 判断是否是第一次选择,不是,则重新选择省,切换省.
        NSIndexPath * indexPath0 = [tableView indexPathForSelectedRow];
        
        if ([indexPath0 compare:indexPath] != NSOrderedSame && indexPath0) {
            
            for (int i = 0; i < self.tableViews.count && self.tableViews.count != 1; i++) {
                [self removeLastItem];
            }
            [self addTopBarItem];
            [self addTableView];
            [self scrollToNextItem:provinceItem.name];
            return indexPath;
            
        }else if ([indexPath0 compare:indexPath] == NSOrderedSame && indexPath0){
            
            for (int i = 0; i < self.tableViews.count && self.tableViews.count != 1 ; i++) {
                [self removeLastItem];
            }
            [self addTopBarItem];
            [self addTableView];
            [self scrollToNextItem:provinceItem.name];
            return indexPath;
        }
        
        //之前未选中省，第一次选择省
        [self addTopBarItem];
        [self addTableView];
        SPAddressItem * item = self.dataSouce[indexPath.row];
        [self scrollToNextItem:item.name];
        self.provinceId = item.code;
        NSLog(@"%@ %@",item.name,item.code);
    }else if ([self.tableViews indexOfObject:tableView] == 1) {
        SPAddressItem *cityItem = self.cityDataSouce[indexPath.row];
        self.districtDataSouce = [[SPCitiesDataTool sharedManager] queryAllRecordWithShengID:cityItem.sheng cityID:cityItem.di];
        NSIndexPath * indexPath0 = [tableView indexPathForSelectedRow];
        
        if ([indexPath0 compare:indexPath] != NSOrderedSame && indexPath0) {
            for (int i = 0; i < self.tableViews.count - 1; i++) {
                [self removeLastItem];
            }
            [self addTopBarItem];
            [self addTableView];
            [self scrollToNextItem:cityItem.name];
            return indexPath;
        }else if ([indexPath0 compare:indexPath] == NSOrderedSame && indexPath0){
            
            [self scrollToNextItem:cityItem.name];
            return indexPath;
        }
        [self addTopBarItem];
        [self addTableView];
        SPAddressItem * item = self.cityDataSouce[indexPath.row];
        [self scrollToNextItem:item.name];
        self.cityId = item.code;
        NSLog(@"%@ %@",item.name,item.code);
    } else if ([self.tableViews indexOfObject:tableView] == 2){
        
        SPAddressItem * item = self.districtDataSouce[indexPath.row];
        
        self.districtId = item.code;
        NSLog(@"%@ %@",item.name,item.code);
        
        [self setUpAddress:item.name];
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SPAddressItem * item;
    if([self.tableViews indexOfObject:tableView] == 0){
        item = self.dataSouce[indexPath.row];
    }else if ([self.tableViews indexOfObject:tableView] == 1){
        item = self.cityDataSouce[indexPath.row];
    }
    item.isSelected = YES;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    SPAddressItem *item;
    if ([self.tableViews indexOfObject:tableView] == 0) {
        item = self.dataSouce[indexPath.row];
    }else if ([self.tableViews indexOfObject:tableView] == 1){
        item = self.cityDataSouce[indexPath.row];
    }
    item.isSelected = NO;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - getter 方法

//分割线
- (UIView *)separateLine{
    UIView * separateLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1 / [UIScreen mainScreen].scale)];
    separateLine.backgroundColor = RGB(222, 222, 222);
    return separateLine;
}

- (NSMutableArray *)tableViews {
    if (_tableViews == nil) {
        _tableViews = [NSMutableArray array];
    }
    return _tableViews;
}

- (NSMutableArray *)topTabbarItems {
    if (_topTabbarItems == nil) {
        _topTabbarItems = [NSMutableArray array];
    }
    return _topTabbarItems;
}

//省级别数据源
- (NSArray *)dataSouce{
    
    if (_dataSouce == nil) {
        
        _dataSouce = [[SPCitiesDataTool sharedManager] queryAllProvince];
    }
    return _dataSouce;
}

#pragma mark - private

- (void)topBarItemClick:(UIButton *)btn {
    NSInteger index = [self.topTabbarItems indexOfObject:btn];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.contentOffset = CGPointMake(index * ScreenW, 0);
        [self changeUnderLineFrame:btn];
    }];
}

//调整指示条位置
- (void)changeUnderLineFrame:(UIButton  *)btn{
    
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    _underLine.dc_x = btn.dc_x;
    _underLine.dc_width = btn.dc_width;
}

//完成地址选择,执行chooseFinish代码块
- (void)setUpAddress:(NSString *)address{
    
    NSInteger index = self.contentView.contentOffset.x / ScreenW;
    UIButton * btn = self.topTabbarItems[index];
    [btn setTitle:address forState:UIControlStateNormal];
    [btn sizeToFit];
    [_topTabbar layoutIfNeeded];
    [self changeUnderLineFrame:btn];
    NSMutableString * addressStr = [[NSMutableString alloc] init];
    for (UIButton * btn  in self.topTabbarItems) {
        if ([btn.currentTitle isEqualToString:@"县"] || [btn.currentTitle isEqualToString:@"市辖区"] ) {
            continue;
        }
        [addressStr appendString:btn.currentTitle];
        [addressStr appendString:@" "];
    }
    self.address = addressStr;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.hidden = YES;
        if ([self.delegate respondsToSelector:@selector(chooseLocationView:address:)]) {
            [self.delegate chooseLocationView:self address:self.address];
        }
    });
}

//当重新选择省或者市的时候，需要将下级视图移除。
- (void)removeLastItem{
    
    [self.tableViews.lastObject performSelector:@selector(removeFromSuperview) withObject:nil withObject:nil];
    [self.tableViews removeLastObject];
    
    [self.topTabbarItems.lastObject performSelector:@selector(removeFromSuperview) withObject:nil withObject:nil];
    [self.topTabbarItems removeLastObject];
}

//滚动到下级界面,并重新设置顶部按钮条上对应按钮的title
- (void)scrollToNextItem:(NSString *)preTitle{
    
    NSInteger index = self.contentView.contentOffset.x / ScreenW;
    UIButton * btn = self.topTabbarItems[index];
    [btn setTitle:preTitle forState:UIControlStateNormal];
    [btn sizeToFit];
    [_topTabbar layoutIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.contentSize = (CGSize){self.tableViews.count * ScreenW,0};
        CGPoint offset = self.contentView.contentOffset;
        self.contentView.contentOffset = CGPointMake(offset.x + ScreenW, offset.y);
        [self changeUnderLineFrame: [self.topTabbar.subviews lastObject]];
    }];
}

#pragma mark - <UIScrollView>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UITableView class]]) return;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        NSInteger index = scrollView.contentOffset.x / ScreenW;
        UIButton * btn = weakSelf.topTabbarItems[index];
        [weakSelf changeUnderLineFrame:btn];
    }];
}

@end
