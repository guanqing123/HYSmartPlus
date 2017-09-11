//
//  SPAccountTool.m
//  HYSmartPlus
//
//  Created by information on 2017/9/11.
//  Copyright © 2017年 hongyan. All rights reserved.
//

#import "SPAccount.h"
#import "SPAccountTool.h"

#define SPAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation SPAccountTool

+ (void)saveAccount:(SPAccount *)account
{
    GQLog(@"path = %@",SPAccountFile);
    BOOL isSuccess = [NSKeyedArchiver archiveRootObject:account toFile:SPAccountFile];
    if (isSuccess) {
        GQLog(@"写入成功");
    }
}

+ (SPAccount *)account
{
    SPAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:SPAccountFile];
    return account;
}

+ (void)deleteAccount {
    //创建一个文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExists = [fileManager fileExistsAtPath:SPAccountFile];
    if (isExists) {
        GQLog(@"文件存在");
        BOOL isDele = [fileManager removeItemAtPath:SPAccountFile error:nil];
        if (isDele) {
            GQLog(@"删除成功");
        }else{
            GQLog(@"删除失败");
        }
    }
}

@end
