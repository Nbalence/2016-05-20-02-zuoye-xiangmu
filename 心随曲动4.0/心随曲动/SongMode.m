//
//  SongMode.m
//  01-本地歌曲
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "SongMode.h"

@implementation SongMode

-(instancetype) initWithDicitonary:(NSDictionary *)dict
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+(instancetype) modelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDicitonary:dict];
}

@end
