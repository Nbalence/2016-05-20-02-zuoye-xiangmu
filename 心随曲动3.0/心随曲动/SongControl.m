//
//  SongControl.m
//  01-本地歌曲
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "SongControl.h"
#import "SongMode.h"
#import "SongList.h"
#import "parLrc.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>


@interface SongControl ()<AVAudioPlayerDelegate>
//播放器对象
@property(nonatomic,strong)AVAudioPlayer *player;
//定时器
@property(nonatomic,strong)NSTimer *timer;
@end


@implementation SongControl

//初始化播放器
+(instancetype)shareSongCtrHandel{
    static SongControl *handel;
    static dispatch_once_t once;
    dispatch_once(&once , ^{
        handel=[[SongControl alloc] init];
        //初始化currentIndex下标
        handel.currentIndex=-1;
        [handel setSeesion];
    });
    return handel;
}

-(void)setSeesion{
    //获取会话
    AVAudioSession *seesion=[AVAudioSession sharedInstance];
    //设置策略
    [seesion setCategory:AVAudioSessionCategoryPlayback error:nil];
    [seesion setActive:YES error:nil];
    
}


-(NSTimeInterval)durationTime{
    return _player.duration;
}
-(void)setDelegate:(id<PlayerPRO>)delegate{
    if (delegate==nil) {
        //暂停timer
        self.timer.fireDate=[NSDate distantFuture];
    }else{
        //启动timer
        self.timer.fireDate=[NSDate distantPast];
    }
    _delegate=delegate;
}

-(void)updateSelectIndex{
    NSInteger tempIndex=-1;
    //当前播放时间
    NSTimeInterval currentTime=_player.currentTime;
    NSArray *keyTime=_lrcMode.keyArr;
    for (NSNumber *nuber in keyTime) {
        //当前时间和歌词时间做对比
        //如果当前时间大约歌词时间++
        //当前时间如果小于歌词时间break，跳出循环体
        if (nuber.floatValue<=currentTime) {
            tempIndex++;
        }else{
            break;
        }
    }
    if(self.delegate){
        if (tempIndex>-1) {
            //更新歌词
            [self.delegate updateLrcSelectIndex:tempIndex];
        }
    }
}


#pragma mark 获取当前播放时间，实时刷新进度
-(void)getCurrentTime{
    
    if(self.delegate){
        
        //回调当前播放时间
        [self.delegate sendCurrentTime:_player.currentTime];
        //更新歌词
        [self updateSelectIndex];
    }
}

#pragma mark 通知播放完成
-(void)notFicationSongUpate{
    if (self.delegate) {
        [self.delegate notficationSongReload];
    }
}


-(NSTimer *)timer{
    if (_timer) {
        return _timer;
    }
    _timer=[NSTimer scheduledTimerWithTimeInterval:.3 target:self selector:@selector(getCurrentTime) userInfo:nil repeats:YES];
    return _timer;
}
//设置currentTime
-(void)setCurrentTime:(NSTimeInterval)currentTime{
    _player.currentTime=currentTime;
}


//设置播放暂停 set
-(void)setPlayOrPause:(BOOL)playOrPause{
    if (playOrPause) {
        //播放
        [_player play];
        self.timer.fireDate=[NSDate distantPast];
    }else{
        //暂停
        [_player pause];
        self.timer.fireDate=[NSDate distantFuture];
    }
    _playOrPause=playOrPause;
}


//设置播放下标 set
-(void)setCurrentIndex:(NSInteger)currentIndex{
    
    if (currentIndex==-1) {
        //首次初始化赋值
        _currentIndex=currentIndex;
        return;
    }
    
    if (_currentIndex==currentIndex) {
        return;
    }
    
    //获取播放的mode
    SongMode *mode=[SongList shareHandel].songArr[currentIndex];
    
    //歌词解析
    _lrcMode=[parLrc initWithPath:[[NSBundle mainBundle] URLForResource:mode.kName withExtension:@"lrc"]];
    
    
    //歌曲的url
    NSURL *songUrl=[[NSBundle mainBundle]URLForResource:mode.kName withExtension:mode.kType];
    //初始化播放器
    _player=[[AVAudioPlayer alloc] initWithContentsOfURL:songUrl error:nil];
    //设置代理
    _player.delegate=self;
    //初始化
    [_player prepareToPlay];
    //播放
    self.playOrPause=YES;
    //    //更新锁屏信息
    //    [self lockScreenState:mode];
    
    _currentIndex=currentIndex;
}

-(BOOL)isPlaying{
    return _player.isPlaying;
}
//上一首
-(void)previousSong{
    if (self.currentIndex==0) {
        self.currentIndex=[SongList shareHandel].songArr.count-1;
    }else{
        self.currentIndex--;
    }
    [self notFicationSongUpate];
}
//下一首
-(void)nextSong{
    if(self.currentIndex==[SongList shareHandel].songArr.count-1){
        self.currentIndex=0;
    }else{
        self.currentIndex++;
    }
    [self notFicationSongUpate];
}
//
//#pragma mark AvAudioPlayer delegate
//-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
//    switch (_playMode) {
//        case sequenceLoop:
//            [self nextSong];
//            break;
//        case singleLoop:{
//            NSInteger tempIndex=self.currentIndex;
//            //初始化下标
//            self.currentIndex=-1;
//            self.currentIndex=tempIndex;
//        }
//            break;
//        case Random:{
//            //随机播放===[0,[SongListHandle shareHandel].songArr.count)
//            int random=arc4random()%[SongListHandle shareHandel].songArr.count;
//            if (random==self.currentIndex) {
//                NSInteger tempIndex=self.currentIndex;
//                //初始化下标
//                self.currentIndex=-1;
//                self.currentIndex=tempIndex;
//            }else{
//                self.currentIndex=random;
//            }
//        }
//            break;
//        default:
//            break;
//    }
//    //刷新ui
//    [self notFicationSongUpate];
//}



@end
