//
//  SecViewController.m
//  心随曲动
//
//  Created by qingyun on 16/5/18.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "SecViewController.h"
#import "SongList.h"
#import "SongControl.h"
#import "GXTSongCell.h"
#import "GXTSongPlayVC.h"

#define GScreenW [UIScreen mainScreen].bounds.size.width
#define GScreenH [UIScreen mainScreen].bounds.size.height

@interface SecViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *myTable;
@end

@implementation SecViewController

//添加tableView
-(UITableView *)myTable{
    if (_myTable == nil) {
        _myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, GScreenW, GScreenH)];
        _myTable.delegate=self;
        _myTable.dataSource=self;
        _myTable.rowHeight=100;
        _myTable.backgroundColor = [UIColor clearColor];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"music.jpg"];
        imageView.alpha = 0.6;
        _myTable.backgroundView = imageView;
    }
    return _myTable;
}
#pragma mark - mark dataSource delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [SongList shareHandel].songArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identfier=@"cell";
    GXTSongCell *cell=[tableView dequeueReusableCellWithIdentifier:identfier];
    if (cell==nil) {
        //注册cell
        cell=[[NSBundle mainBundle]loadNibNamed:@"GXTSongCell" owner:nil options:0][0];
        cell.backgroundColor = [UIColor clearColor];
    }
    //1取出mode
    SongMode *mode=[SongList shareHandel].songArr[indexPath.row];
    //2.给cell赋值
    cell.mode=mode;

    
    //定义单元格背景
    UIView *view = [[UIView alloc] initWithFrame:cell.contentView.frame];
    view.backgroundColor = [UIColor clearColor];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(240, 17, 80, 80)];
    imgView.layer.cornerRadius = 40;
    imgView.image = [UIImage imageNamed:@"2"];
    [view addSubview:imgView];
    cell.selectedBackgroundView = view;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //播放界面
    GXTSongPlayVC *songVc=[[GXTSongPlayVC alloc] init];
    //设置播放下标
    [SongControl shareSongCtrHandel].currentIndex=indexPath.row;
    
    [self.navigationController pushViewController:songVc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"歌曲列表";
    
    [self.view addSubview:self.myTable];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
