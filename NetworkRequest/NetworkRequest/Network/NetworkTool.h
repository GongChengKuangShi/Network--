//
//  NetworkTool.h
//  NetworkRequest
//
//  Created by xiangronghua on 2017/2/6.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NetworkTool;

@protocol NetworkToolDelegate <NSObject>
@optional
- (void)networkStartRequest:(NetworkTool*)networkTool;
- (void)networkDidRequest:(NetworkTool*)networkTool didReceiveData:(NSDictionary*)data;
- (void)networkErrorRequest:(NetworkTool*)networkTool didReceiveError:(NSString*)error;

@end

@interface NetworkTool : NSObject

@property (weak, nonatomic) id<NetworkToolDelegate> delegate;

/** GET请求*/
- (void)getWithUrlString:(NSString *)string
              parameters:(NSArray *)parameterArray
            unParameters:(NSDictionary *)dictionary;

/** POST请求*/
- (void)postWithUrlString:(NSString *)string
               parameters:(NSArray *)parameterArray
             unParameters:(NSDictionary *)dictionary;

/** 图片上传*/
- (void)postImageWithURLString:(NSString *)urlString
               parameters:(NSArray *)parameterArray
                 withData:(NSData *)imageData;

/** BUG收集*/
- (void)postBugWithURLString:(NSString *)urlString
            parametersDic:(NSDictionary *)parameter
             unParameters:(NSDictionary *)unParameters;


/** 关闭请求*/
- (void)cancel;



@end
