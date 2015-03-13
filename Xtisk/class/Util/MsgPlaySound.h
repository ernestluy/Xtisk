//
//  MsgPlaySound.h
//  Xtisk
//
//  Created by zzt on 15/3/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface MsgPlaySound : NSObject
{
    SystemSoundID sound;//系统声音的id 取值范围为：1000-2000
    SystemSoundID msgSound;
}
- (id)initSystemShake;//系统 震动
- (id)initSystemSoundWithName:(NSString *)soundName SoundType:(NSString *)soundType;//初始化系统声音
- (void)play;//播放
+(MsgPlaySound *)sharedInstance;

-(void)playReceiveMsg;
-(void)playAll;
@end
