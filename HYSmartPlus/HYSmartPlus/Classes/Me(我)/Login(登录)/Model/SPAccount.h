//
//  SPAccount.h
//  HYSmartPlus
//
//  Created by information on 2017/9/11.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPAccount : NSObject <NSCoding>
@property (nonatomic, copy) NSString *telphone;
@property (nonatomic, assign) int score;
@property (nonatomic, copy) NSString *nickname;
@end
