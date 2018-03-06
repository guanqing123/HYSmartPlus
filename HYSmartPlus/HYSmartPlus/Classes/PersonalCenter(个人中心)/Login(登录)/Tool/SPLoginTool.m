//
//  SPLoginTool.m
//  HYSmartPlus
//
//  Created by information on 2018/3/5.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPLoginTool.h"
#import "MJExtension.h"
#import "SPHttpTool.h"

@implementation SPLoginTool

+ (void)getVerifyCode:(SPCodeParam *)codeParam success:(void (^)(SPCodeResult *codeResult))success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[codeParam.appseq,codeParam.trcode,codeParam.trdate] forKeys:@[@"appseq",@"trcode",@"trdate"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : codeParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    [SPHttpTool postWithURL:SPURL params:parameter success:^(id json) {
        if ([[[json objectForKey:@"header"] objectForKey:@"succflag"] isEqualToString:@"1"]) {
            SPCodeResult *result = [SPCodeResult mj_objectWithKeyValues:[json objectForKey:@"data"]];
            success(result);
        }else{
            SPCodeResult *result = [SPCodeResult result];
            result.error = YES;
            result.errorMsg = [NSString stringWithFormat:@"%@",[[json objectForKey:@"header"] objectForKey:@"errorMsg"]];
            success(result);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)login:(SPLoginParam *)loginParam success:(void (^)())success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[loginParam.appseq,loginParam.trcode,loginParam.trdate] forKeys:@[@"appseq",@"trcode",@"trdate"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : loginParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    [SPHttpTool postWithURL:SPURL params:parameter success:^(id json) {
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
