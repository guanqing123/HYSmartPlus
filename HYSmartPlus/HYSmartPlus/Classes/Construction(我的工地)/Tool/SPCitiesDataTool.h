//
//  SPCitiesDataTool.h
//  HYSmartPlus
//
//  Created by information on 2018/5/4.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPCitiesDataTool : NSObject

+ (instancetype)sharedManager;
- (void)requestGetData;

//查询出所有的省
- (NSMutableArray *)queryAllProvince;

//根据areaLevel级别,省ID(sheng)  ,查询 市
- (NSMutableArray *)queryAllRecordWithShengID:(NSString *) sheng;

//根据areaLevel级别,省ID(sheng) , 市ID(di) ,查询 县
- (NSMutableArray *)queryAllRecordWithShengID:(NSString *) sheng cityID:(NSString *)di;

@end
