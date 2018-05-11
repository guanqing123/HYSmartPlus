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
    PersonCenterServiceBindBoss,
    PersonCenterServicePhoneModify
} PersonCenterServiceType;

@interface SPServiceItem : NSObject

/** 服务类型 */
@property (nonatomic, assign) PersonCenterServiceType serviceType;
/** 图片 */
@property (nonatomic, copy) NSString *iconImage;
/** 文字 */
@property (nonatomic, copy) NSString *gridTitle;

@end
