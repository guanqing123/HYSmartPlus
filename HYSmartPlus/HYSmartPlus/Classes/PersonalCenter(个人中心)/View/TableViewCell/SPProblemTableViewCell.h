//
//  SPProblemTableViewCell.h
//  HYSmartPlus
//
//  Created by information on 2018/3/14.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPProblem.h"
#import "SPProblemResult.h"

@interface SPProblemTableViewCell : UITableViewCell

@property (nonatomic, strong)  SPProblemResult *result;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
