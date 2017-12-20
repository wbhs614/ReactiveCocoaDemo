//
//  KKHttpSessionManager.h
//  Stomatology
//
//  Created by 李圣杰 on 2017/4/13.
//  Copyright © 2017年 cn.kekang.com. All rights reserved.
//

/**
 网络请求的manger
 作用：管理网络请求
 */
#import <AFNetworking/AFNetworking.h>

@interface KKHttpSessionManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end
