//
//  parLrc.m
//  01-本地歌曲
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "parLrc.h"

@implementation parLrc

//拆分一个数组
-(NSArray *)Parcontents:(NSString *)content{
    NSArray *tempArr=[content componentsSeparatedByString:@"\n"];
    return tempArr;
}

//解析有效歌词
-(void)pareEffectLrcFromArr:(NSArray *)contentArr{
    //遍历歌词
    for (NSString *str in contentArr) {
        NSArray *valueArr=[str componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"[:]"]];
        
//        NSLog(@"=====%@",valueArr);
        //判断有效歌词
        if (valueArr.count>=4) {
            if ([valueArr[1]hasPrefix:@"0"]||[valueArr[1]hasPrefix:@"1"]) {
                //取出时间
                float times=[valueArr[1] floatValue]*60+[valueArr[2] floatValue];
                //取出歌词
                NSString *lrcStr=valueArr[3];
                if (_lrcDic) {
                    //赋值
                    [_lrcDic setValue:lrcStr forKey:@(times)];
                }else{
                    _lrcDic=[NSMutableDictionary dictionary];
                }
            }
        }
    }
    //给歌词排序
    _keyArr=[[_lrcDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
}

//解析path
-(void)parsLrcFromPath:(NSURL *)filePath{
    //文件转换成string
    NSString *lrcStr=[NSString stringWithContentsOfURL:filePath encoding:NSUTF8StringEncoding error:nil];
    ///拆分一个数组
    NSArray *tempArr=[self Parcontents:lrcStr];
    //解析有效歌词存储数组和字典
    [self pareEffectLrcFromArr:tempArr];
}

-(instancetype)initWithPath:(NSURL *)path{
    if (self=[super init]) {
        [self parsLrcFromPath:path];
    }
    return self;
    
}

+(instancetype)initWithPath:(NSURL *)path{
    parLrc *parlc=[[parLrc alloc] initWithPath:path];
    return parlc;
}

@end
