//
//  GXTSongPlayVC.h
//  01-本地歌曲
//
//  Created by qingyun on 16/5/07.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface GXTSongPlayVC : UIViewController
@property (nonatomic,strong) UIImageView *picImgView;  //旋转图片
@property (nonatomic,strong) UITableView *tableViewBG; //歌词显示视图
@property (nonatomic,strong) UITableView *tableView;   //

@property (nonatomic,strong) NSMutableArray *songArray;

@property (nonatomic,strong) AVAudioPlayer *player;

@property (nonatomic)        BOOL isPlay;
@property (nonatomic)        BOOL isRight;

@property (nonatomic,strong) UIButton *btn3;
@property (nonatomic,strong) UISlider *slider;
@property (nonatomic,strong) UIAlertController *alert;
@end
