//
//  SongList.h
//  01-本地歌曲
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongList : NSObject
@property(nonatomic,strong)NSMutableArray *songArr;//歌曲播放列表

+(instancetype)shareHandel;                 //歌曲播放单例
-(BOOL)addSongsFrom:(NSDictionary *)songDic;//添加一首歌曲
@end
