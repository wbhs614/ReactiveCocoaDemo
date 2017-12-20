//
//  LoginViewModel.h
//  ReactiveCocoaDemo
//
//  Created by kkmac on 2017/12/16.
//  Copyright © 2017年 kkmac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/UIRefreshControl+RACCommandSupport.h>
#import <ReactiveCocoa.h>
@interface LoginViewModel : NSObject
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *passWord;
@property(strong,nonatomic)RACCommand *loginCommand;
@property(strong,nonatomic)RACSubject *updateNotifiteSubject;
@end
