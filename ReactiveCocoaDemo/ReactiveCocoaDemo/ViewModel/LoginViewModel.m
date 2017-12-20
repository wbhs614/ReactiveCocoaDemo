//
//  LoginViewModel.m
//  ReactiveCocoaDemo
//
//  Created by kkmac on 2017/12/16.
//  Copyright © 2017年 kkmac. All rights reserved.
//

#import "LoginViewModel.h"
#import <ReactiveCocoa/RACCommand.h>
#import "LoginViewModel.h"
#import "NetWorkHelper.h"

@implementation LoginViewModel
-(instancetype)init {
    self=[super init];
    if (self) {
        @weakify(self);
        [self.loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
            @strongify(self);
            /*通知*/
            NSString *str=(NSString *)x;
            NSLog(@"tempStr:%@",str);
            [self.updateNotifiteSubject sendNext:x];
        }];
    }
    return self;
}

-(RACCommand *)loginCommand {
    if (!_loginCommand) {
        _loginCommand=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                //开始网络请求
                [NetWorkHelper loginRequestWithParams:input successBlock:^(NSNumber *code) {
                    [subscriber sendNext:code];
                    [subscriber sendCompleted];
                } failureBlock:^(NSNumber *code) {
                     [subscriber sendNext:code];
                    [subscriber sendCompleted];
                }];
                return [RACDisposable disposableWithBlock:^{
                    NSLog(@"信号被成功销毁");
                }];
            }];
        }];
    }
    return _loginCommand;
}

-(RACSubject *)updateNotifiteSubject {
    if (_updateNotifiteSubject==nil) {
        _updateNotifiteSubject=[RACSubject subject];
    }
    return _updateNotifiteSubject;
}
@end
