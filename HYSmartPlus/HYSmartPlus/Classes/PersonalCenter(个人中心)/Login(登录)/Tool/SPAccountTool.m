//
//  SPAccountTool.m
//  HYSmartPlus
//
//  Created by information on 2017/9/11.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPAccount.h"
#import "SPAccountTool.h"

#define SPLoginResultFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"loginResult.data"]

@implementation SPAccountTool

+ (void)saveLoginResult:(SPLoginResult *)loginResult
{
    BOOL isSuccess = [NSKeyedArchiver archiveRootObject:loginResult toFile:SPLoginResultFile];
    if (isSuccess) {
        GQLog(@"loginResult 写入成功 path = %@",SPLoginResultFile);
    }
}

+ (SPLoginResult *)loginResult
{
    SPLoginResult *loginResult = [NSKeyedUnarchiver unarchiveObjectWithFile:SPLoginResultFile];
    NSLog(@"filePath = %@",SPLoginResultFile);
    return loginResult;
}

+ (void)deleteLoginResult
{
    //创建一个文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExists = [fileManager fileExistsAtPath:SPLoginResultFile];
    if (isExists) {
        BOOL isDele = [fileManager removeItemAtPath:SPLoginResultFile error:nil];
        if (isDele) {
            GQLog(@"%@ 删除成功",SPLoginResultFile);
        }else{
            GQLog(@"%@ 删除失败",SPLoginResultFile);
        }
    }
}

@end
