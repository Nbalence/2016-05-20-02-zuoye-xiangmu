//
//  MusicModels.m
//  心随曲动
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "MusicModels.h"

@implementation MusicModels

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
-(instancetype) initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype) musicWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end
