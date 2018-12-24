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
@property(nonatomic,strong) DeeSwitch * sw;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    DeeSwitch *sw = [[DeeSwitch alloc] initWithFrame:CGRectMake(20.0, 129.0, 255.0, 155.0)];
    sw.center = self.view.center;
    self.sw = sw;
    
    [self.view addSubview:sw];
}

- (void)viewWillLayoutSubviews {
    self.sw.center = self.view.center;
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
