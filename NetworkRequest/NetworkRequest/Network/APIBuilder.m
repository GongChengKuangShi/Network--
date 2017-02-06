//
//  APIBuilder.m
//  NetworkRequest
//
//  Created by xiangronghua on 2017/2/6.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "APIBuilder.h"
#import "NSString+Unitl.h"

//根据自己的ID进行配置
static NSString *sole = @"d0c2993aaaff1af2bf3725f858fb8b5b";

@implementation APIBuilder

+ (NSString *)getKeyString:(NSArray *)list {
    NSMutableString *mString = [[NSMutableString alloc] init];
    for (NSString *string in list) {
        [mString appendString:string];
    }
    [mString appendString:sole];
    NSString *keyStr = [mString md5ToString];
    return keyStr;
}

+ (NSString*)saveAppBugCollect{
    return @"appHome/saveAppBugCollect";
}

@end
