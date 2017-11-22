//
//  SPGoodsYouLikeCell.h
//  HYSmartPlus
//
//  Created by information on 2017/11/22.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPRecommendItem;

@interface SPGoodsYouLikeCell : UICollectionViewCell

/** 推荐数据 */
@property (nonatomic, strong)  SPRecommendItem *youLikeItem;

@end
