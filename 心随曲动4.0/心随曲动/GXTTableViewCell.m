//
//  GXTTableViewCell.m
//  心随曲动
//
//  Created by qingyun on 16/5/7.
//  Copyright © 2016年 GXT. All rights reserved.
//
/*
    第一个界面上的视图
 */
#import "GXTTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation GXTTableViewCell

//1、初始化tableViewCell
-(instancetype )initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createCell];
    }
    return self;
}

//创建行
-(void)createCell
{
    self.backgroundColor = [UIColor clearColor];
    //左边头像
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 80, 80)];
    self.imgView.layer.cornerRadius = 15;
    self.imgView.layer.masksToBounds = YES;
    //歌曲名
    self.songLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 20, 180, 50)];
    self.songLabel.numberOfLines = 0;
    self.songLabel.textColor = [UIColor blackColor];
    self.songLabel.textAlignment = NSTextAlignmentCenter;
    self.songLabel.font = [UIFont systemFontOfSize:20.0];
    //歌手名
    self.singerLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 80, 100, 20)];
    self.singerLabel.textColor = [UIColor grayColor];
    self.singerLabel.textAlignment = NSTextAlignmentCenter;
    self.singerLabel.font = [UIFont systemFontOfSize:18.0];
    
    //添加到cell中
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.songLabel];
    [self.contentView addSubview:self.singerLabel];
}

//重写Set方法
-(void)setModels:(MusicModels *)models
{
    _models = models;
    self.songLabel.text = models.name;
    self.singerLabel.text = models.singer;
    //self.imgView.image = [UIImage imageNamed:models.icon];
    //加载网络图片，没有的话，就用本地代替
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",models.picUrl]] placeholderImage:[UIImage imageNamed:@"iconfont-yutoubaoicon.png"]];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
