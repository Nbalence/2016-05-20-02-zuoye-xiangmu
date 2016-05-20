//
//  parLrc.h
//  01-本地歌曲
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface parLrc : NSObject
//排序过后的时间
@property(nonatomic,strong)NSArray *keyArr;
//存储有效歌词的字典
@property(nonatomic,strong)NSMutableDictionary *lrcDic;

+(instancetype)initWithPath:(NSURL *)path;
@end
