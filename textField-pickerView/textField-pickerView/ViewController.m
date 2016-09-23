//
//  ViewController.m
//  textField-pickerView
//
//  Created by 侯仕奇 on 16/9/23.
//  Copyright © 2016年 HSQI. All rights reserved.
//

#import "ViewController.h"

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
    
    [self.view addSubview:testBtn];
     
    testBtn.center = self.view.center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
