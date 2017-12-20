//
//  ProductViewModel.m
//  ReactiveCocoaDemo
//
//  Created by kkmac on 2017/12/18.
//  Copyright © 2017年 kkmac. All rights reserved.
//

#import "ProductViewModel.h"
#import "NetWorkHelper.h"
@implementation ProductViewModel
-(instancetype)init {
    if (self=[super init]) {
        [self.getProductsCommand.executionSignals.switchToLatest  subscribeNext:^(id x) {
            [self.getProductsRefresh sendNext:x];
        }];
    }
    return self;
}
-(RACCommand *)getProductsCommand {
    if (_getProductsCommand==nil) {
        _getProductsCommand=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
           return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
               //开始请求数据
               [NetWorkHelper getProductsWithParams:input successBlock:^(id responData, NSNumber *code) {
                   [subscriber sendNext:responData];
                   [subscriber sendCompleted];
               } failureBlock:^(NSNumber *code) {
                   [subscriber sendNext:code];
                   [subscriber sendCompleted];
               }];
                return [RACDisposable disposableWithBlock:^{
                    NSLog(@"请求数据的信号已经销毁了");
                }];
            }];
        }];
    }
    return _getProductsCommand;
}

-(RACSubject *)getProductsRefresh {
    if (_getProductsRefresh==nil) {
        _getProductsRefresh=[RACSubject subject];
    }
    return _getProductsRefresh;
}
@end
