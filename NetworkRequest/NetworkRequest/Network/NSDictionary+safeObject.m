//
//  NSDictionary+safeObject.m
//  NetworkRequest
//
//  Created by xiangronghua on 2017/2/6.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "NSDictionary+safeObject.h"

#define checkNull(__X__)  (__X__) == [NSNull null] || (__X__) == nil ? @"" : [NSString stringWithFormat:@"%@", (__X__)]

@implementation NSDictionary (safeObject)

- (NSString *)safeObjectForKey:(id)key{
    return checkNull([self objectForKey:key]);
}

@end
