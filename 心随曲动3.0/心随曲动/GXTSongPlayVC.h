//
//  GXTSongPlayVC.h
//  01-本地歌曲
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GXTSongPlayVC : UIViewController
@property (nonatomic,strong) UIImageView *picImgView;
@property (nonatomic,strong) UITableView *tableViewBG;
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UIButton *btn3;
@property (nonatomic,strong) UISlider *slider;
@property (nonatomic,strong) UIAlertController *alert;
@end
