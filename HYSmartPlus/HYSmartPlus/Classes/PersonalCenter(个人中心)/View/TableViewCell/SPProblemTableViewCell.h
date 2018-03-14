//
//  SPProblemTableViewCell.h
//  HYSmartPlus
//
//  Created by information on 2018/3/14.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPProblemTableViewCell : UITableViewCell

@property (nonatomic, strong)  NSArray *scrollArray;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
