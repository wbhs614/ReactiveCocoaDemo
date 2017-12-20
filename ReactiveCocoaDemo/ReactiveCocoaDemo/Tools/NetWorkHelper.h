//
//  NetWorkHelper.h
//  ReactiveCocoaDemo
//
//  Created by kkmac on 2017/12/16.
//  Copyright © 2017年 kkmac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface NetWorkHelper : NSObject
/**
 登录
 
 @param params 参数
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
+ (void)loginRequestWithParams:(NSDictionary *)params successBlock:(void(^)(NSNumber *code))successBlock failureBlock:(void(^)(NSNumber *coed))failureBlock;

/**
 获取商品
 @param params 参数
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+(void)getProductsWithParams:(NSDictionary *)params successBlock:(void(^)(id responData,NSNumber *code))successBlock failureBlock:(void(^)(NSNumber *code))failBlock;

@end
