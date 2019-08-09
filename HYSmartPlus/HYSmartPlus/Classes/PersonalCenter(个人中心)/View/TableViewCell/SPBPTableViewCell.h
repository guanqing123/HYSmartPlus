//
//  SPBPTableViewCell.h
//  HYSmartPlus
//
//  Created by information on 2018/3/14.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPPersonScoreResult.h"
@class SPBPTableViewCell;

@protocol SPBPTableViewCellDelegate <NSObject>
@optional

/**
 查询业务积分

 @param tabelViewCell 当前tableView
 */
- (void)bpTableViewCell:(SPBPTableViewCell *)tabelViewCell bpBtnClick:(NSString *)khdm;

@end

@interface SPBPTableViewCell : UITableViewCell

@property (nonatomic, strong)  SPPersonScoreResult *result;

@property (nonatomic, weak) id<SPBPTableViewCellDelegate> delegate;

@end
