//
//  SecondViewController.m
//  ReactiveCocoaDemo
//
//  Created by kkmac on 2017/12/16.
//  Copyright © 2017年 kkmac. All rights reserved.
//

#import "SecondViewController.h"
#import "ProductViewModel.h"

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)ProductViewModel *viewModel;
@property (strong,nonatomic)NSArray *dataArray;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewModel];
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    [dict setObject:@"20170622083653595636" forKey:@"protree_id"];
    [dict setObject:@"2b6ceeae38f44e2ab2c5f0d4e1426fc5" forKey:@"app_uuid"];
    [self.viewModel.getProductsCommand execute:dict];
}

-(void)bindViewModel {
    [self.viewModel.getProductsRefresh subscribeNext:^(id x) {
        if ([x isKindOfClass:[NSArray class]]) {
            self.dataArray=(NSArray *)x;
            [self.tableView reloadData];
        }
        else {
            if ([x isKindOfClass:[NSNumber class]]) {
                NSNumber *code=(NSNumber *)x;
                if (code.integerValue==1) {
                    
                }
                else {
                    
                }
            }
        }
    }];
    [[self.tableView rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate)]subscribeNext:^(id x) {
        NSLog(@"点击了cell");
    }];
    self.tableView.delegate=nil;
    self.tableView.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(ProductViewModel *)viewModel {
    if (_viewModel==nil) {
        _viewModel=[[ProductViewModel alloc]init];
    }
    return _viewModel;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
    UILabel *nameLabel=[cell.contentView viewWithTag:1];
    UILabel *priceLabel=[cell.contentView viewWithTag:2];
    UILabel *saleLabel=[cell.contentView viewWithTag:3];
    NSDictionary *dict=self.dataArray[indexPath.row];
    NSString *name=[dict objectForKey:@"name"];
    NSNumber *price=[dict objectForKey:@"vip_price"];
    NSString *sale_num=[dict objectForKey:@"sale_num"];
    if (name!=nil) {
        nameLabel.text=name;
    }
    if (price!=nil){
        priceLabel.text=price.stringValue;
    }
    if (saleLabel!=nil) {
        saleLabel.text=sale_num;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
@end
