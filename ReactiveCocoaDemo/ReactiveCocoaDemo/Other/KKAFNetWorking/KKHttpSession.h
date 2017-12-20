//
//  KKHttpSession.h
//  Stomatology
//
//  Created by 李圣杰 on 2017/4/13.
//  Copyright © 2017年 cn.kekang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//请求类型
typedef NS_ENUM(NSUInteger,HTTPSRequestType)
{
    HTTPSRequestTypeGet = 0,
    HTTPSRequestTypePost = 1
};
//请求返还结果block
typedef void(^completeBlock)( id _Nullable object,NSError * _Nullable error);

@interface KKHttpSession : NSObject

/**
 请求数据的GET方法
 @param urlString api路径
 @param paraments 请求参数
 @param completeBlock 完成后的block
 @return 响应内容
 */
+ (nullable NSURLSessionDataTask *)GET:(nonnull NSString *)urlString
                             paraments:(nullable id)paraments
                         completeBlock:(nullable completeBlock)completeBlock;

/**
 请求数据的POST方法
 @param urlString api路径
 @param paraments 请求参数
 @param completeBlock 完成后的block
 @return 响应内容
 */
+ (nullable NSURLSessionDataTask *)POST:(nonnull NSString *)urlString
                              paraments:(nullable id)paraments
                          completeBlock:(nullable completeBlock)completeBlock;

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
                          completeBlock:(nullable completeBlock)completeBlock;

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
                                            completeBlock:(nullable completeBlock)completeBlock;
@end
