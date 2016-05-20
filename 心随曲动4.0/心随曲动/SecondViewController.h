//
//  SecondViewController.h
//  心随曲动
//
//  Created by qingyun on 16/5/7.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModels.h"
#import <AVFoundation/AVFoundation.h>

@interface SecondViewController : UIViewController
@property (nonatomic,retain) NSMutableArray *songHListArray;
@property (nonatomic)        NSInteger i;
@property (nonatomic,strong) AVAudioPlayer *player;

@property (nonatomic,strong) UIButton *btn3;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic)        BOOL isPlay;
@property (nonatomic)        BOOL isRight;
@property (nonatomic,strong) UIImageView *imageViewSecond;
@property (nonatomic,strong) UITableView *tableViewBG;
@property (nonatomic,strong) UIImageView *picImgView;
@property (nonatomic,strong) UISlider *slider;
@property (nonatomic,strong) NSMutableArray *lrcTime;
@property (nonatomic,strong) NSString *currentTime;
@property (nonatomic,strong) NSMutableArray *lrcArray;
@property (nonatomic,strong) UIAlertController *alert;

-(void)musicplay:(NSString *)str;
-(void)addLyric:(NSString *)str;
-(void)addPicture:(NSString *)str;
@end
