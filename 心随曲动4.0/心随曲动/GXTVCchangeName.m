//
//  GXTVCchangeName.m
//  心随曲动
//
//  Created by qingyun on 16/5/12.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "GXTVCchangeName.h"



//首先自定义一个文件
#define FileName @"person.pilst"

@interface GXTVCchangeName ()
@property (weak, nonatomic) IBOutlet UITextField *textName;
@property (weak, nonatomic) IBOutlet UITextField *textDes;




//文件存储路径
@property (nonatomic,strong) NSString *filePath;
@end

@implementation GXTVCchangeName

//1、懒加载文件路径
-(NSString *)filePath
{
    if (_filePath) {
        return _filePath;
    }
    //1.获取沙河路径
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"%@",docPath);
    //2.创建文件路径
    //2.1合并文件夹取名doc；
    NSString *direPath = [docPath stringByAppendingPathComponent:@"doc"];
    //2.2创建文件夹
    NSError *error;
    if (![[NSFileManager defaultManager] createDirectoryAtPath:direPath withIntermediateDirectories:YES attributes:nil error:&error]) {
        return nil;
    }
    //3.创建文件
    //3.1合并文件路径
    _filePath = [direPath stringByAppendingPathComponent:FileName];
    return _filePath;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textName.text = _nameL;
    _textDes.text = _desL;
    
    

    
    
    //首先是读取数据
    [self loadData];
    
}

#define mark - 读取本地缓存数据
-(void)loadData
{
    //1、读取文件
    NSDictionary *value = [[NSDictionary alloc] initWithContentsOfFile:self.filePath];
    //2、给界面赋值
    _textName.text = value[@"name"];
    _textDes.text = value[@"desc"];
}


- (IBAction)btnClick:(UIButton *)sender {
    if (_changeLabel && _changeLabel2) {
        if ([self saveDatas]) {
            NSLog(@"成功");
        }
        _changeLabel(_textName.text);
        _changeLabel2(_textDes.text);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)saveDatas
{
    NSDictionary *tempDic = @{@"name":_textName.text,@"desc":_textDes.text};
    return [tempDic writeToFile:self.filePath atomically:YES];
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

    
    
    
}
 
 */

@end
