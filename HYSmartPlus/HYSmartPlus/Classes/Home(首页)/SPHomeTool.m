//
//  SPHomeTool.m
//  HYSmartPlus
//
//  Created by information on 2017/9/19.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPHomeTool.h"
#import "SPHttpTool.h"
#import "MJExtension.h"

@implementation SPHomeTool

+ (void)homeSliderWithParam:(SPSliderParam *)sliderParam success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[sliderParam.appseq,sliderParam.trcode,sliderParam.trdate] forKeys:@[@"appseq",@"trcode",@"trdate"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : sliderParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    [SPHttpTool postWithURL:XKURL params:parameter success:^(id json) {
        if (success) {
            NSArray *dictArray = [[json objectForKey:@"data"] objectForKey:@"list"];
            NSArray *result = [SPSliderResult mj_objectArrayWithKeyValuesArray:dictArray];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
