//
//  DeePlayerManager.m
//  DeeSwitch
//
//  Created by Dee on 2018/12/24.
//  Copyright © 2018 Dee. All rights reserved.
//

#import "DeePlayerManager.h"
#import <AVFoundation/AVFoundation.h>
@interface DeePlayerManager()

@property(nonatomic,strong) AVAudioPlayer * deeplayer;

@end

@implementation DeePlayerManager
+ (instancetype)shareInstance {
    static DeePlayerManager *player;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[DeePlayerManager alloc] init];
    });
    return player;
}

- (void)prepareSound {
    // 取出资源的URL
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"sw1.mp3" withExtension:nil];

    // 创建播放器
    NSError *error = nil;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];

    // 准备播放
    [player prepareToPlay];

    self.deeplayer = player;
}


- (void)playSound {
    [self.deeplayer play];
}

@end
