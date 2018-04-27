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
@class SPProblemTableViewCell;

@protocol SPProblemTableViewCellDelegate <NSObject>

/**
 查看更多问题

 @param tableViewCell 当前tableView cell
 */
- (void)problemTableViewCellDidMoreProblem:(SPProblemTableViewCell *)tableViewCell;

@end

@interface SPProblemTableViewCell : UITableViewCell

@property (nonatomic, weak) id<SPProblemTableViewCellDelegate>  delegate;

@property (nonatomic, strong)  SPProblemResult *result;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
