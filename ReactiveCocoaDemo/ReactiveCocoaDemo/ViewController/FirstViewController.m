//
//  FirstViewController.m
//  ReactiveCocoaDemo
//
//  Created by kkmac on 2017/12/16.
//  Copyright © 2017年 kkmac. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "SecondViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LoginViewModel.h"
#import <ReactiveCocoa/UIRefreshControl+RACCommandSupport.h>

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *testItem;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordField;
@property (nonatomic,strong) LoginViewModel *viewModel;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel=[[LoginViewModel alloc]init];
    //点击item的回调
    self.testItem.rac_command=[[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            SecondViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
            [self.navigationController pushViewController:vc animated:YES];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"信号被销毁");
            }];
        }];
    }];
    //姓名
    [[self.nameTextField.rac_textSignal filter:^BOOL(id value) {
        NSString *str=(NSString *)value;
        return [str.lowercaseString isEqualToString:@"wb0805"];
    }]subscribeNext:^(id x) {
        NSLog(@"name is %@",x);
    }];
    RAC(self.viewModel,name)=self.nameTextField.rac_textSignal;
    RAC(self.viewModel,passWord)=self.passWordField.rac_textSignal;
    //登陆触发的事件
    [self.viewModel.updateNotifiteSubject subscribeNext:^(id x) {
        NSNumber *result=(NSNumber *)x;
        if (result.integerValue==1) {
            SecondViewController *secondVC=[self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
            [self.navigationController pushViewController:secondVC animated:YES];
        }
        else {
            NSLog(@"登陆失败");
        }
    }];
    
}

- (IBAction)clickLoginBtn:(id)sender {
    if (self.viewModel.name.length>0&&self.viewModel.passWord.length>0) {
        NSMutableDictionary *params=[NSMutableDictionary dictionary];
        [params setObject:self.viewModel.name forKey:@"username"];
        [params setObject:self.viewModel.passWord forKey:@"password"];
        [params setObject:@"324343344334edfdnugruslfelsues" forKey:@"app_uuid"];
        [self.viewModel.loginCommand execute:params];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
