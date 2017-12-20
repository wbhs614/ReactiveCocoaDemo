//
//  KKHttpSession.m
//  Stomatology
//
//  Created by 李圣杰 on 2017/4/13.
//  Copyright © 2017年 cn.kekang.com. All rights reserved.
//

#import "KKHttpSession.h"
#import "AFNetworking.h"
#import "KKHttpSessionManager.h"
#import "AppDelegate.h"

@implementation KKHttpSession
/**
 请求数据的GET方法
 @param urlString api路径
 @param paraments 请求参数
 @param completeBlock 完成后的block
 @return 响应内容
 */
+ (nullable NSURLSessionDataTask *)GET:(nonnull NSString *)urlString
                             paraments:(nullable id)paraments
                         completeBlock:(nullable completeBlock)completeBlock {
    /*进行字符转义*/
    NSString *utf8UrlStr=[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [[KKHttpSessionManager sharedManager] GET:utf8UrlStr
                                       parameters:paraments
                                         progress:^(NSProgress * _Nonnull downloadProgress) {
                                         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                             NSLog(@"%@", responseObject);
                                             NSDictionary *dict=nil;
                                             if ([responseObject isKindOfClass:[NSData class]]) {
                                                 dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                                             }
                                             else {
                                                 dict=(NSDictionary *)responseObject;
                                             }
                                             NSLog(@"dict start ----\n%@   \n ---- end  -- ", dict);
                                             if (dict&&dict.allKeys.count>0) {
                                                 completeBlock(dict,nil);
                                             }
                                             else {
                                                 
                                                 completeBlock(nil,nil);
                                             }
                                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                             completeBlock(nil,error);
                                         }];
}

/**
 请求数据的POST方法
 @param urlString api路径
 @param paraments 请求参数
 @param completeBlock 完成后的block
 @return 响应内容
 */
+ (nullable NSURLSessionDataTask *)POST:(nonnull NSString *)urlString
                              paraments:(nullable id)paraments
                          completeBlock:(nullable completeBlock)completeBlock {
    [KKHttpSessionManager sharedManager].requestSerializer = [AFHTTPRequestSerializer serializer];//请求
    [KKHttpSessionManager sharedManager].responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    return [[KKHttpSessionManager sharedManager]POST:urlString parameters:paraments progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict=nil;
        if ([responseObject isKindOfClass:[NSData class]]) {
        dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        else {
            dict=(NSDictionary *)responseObject;
        }
        NSLog(@"dict start ----\n%@   \n ---- end  -- ", dict);
        if (dict&&dict.allKeys.count>0) {
            completeBlock(dict,nil);
        }
        else {
            
            completeBlock(nil,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completeBlock(nil,error);
    }];
}

/**
 上传图片的POST方法
 @param urlString api路径
 @param paraments 请求参数
 @param imageArr 上传图片数组
 @param completeBlock 完成后的block
 @return 响应内容
 */
+ (nullable NSURLSessionDataTask *)POST:(nonnull NSString *)urlString
                              paraments:(nullable id)paraments
                               imageArr:(nonnull NSArray *)imageArr
                          completeBlock:(nullable completeBlock)completeBlock {
    [KKHttpSessionManager sharedManager].requestSerializer = [AFHTTPRequestSerializer serializer];//请求
    [KKHttpSessionManager sharedManager].responseSerializer = [AFHTTPResponseSerializer serializer];//响应
    return [[KKHttpSessionManager sharedManager]POST:urlString parameters:paraments constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < imageArr.count; i ++) {
            NSData *imageData =UIImageJPEGRepresentation(imageArr[i],0.5);
            [formData appendPartWithFileData:imageData
                                        name:[NSString stringWithFormat:@"picture%d",i]
                                    fileName:[NSString stringWithFormat:@"image%d.jpg",i]
                                    mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dict start ----\n%@   \n ---- end  -- ", dict);
        completeBlock(dict,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completeBlock(nil,error);
    }];
}

/**
 请求数据的方法
 @param type 请求数据的方式（POST和GET）
 @param urlString api路径
 @param paraments 请求参数
 @param completeBlock 完成后的block
 @return 响应内容
 */
+ (nullable NSURLSessionDataTask *)requestWithRequestType:(HTTPSRequestType)type
                                                urlString:(nonnull NSString *)urlString
                                                paraments:(nullable id)paraments
                                            completeBlock:(nullable completeBlock)completeBlock{
    switch (type) {
        case HTTPSRequestTypeGet:
        {
            return [KKHttpSession GET:urlString paraments:paraments completeBlock:^(NSDictionary * _Nullable object, NSError * _Nullable error) {
                completeBlock(object,error);
            }];
        }
        case HTTPSRequestTypePost:
        {
            return [KKHttpSession POST:urlString paraments:paraments completeBlock:^(NSDictionary * _Nullable object, NSError * _Nullable error) {
                completeBlock(object,error);
            }];
        }
    }
}

@end
