//
//  NetWorkHelper.m
//  ReactiveCocoaDemo
//
//  Created by kkmac on 2017/12/16.
//  Copyright © 2017年 kkmac. All rights reserved.
//

#import "NetWorkHelper.h"
#import "KKHttpSession.h"
@implementation NetWorkHelper
/**
 登录
 @param params 参数
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
+ (void)loginRequestWithParams:(NSDictionary *)params
                  successBlock:(void(^)(NSNumber *code))successBlock
                  failureBlock:(void(^)(NSNumber *coed))failureBlock{
    
    [KKHttpSession requestWithRequestType:HTTPSRequestTypePost urlString:@"http://161.44.84.82:2693/member/login.php?act=userLogin" paraments:params completeBlock:^(id  _Nullable object, NSError * _Nullable error) {
        NSLog(@"object:%@",(NSDictionary *)object);
        if (object) {
            NSNumber *code=[((NSDictionary *)object)objectForKey:@"return_code"];
            NSString *message=[((NSDictionary *)object)objectForKey:@"return_msg"];
            if (code.integerValue==1&&[message isEqualToString:@"SUCCESS"]) {
                successBlock(code);
            }
            else {
                failureBlock(code);
            }
        }
        else {
            failureBlock(@1000);
        }
    }];
}

/**
 获取商品
 @param params 参数
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+(void)getProductsWithParams:(NSDictionary *)params successBlock:(void(^)(id responData,NSNumber *code))successBlock failureBlock:(void(^)(NSNumber *code))failBlock {
    [KKHttpSession requestWithRequestType:HTTPSRequestTypePost urlString:@"http://161.44.184.82:2693/mall/list.php?act=getMalllist" paraments:params completeBlock:^(id  _Nullable object, NSError * _Nullable error) {
        if (object) {
            NSNumber *code=[((NSDictionary *)object)objectForKey:@"return_code"];
            NSString *message=[((NSDictionary *)object)objectForKey:@"return_msg"];
            NSArray *results=[((NSDictionary *)object)objectForKey:@"results"];
            if (code.integerValue==1&&[message isEqualToString:@"SUCCESS"]) {
                successBlock(results,code);
            }
            else {
                failBlock(code);
            }
    }
        else {
            failBlock(@1000);
        }
    }];
}
@end
