//
//  NSString+Unitl.m
//  NetworkRequest
//
//  Created by xiangronghua on 2017/2/6.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "NSString+Unitl.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Unitl)

- (NSString *)md5ToString {
    const char *string = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, (CC_LONG)strlen(string), result);
    NSMutableString *retString = [[NSMutableString alloc] init];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [retString appendFormat:@"%02x",result[i]];
    }
    return retString;
}

- (NSString*)unicodeToString{
    NSData *unicodedStringData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *string = [[NSString alloc] initWithData:unicodedStringData encoding:NSNonLossyASCIIStringEncoding];
    return string;
}

@end
