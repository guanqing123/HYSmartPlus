//
//  SPServiceItem.h
//  HYSmartPlus
//
//  Created by information on 2018/3/14.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    PersonCenterServiceSignIn,
    PersonCenterServiceInviteFriend,
    PersonCenterServiceDiscount,
    PersonCenterServiceBindBoss,
    PersonCenterServiceConstruction,
    PersonCenterServiceOrder,
    PersonCenterServietScoreMall,
    PersonCenterServiceCertificate
} PersonCenterServiceType;

@interface SPServiceItem : NSObject

/** 服务类型 */
@property (nonatomic, assign) PersonCenterServiceType serviceType;
/** 图片 */
@property (nonatomic, copy) NSString *iconImage;
/** 文字 */
@property (nonatomic, copy) NSString *gridTitle;

@end
