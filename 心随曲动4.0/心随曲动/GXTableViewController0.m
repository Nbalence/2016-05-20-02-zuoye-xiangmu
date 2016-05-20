//
//  GXTableViewController0.m
//  心随曲动
//
//  Created by qingyun on 16/5/12.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "GXTableViewController0.h"
#import "GXTVCchangeName.h"

@interface GXTableViewController0 ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *desLabel;


@property (nonatomic,strong) GXTVCchangeName *changeName;


@end

@implementation GXTableViewController0

- (void)viewDidLoad {
    [super viewDidLoad];
    

    //裁剪头像
    _imgView.layer.cornerRadius = 30.0;
    _imgView.layer.masksToBounds = YES;
    _imgView.image = [UIImage imageNamed:@"tx.jpg"];
    
    
    self.nameLabel.text = self.changeName.nameL;
    self.desLabel.text = self.changeName.desL;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

//// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"changeLab"]) {
        GXTVCchangeName *cVC = segue.destinationViewController;
        [cVC setValue:_nameLabel.text forKey:@"nameL"];
        [cVC setValue:_desLabel.text forKey:@"desL"];
        
        void (^changeLab)(NSString *text) = ^(NSString *value){
            _nameLabel.text = value;
            
        };
        void (^changeLab2)(NSString *text) = ^(NSString *value){
            _desLabel.text = value;
        };
        [cVC setValue:changeLab forKey:@"changeLabel"];
        [cVC setValue:changeLab2 forKey:@"changeLabel2"];
    }
}


@end
