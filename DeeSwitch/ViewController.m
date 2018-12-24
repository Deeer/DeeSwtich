//
//  ViewController.m
//  DeeSwitch
//
//  Created by Dee on 2018/4/21.
//  Copyright © 2018年 Dee. All rights reserved.
//

#import "ViewController.h"
#import "DeeSwitch.h"
#import "DeePlayerManager.h"
@interface ViewController ()
@property(nonatomic,strong) DeeSwitch * sw;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 预加载音效
    [[DeePlayerManager shareInstance] prepareSound];
    // 添加视图
    DeeSwitch *sw = [[DeeSwitch alloc] initWithFrame:CGRectMake(20.0, 129.0, 255.0, 155.0)];
    sw.center = self.view.center;
    self.sw = sw;
    [self.view addSubview:sw];

    // 添加事件监听
    [self addEventListener];

}

- (void)viewWillLayoutSubviews {
    self.sw.center = self.view.center;
}

#pragma mark - privateMethod
- (void)addEventListener {
    [self.sw addTarget:self action:@selector(tapUpAction) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    [self.sw addTarget:self action:@selector(tapDownAction) forControlEvents:UIControlEventTouchDown];
}


#pragma mark - eventRespond
- (void)tapUpAction {
    NSLog(@"%s",__func__);
}

- (void)tapDownAction {
    NSLog(@"%s",__func__);
}


@end
