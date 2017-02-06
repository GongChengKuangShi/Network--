//
//  ViewController.m
//  NetworkRequest
//
//  Created by xiangronghua on 2017/2/6.
//  Copyright © 2017年 xiangronghua. All rights reserved.
//

#import "ViewController.h"
#import "NetworkTool.h"

@interface ViewController ()<NetworkToolDelegate>
@property (strong, nonatomic) NetworkTool *tool;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    _tool = [[NetworkTool alloc] init];
    _tool.delegate = self;
    [self setNetwork];
}



- (void)setNetwork {
    NSDictionary *dictionaryList2 = @{@"status":@"2"};
    NSDictionary *dictionaryList3 = @{@"page":@"1"};
    NSDictionary *dictionaryList4 = @{@"pageSize":@"100"};
    NSArray *array = @[dictionaryList2,dictionaryList3,dictionaryList4];
    NSDictionary *parameter = @{@"mid" : @"2953"};
    [self.tool postWithUrlString:@"appInvest/loanList" parameters:array unParameters:parameter];
}

#pragma mark -- 数据请求
#pragma mark NetworkDelegate
- (void)networkStartRequest:(NetworkTool *)networkTool {
    NSLog(@"----");
}

- (void)networkDidRequest:(NetworkTool *)networkTool didReceiveData:(NSDictionary *)data {
    NSLog(@"data == %@",data);
}

- (void)networkErrorRequest:(NetworkTool *)networkTool didReceiveError:(NSString *)error {
    NSLog(@"+++++");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
