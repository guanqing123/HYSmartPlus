//
//  SPConstructionTableCell.h
//  HYSmartPlus
//
//  Created by information on 2018/5/7.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPDropower.h"
#import "SPBottomToolBarView.h"

#define column 3
#define margin 5
#define topTextViewH 216
#define bottomToolBarViewH 30
@class SPConstructionTableCell;

@protocol SPConstructionTableCellDelegate <NSObject>

/**
 删除水电图明细

 @param tableViewCell cell
 @param dropDetail 水电图明细
 */
- (void)constructionTableCell:(SPConstructionTableCell *)tableViewCell deleteDropowerDetail:(SPDropowerDetail *)dropDetail;


/**
 点击底部工具条

 @param tableViewCell cell
 @param buttonType 按钮类型
 */
- (void)constructionTableCell:(SPConstructionTableCell *)tableViewCell dropower:(SPDropower *)dropower buttonType:(ToolBarButtonType)buttonType;

@end

@interface SPConstructionTableCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)  SPDropower *dropower;

@property (nonatomic, weak) id<SPConstructionTableCellDelegate>  delegate;

@end
