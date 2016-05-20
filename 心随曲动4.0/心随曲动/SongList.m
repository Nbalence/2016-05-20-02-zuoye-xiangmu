//
//  SongList.m
//  01-本地歌曲
//
//  Created by qingyun on 16/5/06.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "SongList.h"
#import "SongMode.h"

@implementation SongList

-(void)addList
{
    _songArr = [[NSMutableArray alloc] init];
    //读取文件
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SongList" ofType:@"plist"]];
    if (array) {
        for (NSDictionary *dic in array) {
            SongMode *mode=[[SongMode alloc] init];
            [mode setValuesForKeysWithDictionary:dic];
            [_songArr addObject:mode];
        }
    }
}

//单例方法
+(instancetype)shareHandel{
    static SongList *handel;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        handel=[[SongList alloc] init];
        //1初始化
        [handel addList];
    });
    return handel;
}


@end
