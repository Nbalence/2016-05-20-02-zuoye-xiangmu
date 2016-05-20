//
//  GXTViewController.m
//  心随曲动
//
//  Created by qingyun on 16/5/12.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "GXTViewController.h"

@interface GXTViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *buttonW;

@end

@implementation GXTViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)btnClick:(UIButton *)sender {
    if (_textView.text.length == 0) {
        [self showAlert:@"您没有填写意见哦^_^"];
    }
        _textView.text = nil;
        [self showAlert:@"感谢您的意见！"];
    
}

-(void)showAlert:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:action];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
