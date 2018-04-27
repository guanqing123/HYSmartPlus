//
//  SPPersonCenterTool.m
//  HYSmartPlus
//
//  Created by information on 2018/4/23.
//  Copyright © 2018年 hongyan. All rights reserved.
//

#import "SPPersonCenterTool.h"
#import "MJExtension.h"
#import "SPHttpTool.h"

@implementation SPPersonCenterTool

+ (void)getPersonScore:(SPPersonScoreParam *)personScoreParam success:(void (^)(SPPersonScoreResult *))success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[personScoreParam.appseq,personScoreParam.trcode,personScoreParam.trdate] forKeys:@[@"appseq",@"trcode",@"trdate"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : personScoreParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    
    [SPHttpTool postWithURL:SPURL params:parameter success:^(id json) {
        if ([[[json objectForKey:@"header"] objectForKey:@"succflag"] isEqualToString:@"1"]) {
            SPPersonScoreResult *result = [SPPersonScoreResult mj_objectWithKeyValues:[json objectForKey:@"data"]];
            success(result);
        }else{
            SPPersonScoreResult *result = [SPPersonScoreResult result];
            result.error = YES;
            result.errorMsg = [NSString stringWithFormat:@"%@",[[json objectForKey:@"header"] objectForKey:@"errorMsg"]];
            success(result);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)getProblem:(SPProblemParam *)problemParam success:(void (^)(SPProblemResult *))success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[problemParam.appseq,problemParam.trcode,problemParam.trdate] forKeys:@[@"appseq",@"trcode",@"trdate"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : problemParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    
    [SPHttpTool postWithURL:XKURL params:parameter success:^(id json) {
        if ([[[json objectForKey:@"header"] objectForKey:@"succflag"] isEqualToString:@"1"]) {
            NSArray *list = [SPProblem mj_objectArrayWithKeyValuesArray:[json objectForKey:@"data"]];
            SPProblemResult *result = [SPProblemResult result];
            result.list =  list;
            success(result);
        }else{
            SPProblemResult *result = [SPProblemResult result];
            result.error = YES;
            result.errorMsg = [NSString stringWithFormat:@"%@",[[json objectForKey:@"header"] objectForKey:@"errorMsg"]];
            success(result);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)doSignIn:(SPSignInParam *)signInParam success:(void (^)(SPSignInResult *))success failure:(void (^)(NSError *))failure {
    NSDictionary *headerDict = [NSDictionary dictionaryWithObjects:@[signInParam.appseq,signInParam.trcode,signInParam.trdate] forKeys:@[@"appseq",@"trcode",@"trdate"]];
    
    NSDictionary *dict = @{@"header" : headerDict, @"data" : signInParam.mj_keyValues};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary *parameter = @{@"content" : jsonString};
    
    [SPHttpTool postWithURL:SPURL params:parameter success:^(id json) {
        if ([[[json objectForKey:@"header"] objectForKey:@"succflag"] isEqualToString:@"1"]) {
            SPSignInResult *result = [SPSignInResult mj_objectWithKeyValues:[json objectForKey:@"data"]];
            success(result);
        }else{
            SPSignInResult *result = [SPSignInResult result];
            result.error = YES;
            result.errorMsg = [NSString stringWithFormat:@"%@",[[json objectForKey:@"header"] objectForKey:@"errorMsg"]];
            success(result);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
