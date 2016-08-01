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

static NSMutableDictionary *_musicPlayers;
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

+ (NSMutableDictionary *)musicPlayers
{
    if (_musicPlayers ==nil) {
        _musicPlayers = [NSMutableDictionary dictionary];
    }
    return _musicPlayers;
}
/**
 *  播放音效工具方法
 */
+ (void)playSoundWithName:(NSString *)soundName
{
    
    
#warning  断言 一种开发是提示的有效手段
//    assert(soundName);
    
    NSLog(@"My name is %@.",soundName);
    NSAssert(soundName != nil, @"名字不能为空！");

    SystemSoundID soundId = 0;
    
    soundId = [self.soundIds[soundName] unsignedIntValue];
    if (soundId == 0) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:soundName withExtension:nil];
        
        if (url == nil) {
            NSLog(@"传入的音频文件错误");
            return;
        }
        CFURLRef urlRef = (__bridge CFURLRef)(url);
        AudioServicesCreateSystemSoundID(urlRef, &soundId);
        [self.soundIds setObject:@(soundId) forKey:soundName];
    }
    
    AudioServicesPlaySystemSound(soundId);
}

/**
 *  播放音乐工具方法
 */
+ (void)playMusicWithName:(NSString *)musicName
{

     NSLog(@"My name is %@.",musicName);
    NSAssert(musicName != nil, @"名字不能为空！");

    AVAudioPlayer *player = (AVAudioPlayer *)self.musicPlayers[musicName];
    if (player == nil) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:musicName withExtension:nil];
        NSLog(@"url == %@",url);
        NSAssert(url != nil, @"传入的文件url不存在");
        NSError *error = nil;
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        if (error) {
            NSLog(@"播放音乐对象出现错误 %@",error);
        }
        [player prepareToPlay];
        [self.musicPlayers setObject:player forKey:musicName];
    }
    [player play];
    
}

+(void)pauseMusicWithName:(NSString *)musicName;
{
    AVAudioPlayer *player = [self musicPlayers][musicName];
    if (player) {
        [player pause];
    }
}

+(void)stopMusicWithName:(NSString *)musicName;
{
    AVAudioPlayer *player = [self musicPlayers][musicName];
    if (player) {
        [player stop];
        [_musicPlayers removeObjectForKey:musicName];
        player = nil;
    }
}


@end
