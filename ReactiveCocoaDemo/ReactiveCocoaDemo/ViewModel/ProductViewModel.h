//
//  ProductViewModel.h
//  ReactiveCocoaDemo
//
//  Created by kkmac on 2017/12/18.
//  Copyright © 2017年 kkmac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
@interface ProductViewModel : NSObject
@property(copy,nonatomic)NSString *pro_id;
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *modify_date;
@property(nonatomic,strong)RACCommand *getProductsCommand;
@property(nonatomic,strong)RACSubject *getProductsRefresh;
@end
