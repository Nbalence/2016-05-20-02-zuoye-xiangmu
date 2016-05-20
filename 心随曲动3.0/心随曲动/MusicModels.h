//
//  MusicModels.h
//  心随曲动
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModels : NSObject
@property (nonatomic,strong) NSString *mp3Url;    //歌曲链接
@property (nonatomic,strong) NSString *picUrl;    //图片链接
@property (nonatomic,strong) NSString *singer;    //歌手
@property (nonatomic,strong) NSString *albm;      //唱片集
@property (nonatomic,strong) NSString *artName;   //艺术家
@property (nonatomic,strong) NSString *blurPicUrl;//模糊背景链接
@property (nonatomic,strong) NSString *lyric;     //歌词
@property (nonatomic,strong) NSString *name;      //名字
@property (nonatomic,strong) NSString *icon;      //歌曲图片

-(instancetype) initWithDictionary:(NSDictionary *)dict;
+(instancetype) musicWithDictionary:(NSDictionary *)dict;
@end
