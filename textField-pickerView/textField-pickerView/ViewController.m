//
//  ViewController.m
//  textField-pickerView
//
//  Created by 侯仕奇 on 16/9/23.
//  Copyright © 2016年 HSQI. All rights reserved.
//

#import "ViewController.h"
#import "AddressController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // backgroundColor
    self.view.backgroundColor = [UIColor magentaColor];
    // add testBtn
    [self addTestBtn];
}

// add testBtn
- (void)addTestBtn {
    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    // 监听按钮的点击事件
    [testBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:testBtn];
     
    testBtn.center = self.view.center;
}

- (void)btnClick {
    
    UIViewController *toVC = [AddressController new];
    
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:toVC];
    
    [self presentViewController:naviVC animated:YES completion:nil];
}


@end
