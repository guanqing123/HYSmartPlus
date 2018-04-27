//
//  WCCommonProblemCell.h
//  HYWork
//
//  Created by information on 16/7/7.
//  Copyright © 2016年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPProblem.h"

@interface WCCommonProblemCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong)  SPProblem *problem;

@end
