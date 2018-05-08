//
//  SPConstructionTableCell.h
//  HYSmartPlus
//
//  Created by information on 2018/5/7.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPDropower.h"

#define column 3
#define margin 5
#define topTextViewH 146
#define bottomToolBarViewH 30

@interface SPConstructionTableCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)  SPDropower *dropower;

@end
