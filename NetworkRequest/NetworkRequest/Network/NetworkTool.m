//
//  NetworkTool.m
//  NetworkRequest
//
//  Created by xiangronghua on 2017/2/6.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "NetworkTool.h"
#import "AFNetworking.h"
#import "NSDictionary+safeObject.h"
#import "APIBuilder.h"
#import "DeviceHardware.h"
#import "NSString+Unitl.h"

@interface NetworkTool () {
    
    AFURLSessionManager *_manager;
    NSDictionary *_parameters;
    NSMutableURLRequest *_request;
    NSURLSessionDataTask *_sessionDataTask;
    NSString *_describe;
    
}

@end

@implementation NetworkTool

- (void)getWithUrlString:(NSString *)string
              parameters:(NSArray *)parameterArray
            unParameters:(NSDictionary *)dictionary {
    //md5加密
    _parameters = [self md5Parameter:parameterArray withUrlString:string];
    NSDictionary *requestDictionary = [self mergeParameter:_parameters unParameter:dictionary];
    string = [BaseUrl stringByAppendingPathComponent:string];
    _request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                             URLString:string
                                                            parameters:requestDictionary
                                                                 error:nil];
    
    [_request setTimeoutInterval:10];
    _sessionDataTask = [_manager dataTaskWithRequest:_request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (responseObject) {
            if ([_delegate respondsToSelector:@selector(networkDidRequest:didReceiveData:)]) {
                [_delegate networkDidRequest:self didReceiveData:responseObject];
            }
        }
        if (error) {
            _describe = error.description;
            [self performSelector:@selector(setReceiveErrer) withObject:nil afterDelay:2.0f];
            if ([_delegate respondsToSelector:@selector(networkErrorRequest:didReceiveError:)]) {
                [_delegate networkErrorRequest:self didReceiveError:error.description];
            }
            if (error.code == NSURLErrorTimedOut) {
                [self sendTimeOut];
            }
        }
    }];
    [_sessionDataTask resume];
    if ([_delegate respondsToSelector:@selector(networkStartRequest:)]) {
        [_delegate networkStartRequest:self];
    }
}

- (void)postWithUrlString:(NSString *)string
               parameters:(NSArray *)parameterArray
             unParameters:(NSDictionary *)dictionary {
    _parameters = [self md5Parameter:parameterArray withUrlString:string];
    NSDictionary *requestDictionary = [self mergeParameter:_parameters unParameter:dictionary];
    string = [BaseUrl stringByAppendingPathComponent:string];
    _request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                                                             URLString:string
                                                            parameters:requestDictionary
                                                                 error:nil];
    [_request setTimeoutInterval:10];
    _sessionDataTask = [_manager dataTaskWithRequest:_request
                                   completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
        if (responseObject) {
            if ([_delegate respondsToSelector:@selector(networkDidRequest:didReceiveData:)]) {
                    [_delegate networkDidRequest:self didReceiveData:responseObject];
            }
        }
        if (error) {
            _describe = error.description;
            [self performSelector:@selector(setReceiveErrer) withObject:nil afterDelay:2.0f];
            if ([_delegate respondsToSelector:@selector(networkErrorRequest:didReceiveError:)]) {
                [error.description unicodeToString];
                [_delegate networkErrorRequest:self didReceiveError:error.description];
            }
            if (error.code == NSURLErrorTimedOut) {
                [self sendTimeOut];
            }
        }
    }];
    [_sessionDataTask resume];
    if ([_delegate respondsToSelector:@selector(networkStartRequest:)]) {
        [_delegate networkStartRequest:self];
    }
}

- (void)postImageWithURLString:(NSString *)urlString
                    parameters:(NSArray *)parameterArray
                      withData:(NSData *)imageData {
    
    _parameters = [self md5Parameter:parameterArray withUrlString:urlString];
    NSString *url = [BaseUrl stringByAppendingPathComponent:urlString];
    [[AFHTTPSessionManager manager] POST:url parameters:_parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"22.jpg" mimeType:@"image/jpg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject) {
            if ([_delegate respondsToSelector:@selector(networkDidRequest:didReceiveData:)]) {
                [_delegate networkDidRequest:self didReceiveData:responseObject];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            _describe = error.description;
            [self performSelector:@selector(setReceiveErrer) withObject:nil afterDelay:2.0f];
            if ([_delegate respondsToSelector:@selector(networkErrorRequest:didReceiveError:)]) {
                [error.description unicodeToString];
                [_delegate networkErrorRequest:self didReceiveError:error.description];
            }
            if (error.code == NSURLErrorTimedOut) {
                [self sendTimeOut];
            }
        }
    }];
    if ([_delegate respondsToSelector:@selector(networkStartRequest:)]) {
        [_delegate networkStartRequest:self];
    }
    
}

- (void)postBugWithURLString:(NSString *)urlString
               parametersDic:(NSDictionary *)parameter
                unParameters:(NSDictionary *)unParameters {
    
    NSDictionary *requestDictionary = [self mergeParameter:parameter unParameter:unParameters];
    urlString = [BaseUrl stringByAppendingPathComponent:urlString];
    _request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                                                             URLString:urlString
                                                            parameters:requestDictionary
                                                                 error:nil];
    _sessionDataTask = [_manager dataTaskWithRequest:_request
                                   completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error){
                                       if (responseObject) {
                                       }
                                       if (error) {
                                       }
                                   }];
    [_sessionDataTask resume];
}

- (void)cancel {
    [_sessionDataTask cancel];
}

- (void)sendTimeOut {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RequstStatus" object:nil];
}


/** BUG搜集*/
- (void)setReceiveErrer{
    NSString *name = @"系统错误";
    NSString *describe = _describe;
    UIDevice *device = [UIDevice currentDevice];
    NSString *version = [device systemVersion];
    NSString *deviceVersion = [DeviceHardware platformString];
    NSString *bundleID = [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    NSDictionary *param = @{
                            @"name" : name,
                            @"describe" : describe,
                            @"reason" : @"",
                            @"client_type" : @"IOS",
                            @"mobile_device" : deviceVersion,
                            @"mobile_sys_version" : version,
                            @"version" : bundleID
                            };
    [self postBugWithURLString:[APIBuilder saveAppBugCollect] parametersDic:param unParameters:nil];
}


- (NSDictionary *)md5Parameter:(NSArray *)parameterArray withUrlString:(NSString *)urlStr {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [array addObject:urlStr];
    for (NSDictionary *dic in parameterArray) {
        NSString *key = [dic.allKeys objectAtIndex:0];
        NSString *value = [NSString stringWithFormat:@"%@",[dic safeObjectForKey:key]];
        [array addObject:value];
        [parameters setObject:value forKey:key];
    }
    NSString *keyStr = [APIBuilder getKeyString:array];
    [parameters setValue:keyStr forKey:@"keyStr"];
    return parameters;
}


- (NSDictionary *)mergeParameter:(NSDictionary *)parameter unParameter:(NSDictionary *)unParameter {
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] initWithDictionary:parameter];
    [mDic addEntriesFromDictionary:unParameter];
    return mDic;
}

@end
