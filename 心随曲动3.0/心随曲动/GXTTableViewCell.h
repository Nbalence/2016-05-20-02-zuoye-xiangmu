//
//  GXTTableViewCell.h
//  心随曲动
//
//  Created by qingyun on 16/5/7.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModels.h"
@interface GXTTableViewCell : UITableViewCell
@property (nonatomic,strong) UILabel *songLabel;    //歌曲名
@property (nonatomic,strong) UILabel *singerLabel;  //歌手名字
@property (nonatomic,strong) UIImageView *imgView;  //歌曲图片
@property (nonatomic,strong) MusicModels *models;   //数据模型
@end
