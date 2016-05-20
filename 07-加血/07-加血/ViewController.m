//
//  ViewController.m
//  07-加血
//
//  Created by qingyun on 16/4/26.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "ViewController.h"
#import "QYModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *View1;
@property (weak, nonatomic) IBOutlet UIView *View2;
@property (weak, nonatomic) IBOutlet UIView *View3;
@property (weak, nonatomic) IBOutlet UIView *View4;

@property (nonatomic,strong)QYModel *models;
@property (nonatomic)       NSInteger count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _models = [[QYModel alloc] init];
    _models.num = 0;
    
    //滑动手势
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureUp:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureDown:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
    
    //添加属性观察者
    [_models addObserver:self forKeyPath:@"num" options:NSKeyValueObservingOptionNew context:NULL];
    
    
}
//- (IBAction)swipeGestureUp:(UISwipeGestureRecognizer *)sender {
//    if (_models.num == 4) {
//        [self showAlert:@"加满喽"];
//    }else
//    {
//        _count = _models.num;
//        _models.num ++;
//        NSLog(@"哈哈");
//    }
//}
//- (IBAction)swipeGestureDown:(UISwipeGestureRecognizer *)sender {
//    if (_models.num == 0) {
//        [self showAlert:@"没血啦"];
//    }
//    else
//    {
//        _count = _models.num;
//        _models.num --;
//        NSLog(@"下来");
//    }
//}
//
//滑动操作
-(void)swipeGestureUp:(UISwipeGestureRecognizer *)recor
{
    if (_models.num == 4) {
        [self showAlert:@"加满喽"];
    }else
    {
        _count = _models.num;
        _models.num ++;
        NSLog(@"哈哈");
    }
    
}
-(void)swipeGestureDown:(UISwipeGestureRecognizer *)recor
{
    if (_models.num == 0) {
        [self showAlert:@"没血啦"];
    }
    else
    {
        _count = _models.num;
        _models.num --;
        NSLog(@"下来");
    }
}


#pragma mark - observeValue监听
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"num"]) {
        //取出新值
        NSInteger numm = [change[@"new"] integerValue] + 100;
        if ((numm - 100) >= _count) {
            UIView *view = [self.view viewWithTag:numm];
            view.backgroundColor = [UIColor colorWithRed:(arc4random()%265)/255.0 green:(arc4random()%265)/255.0 blue:(arc4random()%265)/255.0 alpha:1];
        }
        else if((numm - 100) < _count)
        {
            UIView *view = [self.view viewWithTag:numm + 1];
            view.backgroundColor = [UIColor clearColor];
        }
        
    }
}


-(void)showAlert:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:action];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
