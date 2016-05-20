//
//  SongControl.h
//  01-本地歌曲
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import <Foundation/Foundation.h>
@class parLrc;

//播放器协议
@protocol PlayerPRO <NSObject>
//刷新进度
-(void)sendCurrentTime:(NSTimeInterval)time;
//刷新歌词
-(void)updateLrcSelectIndex:(NSInteger)row;
//更新歌曲时要通知
-(void)notficationSongReload;

@end


@interface SongControl : NSObject

//当前播放状态
@property(nonatomic,readonly)BOOL isPlaying;
//当前播放时间
@property(nonatomic,assign)NSTimeInterval currentTime;
//音频的总时长
@property(nonatomic,assign,readonly)NSTimeInterval durationTime;
//设置当前播放或者暂停
@property(nonatomic,assign)BOOL playOrPause;
//当前播放下标
@property(nonatomic,assign)NSInteger currentIndex;
//委托代理
@property(nonatomic,assign)id<PlayerPRO>delegate;
//歌词解析的模型
@property(nonatomic,strong)parLrc *lrcMode;

+(instancetype)shareSongCtrHandel;

//上一曲
-(void)previousSong;
//下一曲
-(void)nextSong;

@end
