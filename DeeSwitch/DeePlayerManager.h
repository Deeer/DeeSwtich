//
//  DeePlayerManager.h
//  DeeSwitch
//
//  Created by Dee on 2018/12/24.
//  Copyright © 2018 Dee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeePlayerManager : NSObject

+ (instancetype)shareInstance;

- (void)prepareSound;

- (void)playSound;

@end

NS_ASSUME_NONNULL_END
