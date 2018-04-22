//
//  ViewController.m
//  DeeSwitch
//
//  Created by Dee on 2018/4/21.
//  Copyright © 2018年 Dee. All rights reserved.
//

#import "ViewController.h"
#import "DeeSwitch.h"
@interface ViewController ()
@property(nonatomic,strong) UIButton * sw;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//
//    UIButton  *sw = [[UIButton alloc] init];
//    [sw setTitle:@"s" forState:UIControlStateNormal];
//    [sw setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [sw setBackgroundColor:[UIColor blueColor]];
//    sw.frame = CGRectMake(10, 10, 100, 100);
//    [sw addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchDown];
//
//    [sw addTarget:self action:@selector(upAction) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
//    [self.view addSubview:sw];
//    sw.center = self.view.center;
//    self.sw = sw;
    DeeSwitch *sw = [[DeeSwitch alloc] initWithFrame:CGRectMake(20.0, 129.0, 255.0, 155.0)];
//    sw.frame = CGRectMake(0, 0, 100, 100);
    sw.center = self.view.center;
    [self.view addSubview:sw];
}

- (void)tapAction {
    [UIView animateWithDuration:0.25 animations:^{
        CGAffineTransform  locasl = CGAffineTransformMakeTranslation( 100,0);
        self.sw.transform = locasl;
    } completion:^(BOOL finished) {

    }];
}

- (void)upAction {
    [UIView animateWithDuration:0.25 animations:^{
        CGAffineTransform  locasl = CGAffineTransformMakeTranslation( 0,100);
        self.sw.transform = locasl;
    } completion:^(BOOL finished) {

    }];
}

@end
