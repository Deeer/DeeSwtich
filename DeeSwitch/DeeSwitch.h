//
//  DeeSwitch.h
//  DeeSwitch
//
//  Created by Dee on 2018/4/21.
//  Copyright © 2018年 Dee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeeSwitch : UIControl

@property(nullable,nonatomic,strong) UIColor * onTintColor;

@property(nullable,nonatomic,strong) UIColor * tintColor;

@property(nullable,nonatomic,strong) UIColor * thumbTintColor;

@property(nullable,nonatomic,strong) UIColor * backGroundColor;

@property(nonatomic,getter=isOn) BOOL on;

- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end
