//
//  ViewController.m
//  AVFoundationPlayerSound
//
//  Created by wanglong on 16/7/31.
//  Copyright © 2016年 wanglong. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "WLTool.h"
@interface ViewController ()
/**soundID*/
@property(nonatomic,assign) SystemSoundID soundID;

/** soundIds */
@property(nonatomic,strong)NSMutableDictionary *soundIds;
@end

@implementation ViewController
 -(NSMutableDictionary *)soundIds
{
    if (_soundIds == nil) {
        _soundIds = [NSMutableDictionary dictionary];
    }
    return _soundIds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)buyao:(id)sender {
    
//    [self playAudioWithName:@"buyao.wav"];
    [WLTool playSoundWithName:nil];
}

- (IBAction)dawang:(id)sender {
//    [self playAudioWithName:@"m_17.wav"];
    [WLTool playSoundWithName:@"m_17.wav"];
}
- (IBAction)beijing:(id)sender {
//     [self playAudioWithName:@"normal.aac"];
    [WLTool playSoundWithName:@"normal.aac"];
}
- (IBAction)win:(id)sender {
//    [self playAudioWithName:@"win.aac"];
    [WLTool playSoundWithName:@"win.aac"];
}

#warning  这种方式 还不是太好 毕竟只能在这个类中调用
#warning  抽个工具方法时最好的选择 
//- (void)playAudioWithName:(NSString *)name
//{
//    
//    SystemSoundID soundId = 0;
//    
//    soundId = [self.soundIds[name] unsignedIntValue];
//    if (soundId == 0) {
//        NSURL *url = [[NSBundle mainBundle] URLForResource:name withExtension:nil];
//        CFURLRef urlRef = (__bridge CFURLRef)(url);
//        AudioServicesCreateSystemSoundID(urlRef, &soundId);
//        [self.soundIds setObject:@(soundId) forKey:name];
//    }
//    
//    AudioServicesPlaySystemSound(soundId);
//}
#pragma mark - 懒加载的形式播放音频
- (SystemSoundID)soundID
{
    if (_soundID == 0) {
#warning  [NSBundle mainBundle] 拖到项目中的资源文件如音频 .plist等都可以通过mainBundle得到
        //设置播放的音效路径url
        NSURL  *url= [[NSBundle mainBundle] URLForResource:@"normal" withExtension:@"aac"];
        NSLog(@"url == %@",url);
        //桥接
        CFURLRef urlRef = (__bridge CFURLRef)(url);
        //2.加载音效文件，得到对应的音效ID
        AudioServicesCreateSystemSoundID(urlRef , &_soundID);
    }
    return _soundID;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //播放音效
    AudioServicesPlaySystemSound(self.soundID);
//    AudioServicesPlayAlertSound(self.soundID);
    #warning  两者的区别是是否有震动 真机上才可以看出来
}

#pragma mark - 懒加载的形式播放音频


- (IBAction)playMusic:(UIButton *)sender {
    [WLTool playMusicWithName:@"10405520.mp3"];
}
- (IBAction)pauseMusic:(UIButton *)sender {
    [WLTool pauseMusicWithName:@"10405520.mp3"];
}
- (IBAction)stopMusic:(UIButton *)sender {
    [WLTool stopMusicWithName:@"10405520.mp3"];
}
- (IBAction)otherMusic:(UIButton *)sender {
    //10736444
    [WLTool playMusicWithName:@"10736444.mp3"];
}
#pragma mark - 播放音乐
@end
