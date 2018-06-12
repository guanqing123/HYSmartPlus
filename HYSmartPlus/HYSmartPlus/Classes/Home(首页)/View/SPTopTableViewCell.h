//
//  SPTopTableViewCell.h
//  HYSmartPlus
//
//  Created by information on 2018/6/12.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPSellActivity.h"

@interface SPTopTableViewCell : UITableViewCell

@property (nonatomic, strong)  SPSellActivity *sellActivity;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
