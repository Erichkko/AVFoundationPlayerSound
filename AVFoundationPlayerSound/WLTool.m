//
//  WLTool.m
//  AVFoundationPlayerSound
//
//  Created by wanglong on 16/7/31.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "WLTool.h"
#import <AVFoundation/AVFoundation.h>

@implementation WLTool

static NSMutableDictionary *_soundIds;


//也可以在第一次调用类的时候创建字典,此方法 只会 调用一次

//+ (void)initialize
//{
//     _soundIds = [NSMutableDictionary dictionary];
//
//}

//可以通过 get方法加载字典
+ (NSMutableDictionary *)soundIds
{
    if (_soundIds ==nil) {
        _soundIds = [NSMutableDictionary dictionary];
    }
    return _soundIds;
}

#warning 如果通过 + (void)initialize 创建字典 要通过 _soundIds得到字典
#warning 如果通过 + (NSMutableDictionary *)soundIds 要通过 self.soundIds方法获得字典

+ (void)playSoundWithName:(NSString *)soundName
{
    SystemSoundID soundId = 0;
    
    soundId = [self.soundIds[soundName] unsignedIntValue];
    if (soundId == 0) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:soundName withExtension:nil];
        CFURLRef urlRef = (__bridge CFURLRef)(url);
        AudioServicesCreateSystemSoundID(urlRef, &soundId);
        [self.soundIds setObject:@(soundId) forKey:soundName];
    }
    
    AudioServicesPlaySystemSound(soundId);
}
@end
