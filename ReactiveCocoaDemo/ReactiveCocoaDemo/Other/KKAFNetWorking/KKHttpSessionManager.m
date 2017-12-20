//
//  KKHttpSessionManager.m
//  Stomatology
//
//  Created by 李圣杰 on 2017/4/13.
//  Copyright © 2017年 cn.kekang.com. All rights reserved.
//

#import "KKHttpSessionManager.h"

static KKHttpSessionManager *_manager;
@implementation KKHttpSessionManager

+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[KKHttpSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    });
    return _manager;
}

#pragma mark - 重写initWithBaseURL
/**
 *  @param url baseUrl
 *  @return 通过重写父类的initWithBaseURL方法,返回网络请求类的实例
 */
-(instancetype)initWithBaseURL:(NSURL *)url{
    if (self = [super initWithBaseURL:url]) {
        /**设置请求超时时间*/
        self.requestSerializer.timeoutInterval = 3;
        /**设置相应的缓存策略*/
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        /**分别设置请求以及相应的序列化器*/
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        self.responseSerializer = response;
        /**复杂的参数类型 需要使用json传值-设置请求内容的类型*/
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        /**设置接受的类型*/
        [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html", nil]];
        /**SSL相关设置**/
        self.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        self.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"POST", @"GET", @"HEAD"]];
        
    }
    return self;
}

@end
