//
//  APIBuilder.h
//  NetworkRequest
//
//  Created by xiangronghua on 2017/2/6.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BaseUrl @"https://www.testhnmgjr.com/mgjr-web-app/V2.0/"

@interface APIBuilder : NSObject

+ (NSString*)saveAppBugCollect;
+ (NSString *)getKeyString:(NSArray *)list;

@end
