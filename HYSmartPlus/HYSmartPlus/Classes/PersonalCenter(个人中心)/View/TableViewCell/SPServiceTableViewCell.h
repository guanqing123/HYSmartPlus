//
//  SPServiceTableViewCell.h
//  HYSmartPlus
//
//  Created by information on 2018/3/14.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPServiceItem.h"
@class SPServiceTableViewCell;

@protocol SPServiceTableViewCellDelegate <NSObject>

/**
 点击具体服务Item

 @param tableViewCell tableViewCell
 @param serviceItem 服务Item
 */
- (void)serviceTableViewCell:(SPServiceTableViewCell *)tableViewCell didClickCollectionViewItem:(SPServiceItem *)serviceItem;

@end

@interface SPServiceTableViewCell : UITableViewCell

@property (nonatomic, weak) id<SPServiceTableViewCellDelegate>  delegate;

/* 数据 */
@property (nonatomic, strong)  NSMutableArray<SPServiceItem *> *serviceItem;

@end
