//
//  DeeSwitch.m
//  DeeSwitch
//
//  Created by Dee on 2018/4/21.
//  Copyright © 2018年 Dee. All rights reserved.
//

#import "DeeSwitch.h"

typedef NS_ENUM(NSInteger, k_Path_State) {
    k_Path_State_Off,
    k_Path_State_Mid_Off,
    k_Path_State_Mid_On,
    k_Path_State_On
};

@interface DeeSwitch()

//背景层
@property(nonatomic,strong) CAShapeLayer * backLayer;

//填充层 -- 只有在开启或关闭动作完成之后执行
@property(nonatomic,strong) CAShapeLayer * fillLayer;

//按钮层
@property(nonatomic,strong) CAShapeLayer * thumbLayer;

@property(nonatomic,assign) BOOL isShow;

@property(nonatomic,strong) UIBezierPath * previousPath;

@property(nonatomic,assign) BOOL isAnimation;

@end

@implementation DeeSwitch

- (instancetype)initWithFrame:(CGRect)frame {
    //待测试
    if (CGRectEqualToRect(frame,CGRectZero) || CGRectEqualToRect(frame , CGRectNull)) {
        frame = CGRectMake(0, 0, 51, 31);
    }
    if (self = [super initWithFrame:frame]) {
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.isShow = NO;
        self.isAnimation = YES;
        //添加收拾监听
        [self configGesture];

        //添加图层
        [self configLayer];
    }
    return self;
}

#pragma mark - interface
- (BOOL)on {
    return self.isShow;
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    self.isShow = !on;
    self.isAnimation = animated;
    [self tapDownAction:nil];
    [self tapUpAction:nil];
}

#pragma mark - EvenetRespond
- (void)tapUpAction:(UIControl *)sender {
    if (self.isShow) { //ON
        //backLayer
        [self changeBacklayerColor:self.tintColor
                          duration:0.05
                         animation:self.isAnimation];

        [self showFillLayer:self.isShow
                   duration:0.1
                      delay:0
                  animation:self.isAnimation];

        //thumb layer
        [self makeThumblayerTransitionWithPath:[self calculateThumbTransitionPathWithState:k_Path_State_Off]
                                      duration:0.1
                                         delay:0
                                     animation:self.isAnimation];
    } else { //OFF
        //backLayer
        [self changeBacklayerColor:self.onTintColor
                          duration:0.1
                         animation:self.isAnimation];

        //fillLayer
        [self makeThumblayerTransitionWithPath:[self calculateThumbTransitionPathWithState:k_Path_State_On]
                                      duration:0.15
                                         delay:0
                                     animation:self.isAnimation];

    }
    self.isShow ^= 1;
}

- (void)tapDownAction:(UIControl *)sender {
    if (self.isShow) {
        //thumlayer
        [self makeThumblayerTransitionWithPath:[self calculateThumbTransitionPathWithState:k_Path_State_Mid_On]
                                      duration:1
                                         delay:0
                                     animation:self.isAnimation];
    } else {
        //thumlayer
        [self makeThumblayerTransitionWithPath:[self calculateThumbTransitionPathWithState:k_Path_State_Mid_Off]
                                      duration:1
                                         delay:0
                                     animation:self.isAnimation];
        //filllayer
        [self showFillLayer:self.isShow
                   duration:0.1
                      delay:0.1
                  animation:self.isAnimation];
    }

}

//fill layer
- (void)showFillLayer:(BOOL)show duration:(CGFloat)duration delay:(CGFloat)delay animation:(BOOL)animation {
    [self showLayerWith:self.fillLayer show:show duration:duration delay:delay scaleAnimation:animation];
}

//back layer
- (void)changeBacklayerColor:(UIColor *)color duration:(CGFloat)duration animation:(BOOL)animation {
    [self changeColorWithLayer:self.backLayer
                         color:color
                      duration:duration
                     animation:animation];

    [self borderColorAnimationWithLayer:self.backLayer
                                  color:color
                               duration:duration
                              animation:animation];
    [self borderColorAnimationWithLayer:self.thumbLayer
                                  color:color
                               duration:duration
                              animation:animation];
}

//thumb layer
- (void)makeThumblayerTransitionWithPath:(UIBezierPath *)path duration:(CGFloat)duration delay:(CGFloat)delay animation:(BOOL)animation {
    [self makeTransitonAnimaitonWithLayer:self.thumbLayer
                                     path:path
                                  duratin:duration
                                    delay:delay
                             previousPath:self.previousPath
                                animation:YES];

    self.previousPath = path;
}

#pragma mark -  baseAnimationCreator

//fillColorAnimation
- (void)showLayerWith:(CALayer *)layer
                 show:(BOOL)isShow
             duration:(CGFloat)duration
                delay:(CGFloat)delay
       scaleAnimation:(BOOL)animation {
    if (animation) {
        CGFloat scale = isShow ? 1.0 : 0.0;
        CGFloat fromValue = isShow ? 0.0 : 1.0;
        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.duration = duration;
        scaleAnimation.fromValue = @(fromValue);
        scaleAnimation.toValue = @(scale);
        scaleAnimation.removedOnCompletion = NO;
        scaleAnimation.beginTime = CACurrentMediaTime()+delay;
        scaleAnimation.fillMode = kCAFillModeForwards;
        [layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    } else {

    }
}

//backlayerAnimation
- (void)changeColorWithLayer:(CAShapeLayer *)layer
                   color:(UIColor *)color
                duration:(CGFloat)duration
               animation:(BOOL)animation {
    if (animation) {
        CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
        colorAnimation.duration = duration;
        colorAnimation.toValue = (id)color.CGColor;
        colorAnimation.removedOnCompletion = NO;
        colorAnimation.fillMode = kCAFillModeForwards;
        [layer addAnimation:colorAnimation forKey:@"colorAnimation"];
    } else {
        [layer removeAllAnimations];
        layer.fillColor = color.CGColor;
    }
}
//thumlayerAnimtion
- (void)makeTransitonAnimaitonWithLayer:(CAShapeLayer *)layer
                                   path:(UIBezierPath *)path
                                duratin:(CGFloat)duration
                                  delay:(CGFloat)delay
                           previousPath:(UIBezierPath *)prePath
                              animation:(BOOL)animation {
    if (animation) {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        pathAnimation.duration = duration;
        pathAnimation.beginTime = CACurrentMediaTime() + delay;
        pathAnimation.fromValue = (__bridge id _Nullable)(prePath.CGPath);
        pathAnimation.toValue = (__bridge id _Nullable)(path.CGPath);
        pathAnimation.removedOnCompletion = NO;
        pathAnimation.fillMode = kCAFillModeForwards;
        [layer addAnimation:pathAnimation forKey:@"transition"];
    } else {
        [layer removeAllAnimations];
        layer.path = path.CGPath;
    }

    if (animation) {
        CABasicAnimation *shadowAnimation = [CABasicAnimation animationWithKeyPath:@"shadowPath"];
        shadowAnimation.duration = duration;
        shadowAnimation.beginTime = CACurrentMediaTime() + delay;
        shadowAnimation.fromValue = (__bridge id _Nullable)(prePath.CGPath);
        shadowAnimation.toValue = (__bridge id _Nullable)(path.CGPath);
        shadowAnimation.removedOnCompletion = NO;
        shadowAnimation.fillMode = kCAFillModeForwards;
        [layer addAnimation:shadowAnimation forKey:@"shadowTransition"];
    } else {
        layer.shadowPath = path.CGPath;
    }
}

- (void)borderColorAnimationWithLayer:(CAShapeLayer *)layer
                                color:(UIColor *)color
                             duration:(CGFloat)duration
                            animation:(BOOL)animation{
    if (animation) {
        CABasicAnimation *strokeAnimtion = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
        strokeAnimtion.duration = duration;
        strokeAnimtion.toValue = (id)color.CGColor;
        strokeAnimtion.removedOnCompletion = NO;
        strokeAnimtion.fillMode = kCAFillModeForwards;
        [layer addAnimation:strokeAnimtion forKey:@"strokeColor"];
    } else {
        [layer removeAllAnimations];
        layer.strokeColor = color.CGColor;
    }
}

#pragma mark - PivateMethod
- (UIBezierPath *)calculateThumbTransitionPathWithState:(k_Path_State)state {
    CGRect contentBounds = self.backLayer.bounds;
    CGFloat height = contentBounds.size.height;
    CGFloat width = contentBounds.size.width;
    CGFloat y =  (contentBounds.size.height - height) / 2.0;
    CGFloat minDoubleWidth = contentBounds.size.width / 3.0 * 2;
    UIBezierPath *statePath;
    //四种状态的path
    switch (state) { //[00    ]
        case k_Path_State_Off: {
            statePath  = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, y, height, height) cornerRadius:height / 2.0];
        }
            break;
        case k_Path_State_Mid_Off: { // [0000  ]
            statePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, y, minDoubleWidth, height) cornerRadius:height / 2.0];
        }
            break;
        case k_Path_State_Mid_On: { // [  0000]
            statePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(width - minDoubleWidth, y, minDoubleWidth, height) cornerRadius:height / 2.0];
        }
            break;
        case k_Path_State_On: { // [  00]
            statePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(width - height, y, height, height) cornerRadius:height / 2.0];
        }
            break;
        default:
            break;
    }
    return statePath;

}

- (void)configLayer {
    //backLayer
    self.backLayer = [CAShapeLayer new];
    self.backLayer.frame = self.bounds;
    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds cornerRadius:floor(self.backLayer.bounds.size.height / 2.0)].CGPath;
    self.backLayer.path = path;
    self.backLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:self.backLayer];
    self.backLayer.strokeColor = self.isShow ? self.onTintColor.CGColor : self.tintColor.CGColor;
    self.backLayer.lineWidth = 8;


    //fillLayer
    self.fillLayer = [CAShapeLayer new];
    self.fillLayer.frame = self.bounds;
    self.fillLayer.path = path;
    self.fillLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:self.fillLayer];


    //thumbLayer
    self.thumbLayer = [CAShapeLayer new];
    self.thumbLayer.frame = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);

    UIBezierPath *roundPath = [self calculateThumbTransitionPathWithState:k_Path_State_Off];
    self.previousPath = roundPath;
    self.thumbLayer.path = roundPath.CGPath;
    self.thumbLayer.lineWidth = 1;
    self.thumbLayer.fillColor = self.thumbTintColor.CGColor;

    self.thumbLayer.shadowPath = roundPath.CGPath;
    self.thumbLayer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.thumbLayer.shadowOpacity = 1;
    self.thumbLayer.shadowOffset = CGSizeMake(3, 3);
    [self.layer addSublayer:self.thumbLayer];
}

- (void)configGesture {
    [self addTarget:self action:@selector(tapUpAction:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];

    [self addTarget:self action:@selector(tapDownAction:) forControlEvents:UIControlEventTouchDown];
}

#pragma mark - setterAndGetter
- (UIColor *)onTintColor {
    if (!_onTintColor) {
        return [UIColor greenColor];
    }
    return _onTintColor;
}

- (UIColor *)tintColor {
    if (!_tintColor) {
        return [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    }
    return _tintColor;
}

- (UIColor *)thumbTintColor {
    if (!_thumbTintColor) {
        return [UIColor whiteColor];
    }
    return _thumbTintColor;
}

- (UIColor *)backGroundColor {
    if (!_backGroundColor) {
        return [UIColor clearColor];
    }
    return _backGroundColor;
}

@end
