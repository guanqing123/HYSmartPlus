//
//  SPIntegralTableViewCell.h
//  HYSmartPlus
//
//  Created by information on 2018/3/14.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPPersonScoreResult.h"
@class SPIntegralTableViewCell;

@protocol SPIntegralTableViewCellDelegate <NSObject>
@optional
/**
 查看品牌积分

 @param integralTableViewCell 当前品牌对象
 */
- (void)integralTableViewCellDidClickIntegralBtn:(SPIntegralTableViewCell *)integralTableViewCell;
@end

@interface SPIntegralTableViewCell : UITableViewCell

@property (nonatomic, strong)  SPPersonScoreResult *result;

@property (nonatomic, weak) id<SPIntegralTableViewCellDelegate> delegate;

@end
