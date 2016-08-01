//
//  WLTool.h
//  AVFoundationPlayerSound
//
//  Created by wanglong on 16/7/31.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLTool : NSObject
/**
 * 播放音效
 */
+(void)playSoundWithName:(NSString *)soundName;
/**
 * 播放音乐
 */
+(void)playMusicWithName:(NSString *)musicName;
/**
 *  暂停播放
 */
+(void)pauseMusicWithName:(NSString *)musicName;
/**
 *  停止播放
 */

+(void)stopMusicWithName:(NSString *)musicName;
@end
