//
//  ViewController.m
//  02-色块移动
//
//  Created by qingyun on 16/4/25.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (nonatomic)       CGRect image1;
@property (nonatomic)       CGRect image2;
@property (nonatomic)       CGRect image3;





@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //打开用户交互
    self.view.multipleTouchEnabled = YES;
    
    //记录三个图片初始位置
    _image1 = _img1.frame;
    _image2 = _img2.frame;
    _image3 = _img3.frame;
  
}

//1、先判断当前的点是否在其中一个视图上
-(BOOL)isImageOnView:(CGPoint)point
{
    if (CGRectContainsPoint(_img1.frame, point)||CGRectContainsPoint(_img2.frame, point)||(CGRectContainsPoint(_img3.frame, point))) {
        return YES;
    }
    return NO;
}
//2、开始移动的时候
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1、获取手指对象
    UITouch *touch = [touches anyObject];
    //2、获取点击的点
    CGPoint point = [touch locationInView:self.view];
    //3、点击次数
    NSInteger tapCount = touch.tapCount;
    
    //视图判断
    if (tapCount == 1) {
        
    if ([self isImageOnView:point]) {
        [UIView animateWithDuration:.5 animations:^{
            UIImageView *img = (UIImageView *)touch.view;
            img.transform = CGAffineTransformMakeScale(1.2, 1.2);
            //img.center = point;
        }];
    }
        }
    else if (tapCount == 2)
    {
        //双击三张图片都返回原来位置
        [UIView animateWithDuration:.4 animations:^{
            _img1.frame = _image1;
            _img2.frame = _image2;
            _img3.frame = _image3;
        }];
    }
}


//移动过程
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1、获取手势对象
    UITouch *touch = [touches anyObject];
    //2、获取当前的点
    CGPoint point = [touch locationInView:self.view];
    //3、将中间那个红色置顶
    [self.view bringSubviewToFront:_img2];
    
    //判断，分别将另外两个中心位置都结合
    if (CGRectContainsPoint(_img1.frame, point)) {
        [UIView animateWithDuration:.4 animations:^{
            _img1.center = point;
        }];
    }
    if (CGRectContainsPoint(_img2.frame, point)) {
        [UIView animateWithDuration:.4 animations:^{
            _img2.center = point;
        }];
    }
    if (CGRectContainsPoint(_img3.frame, point)) {
        [UIView animateWithDuration:.4 animations:^{
            _img3.center = point;
        }];
    }
    
}

//移动结束
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint  point = [touch locationInView:self.view];
    //在三个图片中心位置在同一点的前提下
    if ([self isImageOnView:point]) {
        [UIView animateWithDuration:.4 animations:^{
            _img1.transform = CGAffineTransformIdentity;
            _img2.transform = CGAffineTransformIdentity;
            _img3.transform = CGAffineTransformIdentity;
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
