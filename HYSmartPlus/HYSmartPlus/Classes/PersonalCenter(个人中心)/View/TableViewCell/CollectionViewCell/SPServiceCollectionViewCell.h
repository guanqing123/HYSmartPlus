//
//  SPServiceCollectionViewCell.h
//  HYSmartPlus
//
//  Created by information on 2018/3/14.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPServiceItem;

@interface SPServiceCollectionViewCell : UICollectionViewCell

/** 10个属性数据 */
@property (nonatomic, strong)  SPServiceItem *serviceItem;

@end
