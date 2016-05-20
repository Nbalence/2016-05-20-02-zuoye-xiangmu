//
//  GXTSongPlayVC.m
//  01-本地歌曲
//
//  Created by qingyun on 16/5/07.
//  Copyright © 2016年 GXT. All rights reserved.
//
#import "GXTSongPlayVC.h"
#import "SongControl.h"
#import "SongList.h"
#import "parLrc.h"
#import "SongMode.h"


#define GScreenW [UIScreen mainScreen].bounds.size.width
#define GScreenH [UIScreen mainScreen].bounds.size.height

@interface GXTSongPlayVC ()<UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate,PlayerPRO>

@end

@implementation GXTSongPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, GScreenW, 750)];
    imageView.image = [UIImage imageNamed:@"007.jpg"];
    [self.view addSubview:imageView];
    
    //设置左边返回按钮
    self.navigationItem.leftItemsSupplementBackButton = YES;
    //添加上边界面
    [self addPageView];
    //添加歌词界面
    [self addTableView];
    //添加下边按钮
    [self addButton];

    //添加音量键
    [self volume];
    
    
    //设置代理
    [SongControl shareSongCtrHandel].delegate=self;
    [self initViewState];
    
}

-(void)addPageView
{
    
    _songArray = [SongList shareHandel].songArr;
    
//    SongMode *mode = [[SongMode alloc] init];
    
    [self creatTableViewLrc];
    //调用光盘方法
    self.picImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 200, 200)];
    [self addPicture:@"pic.jpg"];
//    self.navigationItem.title = _songArray[0][@"kName"];
}

//创建歌词视图
-(void)creatTableViewLrc
{
    self.tableViewBG = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,GScreenW,750)];
    
    [self.view addSubview:self.tableViewBG];
    self.tableViewBG.backgroundColor = [UIColor clearColor];
}

//光盘方法
-(void)addPicture:(NSString *)str
{
    self.picImgView.center = CGPointMake(207,180);
    self.picImgView.layer.cornerRadius = 100;
    self.picImgView.image = [UIImage imageNamed:str];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    CGFloat point = M_PI_4;
    //提供一个关键帧，让图形按照给定的value来运动
    animation.values = @[@(9 * point),@(8 * point),@(7 * point),@(6 * point),@(5 * point),@(4 * point),@(3 * point),@(2 * point),@(point)];
    //    animation.values = @[@(point),@(2 * point),@(3 * point),@(4 * point),@(5 * point),@(6 * point),@(7 * point),@(8 * point),@(9 * point)];
    animation.repeatCount = MAXFLOAT;
    animation.duration = 5;
    
    [self.picImgView.layer addAnimation:animation forKey:nil];
    [self.picImgView.layer setMasksToBounds:YES];
    [self.tableViewBG addSubview:self.picImgView];
}

//添加歌词界面
-(void)addTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(30, 290, 350, 200)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableViewBG addSubview:self.tableView];
}


#pragma mark - UItableView代理和数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [SongControl shareSongCtrHandel].lrcMode.keyArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identfier=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identfier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfier];
    }
    //填充歌词
    parLrc * mode=[SongControl shareSongCtrHandel].lrcMode;
    //取出歌词
    NSString *str=mode.lrcDic[mode.keyArr[indexPath.row]];
    cell.textLabel.text=str;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.textColor = [UIColor cyanColor];
    tableView.separatorStyle = UITableViewCellEditingStyleNone;
    cell.textLabel.highlightedTextColor = [UIColor colorWithRed:0.2 green:0.3 blue:0.9 alpha:1];
    cell.backgroundColor = [UIColor clearColor];
    
    
    //设置被选中的cell
    UIView *view = [[UIView alloc] initWithFrame:cell.contentView.frame];
    view.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView =view;
    
    
    
    return cell;
}



#pragma mark - 添加按钮
-(void)addButton
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(3, 600, GScreenW - 6, 130)];
    view.alpha = 0.6;
    view.backgroundColor = [UIColor whiteColor];
    //边框颜色
    view.layer.borderColor = [[UIColor blackColor]CGColor];
    view.layer.borderWidth = 2;
    view.layer.cornerRadius = 24;
    
    //添加按钮
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(10, 5, 100, 100);
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(150, 80, 50, 50);
    self.btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn3.frame = CGRectMake(240, 80, 48, 48);
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(320, 80, 50, 50);
    
    //为btn添加背景图片
    [btn1 setBackgroundImage:[UIImage imageNamed:@"bt1"] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"bt2"] forState:UIControlStateNormal];
    [self.btn3 setBackgroundImage:[UIImage imageNamed:@"bt3"] forState:UIControlStateNormal];
    [btn4 setBackgroundImage:[UIImage imageNamed:@"bt4"] forState:UIControlStateNormal];
    
    //为按钮添加点击事件
    [btn1 addTarget:self action:@selector(againMusic) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(beforeMusic)  forControlEvents:UIControlEventTouchUpInside];
    [self.btn3 addTarget:self action:@selector(goMusic)  forControlEvents:UIControlEventTouchUpInside];
    [btn4 addTarget:self action:@selector(nextMusic)  forControlEvents:UIControlEventTouchUpInside];
    
    //添加滚动轮
    self.slider = [[UISlider alloc]initWithFrame:CGRectMake(120, 20, 280, 20)];
    self.slider.thumbTintColor = [UIColor blackColor];
    self.slider.maximumValue   = [SongControl shareSongCtrHandel].durationTime;
    self.slider.minimumValue   = 0;
    
    //滚轮添加事件
    [self.slider addTarget:self action:@selector(moveSlider:) forControlEvents:UIControlEventTouchUpInside];
    
    //添加到view上边
    [view addSubview:btn1];
    [view addSubview:btn2];
    [view addSubview:self.btn3];
    [view addSubview:btn4];
    [view addSubview:self.slider];
    
    [self.view addSubview:view];
}
//再来一遍
-(void)againMusic{
    [self beforeMusic];
    [self nextMusic];
}
//上一曲
-(void)beforeMusic{
    [[SongControl shareSongCtrHandel] previousSong];
}

//暂停播放
-(void)goMusic{
    if ([SongControl shareSongCtrHandel].isPlaying) {
        //点击暂停
        [SongControl shareSongCtrHandel].playOrPause = NO;
        [self.btn3 setBackgroundImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
    }
    else{
        //点击播放
        [SongControl shareSongCtrHandel].playOrPause = YES;
        [self.btn3 setBackgroundImage:[UIImage imageNamed:@"bt3"] forState:UIControlStateNormal];
    }
}

//下一曲
-(void)nextMusic{
    [[SongControl shareSongCtrHandel] nextSong];
}

-(void)moveSlider:(UISlider *)sender{
    //设置播放进度
    [SongControl shareSongCtrHandel].currentTime = sender.value;
}

#pragma mark 实现刷新进度条
-(void)sendCurrentTime:(NSTimeInterval)time{
    //更新进度条
    self.slider.value=time;
}

-(void)updateLrcSelectIndex:(NSInteger)row{
    NSIndexPath *path=[NSIndexPath indexPathForRow:row inSection:0];
    [_tableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

-(void)notficationSongReload{
    [self initViewState];
}

-(void)initViewState{
    [_tableView reloadData];
}




#pragma mark - volume添加音量改变

-(void)volume
{
    //1、定义两个控制声音的按钮
    UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [moreBtn setImage:[UIImage imageNamed:@"moreBtn"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreButton) forControlEvents:UIControlEventTouchUpInside];
    UIButton *lessBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [lessBtn setImage:[UIImage imageNamed:@"lessBtn"] forState:UIControlStateNormal];
    [lessBtn addTarget:self action:@selector(lessButton) forControlEvents:UIControlEventTouchUpInside];
    //添加到barButtonItem上
    UIBarButtonItem *morItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    UIBarButtonItem *lesItem = [[UIBarButtonItem alloc] initWithCustomView:lessBtn];
    NSArray *array = @[morItem,lesItem];
    self.navigationItem.leftBarButtonItems = array;
    
    //2、创建歌词按钮
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"ci"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(showLyric) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
//增加音量
-(void)moreButton
{
    NSLog(@"%.1f",self.player.volume);
    if (self.player.volume > 100) {
        
    }else{
        self.player.volume += 0.1;
    }
    NSLog(@"%.1f",self.player.volume);
    self.alert = [UIAlertController alertControllerWithTitle:@"音量" message:[NSString stringWithFormat:@"%d",(int)self.player.volume] preferredStyle:1];
    [self presentViewController:self.alert animated:YES completion:^{
        
    }];
    NSTimer *timeVolume = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeVolume) userInfo:nil repeats:NO];
    [timeVolume fire];
}

//减小音量
-(void)lessButton
{
    if (self.player.volume < 0) {
        self.player.volume = 0;
    }else{
        self.player.volume = self.player.volume - 1;
    }
    self.alert = [UIAlertController alertControllerWithTitle:@"音量" message:[NSString stringWithFormat:@"%d",(int)self.player.volume] preferredStyle:1];
    [self presentViewController:self.alert animated:YES completion:^{
        
    }];
    NSTimer *timeVolume = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeVolume) userInfo:nil repeats:NO];
    [timeVolume fire];
}
//弹框消失
-(void)changeVolume{
    [self.alert dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//是否显示歌词
-(void)showLyric
{
    if (!self.isRight) {
        self.tableView.alpha = 0;
        self.isRight = YES;
    }else if (self.isRight){
        self.tableView.alpha = 1;
        self.isRight = NO;
    }
}



-(void)viewWillDisappear:(BOOL)animated{
    //设置代理为空
    [SongControl shareSongCtrHandel].delegate=nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
