//
//  ViewController.m
//  心随曲动
//
//  Created by qingyun on 16/5/6.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "ViewController.h"
#import "MusicModels.h"
#import "GXTTableViewCell.h"
#import "SecondViewController.h"
#import <UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;       //歌词界面
@property (nonatomic,retain) NSMutableArray *songListArray;//歌曲列表数组
@property (nonatomic,strong) SecondViewController *root;   //第二个界面
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //打开交互
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationItem.title  =@"歌曲列表";
    
    self.songListArray = [[NSMutableArray alloc] init];
    self.root = [[SecondViewController alloc] init];
    self.view .backgroundColor = [UIColor whiteColor];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        self.songListArray = [self requestWithUrlString:@"http://project.lanou3g.com/teacher/UIAPI/MusicInfoList.plist"];
        //主线程刷新界面
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
    });
    
    [self createTableView];
}

//解析数据
-(NSMutableArray *)requestWithUrlString:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSArray *array = [NSArray arrayWithContentsOfURL:url];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        MusicModels *model = [MusicModels musicWithDictionary:dic];
        [dataArray addObject:model];
    }
    return dataArray;
}

//创建表视图
-(void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIImageView *imageVIew = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"music.jpg"]];
    imageVIew.alpha = 0.6;
    imageVIew.frame = [UIScreen mainScreen].bounds;
    [self.tableView setBackgroundView:imageVIew];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - TableVIew代理和数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.songListArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicModels *model = [[MusicModels alloc] init];
    model = [self.songListArray objectAtIndex:indexPath.row];
    NSLog(@"%@",model.name);
    
    GXTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[GXTTableViewCell alloc] initWithStyle:1 reuseIdentifier:@"cell"];
    }
    cell.models = model;
    //cell.models = self.songListArray[indexPath.row];
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

//当选中某一行时
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.root.songHListArray = [[NSMutableArray alloc] init];
    self.root.songHListArray = self.songListArray;
    
    if (self.root.i != indexPath.row) {
        MusicModels *model = [[MusicModels alloc] init];
        self.root.i = indexPath.row;
        model = [self.songListArray objectAtIndex:self.root.i];
        self.root.lrcArray = [[NSMutableArray alloc] init];
        self.root.lrcTime = [[NSMutableArray alloc] init];
        self.root.navigationItem.title = model.name;
        
        [self.root.imageViewSecond sd_setImageWithURL:[NSURL URLWithString:model.blurPicUrl]];
        self.root.player = [[AVAudioPlayer alloc] init];
        
        [self.root musicplay:model.mp3Url];
        [self.root addLyric:model.lyric];
        [self.root addPicture:model.picUrl];
        //self.root musicplay:
        
    }
    
    //再次回来时继续旋转
    //    中心旋转
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    CGFloat point = M_PI_4;
    
    
    ani.values = @[@(9 * point),@(8 * point),@(7 * point),@(6 * point),@(5 * point),@(4 * point),@(3 * point),@(2 * point),@(point)];
    
    ani.repeatCount = MAXFLOAT;
    ani.duration = 5;
    
    [self.root.picImgView.layer addAnimation:ani forKey:nil];
    [self.root.picImgView.layer setMasksToBounds:YES];
    
    [self.root.tableView reloadData];
    self.root.i = indexPath.row;
    [self.navigationController pushViewController:self.root animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
