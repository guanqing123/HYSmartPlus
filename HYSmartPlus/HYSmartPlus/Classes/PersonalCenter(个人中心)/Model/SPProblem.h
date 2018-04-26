//
//  SPProblem.h
//  HYSmartPlus
//
//  Created by information on 2018/4/26.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPProblem : NSObject

@property (nonatomic, copy) NSString *faq_question;

@property (nonatomic, copy) NSString *faq_solution;

@property (nonatomic, copy) NSString *faq_reason;

@property (assign, nonatomic) BOOL isOpened;

@end
