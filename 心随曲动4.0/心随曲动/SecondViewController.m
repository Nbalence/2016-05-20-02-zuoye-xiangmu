//
//  SecondViewController.m
//  心随曲动
//
//  Created by qingyun on 16/5/7.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "SecondViewController.h"
#import <UIImageView+WebCache.h>
#import "ViewController.h"

#define GScreenW [UIScreen mainScreen].bounds.size.width
#define GScreenH [UIScreen mainScreen].bounds.size.height

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate>
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    //设置左边返回按钮
    self.navigationItem.leftItemsSupplementBackButton = YES;
    
    self.lrcArray = [[NSMutableArray alloc] init];
    self.lrcTime  = [[NSMutableArray alloc] init];
    self.isPlay  = NO;
    self.isRight = NO;
    //添加界面
    [self addPageView];
    //添加歌词界面
    [self addTableView];
    //添加按钮
    [self addButton];
    //添加音量
    [self volume];
    
}

-(void)addPageView
{
    MusicModels *model = [[MusicModels alloc] init];
    model = [self takeModel];
    
    //调用背景
    [self creatTableViewLrc];
    [self creatBGView:model.blurPicUrl];
    
    //调用光盘方法
    self.picImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self addPicture:model.picUrl];
    self.navigationItem.title = model.name;
    //调用歌词
    [self addLyric:model.lyric];
}

//将传过来的模型解析
-(MusicModels *)takeModel
{
    MusicModels *model = [[MusicModels alloc] init];
    //从viewController中传值过来
    model = [self.songHListArray objectAtIndex:self.i];
    return model;
}

//创建歌词视图
-(void)creatTableViewLrc
{
    self.tableViewBG = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,GScreenW,GScreenH)];

    [self.view addSubview:self.tableViewBG];
}
//-(void)addScrollLeftView
//{
//    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, GScreenW, 736)];
//    img.image = [UIImage imageNamed:@"3.jpg"];
//    [self.tableViewBG addSubview:img];
//}
-(void)creatBGView:(NSString *)str
{
    //背景图片
    self.imageViewSecond = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, GScreenW, 750)];
    //self.imageViewSecond.image = [UIImage imageNamed:@"bg.jpg"];
    [self.imageViewSecond sd_setImageWithURL:[NSURL URLWithString:str]];
    
    
    [self.tableViewBG addSubview:self.imageViewSecond];
}

//光盘方法
-(void)addPicture:(NSString *)str
{
    self.picImgView.center = CGPointMake(207,120);
    self.picImgView.layer.cornerRadius = 100;
    //self.picImgView.image = [UIImage imageNamed:str];
    
    [self.picImgView sd_setImageWithURL:[NSURL URLWithString:str]];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    CGFloat point = M_PI_4;
    animation.values = @[@(9 * point),@(8 * point),@(7 * point),@(6 * point),@(5 * point),@(4 * point),@(3 * point),@(2 * point),@(point)];
    animation.repeatCount = MAXFLOAT;
    animation.duration = 5;
    
    [self.picImgView.layer addAnimation:animation forKey:nil];
    [self.picImgView.layer setMasksToBounds:YES];
    [self.tableViewBG addSubview:self.picImgView];
}

//歌词部分
-(void)addLyric:(NSString *)str
{
    NSArray *array = [str componentsSeparatedByString:@"\n"];
    for (int i = 0; i < [array count]; i++) {
        
        NSString *lineString = [array objectAtIndex:i];
        NSArray *lineArray = [lineString componentsSeparatedByString:@"]"];
        if ([lineArray[0] length] > 8) {
            NSString *str1 = [lineString substringWithRange:NSMakeRange(3, 1)];
            NSString *str2 = [lineString substringWithRange:NSMakeRange(6, 1)];
            if ([str1 isEqualToString:@":"] && [str2 isEqualToString:@"."]) {
                for (int i = 0; i < lineArray.count - 1; i++) {
                    NSString *lrcString = [lineArray objectAtIndex:lineArray.count - 1];
                    //分割区间求歌词时间
                    NSString *timeString = [[lineArray objectAtIndex:i] substringWithRange:NSMakeRange(1, 5)];
                    //把时间 和 歌词 加入
                    [self.lrcTime addObject:timeString];
                    [self.lrcArray addObject:lrcString];
                }
            }
        }
    }
}

-(void)addTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(30, 290, 350, 200)];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    
    [self.tableViewBG addSubview:self.tableView];
}



#pragma mark - 播放歌曲
//音乐播放器

- (void)musicplay:(NSString *)str{
    
    
    //    播放器运行
    NSString *urlStr = [NSString stringWithFormat:@"%@",str];
    
    NSURL *url = [[NSURL alloc]initWithString:urlStr];
    
    NSData * audioData = [NSData dataWithContentsOfURL:url];
    
    
    self.player = [[AVAudioPlayer alloc]initWithData:audioData error:nil];
    
    
    
    
    [self.player prepareToPlay];
    
    self.player.delegate = self;
    
    self.player.volume = 8;
    
    [self.player play];
    
}


#pragma mark - UITableView代理和数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lrcArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:1 reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    //具体每一行的歌词
    cell.textLabel.text = [self.lrcArray objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.textColor = [UIColor cyanColor];
    tableView.separatorStyle = UITableViewCellEditingStyleNone;
    //设置文字高亮颜色
    cell.textLabel.highlightedTextColor = [UIColor colorWithRed:0.2 green:0.3 blue:0.9 alpha:1];
    
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
    self.btn3.frame = CGRectMake(240, 80, 50, 50);
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
    [self.btn3 addTarget:self action:@selector(goOn)  forControlEvents:UIControlEventTouchUpInside];
    [btn4 addTarget:self action:@selector(nextMusic)  forControlEvents:UIControlEventTouchUpInside];
    
    //添加滚动轮
    self.slider = [[UISlider alloc]initWithFrame:CGRectMake(120, 20, 280, 20)];
    self.slider.thumbTintColor = [UIColor blackColor];
    self.slider.maximumValue   = self.player.duration;
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
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(changeTime) userInfo:nil repeats:YES];
    //启动定时器
    [self.timer fire];
    
}



//点击按钮之后的事件触发
-(void)MusicClick
{
    MusicModels *model = [[MusicModels alloc] init];
    model = [self takeModel];
    self.lrcArray = [[NSMutableArray alloc] init];
    self.lrcTime  = [[NSMutableArray alloc] init];
    self.navigationItem.title = model.name;
    [self.imageViewSecond sd_setImageWithURL:[NSURL URLWithString:model.blurPicUrl]];
    [self.picImgView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    [self musicplay:model.mp3Url];
    [self addLyric:model.lyric];
    [self.tableView reloadData];
}

//再次播放
-(void)againMusic
{
    NSLog(@"再次播放");
    [self beforeMusic];
    [self nextMusic];
}
//上一曲
-(void)beforeMusic
{
    NSLog(@"上一曲");
    self.i = self.i - 1;
    [self MusicClick];
}
//暂停|播放
-(void)goOn
{
    if (self.isPlay == YES) {
        [self.player play];
        self.isPlay = NO;
        [self.btn3 setBackgroundImage:[UIImage imageNamed:@"bt3"] forState:UIControlStateNormal];
    }
    else
    {
        [self.player pause];
        self.isPlay = YES;
        [self.btn3 setBackgroundImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
    }
}
//下一曲
-(void)nextMusic
{
    NSLog(@"下一曲");
    self.i = self.i +1;
    [self MusicClick];
}

//滚轮
-(void)moveSlider:(UISlider *)slider
{
    //暂停计时
    [self.timer setFireDate:[NSDate distantFuture]];
    self.player.currentTime = slider.value;
    NSTimer *timeOnce = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerOnce) userInfo:nil repeats:NO];
    //启动定时器
    [timeOnce fire];
}

-(void)timerOnce
{
    //开始计时
    [self.timer setFireDate:[NSDate distantPast]];
}
-(void)changeTime
{
    self.slider.value = self.player.currentTime;
    [self currentTimes];
}

-(void)currentTimes
{
    int h = 0,m = 0, s = 0;
    NSString *mStr = nil;
    NSString *sStr = nil;
    m = (int)(self.player.currentTime - h * 360)/60;
    s = (int)self.player.currentTime % 60;
    if (m < 10) {
        mStr = [NSString stringWithFormat:@"0%d",m];
    }else
    {
        mStr = [NSString stringWithFormat:@"%d",m];
    }
    if (s < 10) {
        sStr = [NSString stringWithFormat:@"0%d",s];
    }else{
        sStr = [NSString stringWithFormat:@"%d",s];
    }
    NSString *cur = [mStr stringByAppendingString:@":"];
    self.currentTime = [cur stringByAppendingString:sStr];
    
    if (self.lrcTime != nil && self.lrcArray != nil) {
        for (int i = 0; i < self.lrcTime.count; i ++) {
            if ([self.lrcTime[i] isEqualToString:self.currentTime]) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            }
        }
    }
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

    if (self.player.volume > 100) {
        
    }else{
        self.player.volume = self.player.volume + 1;
    }
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
#pragma mark - AVPlayer 数据源方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    [self nextMusic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
