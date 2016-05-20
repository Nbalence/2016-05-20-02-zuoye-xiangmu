//
//  GXTVCchangeName.h
//  心随曲动
//
//  Created by qingyun on 16/5/12.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GXTVCchangeName : UIViewController
@property (nonatomic,strong) NSString *nameL;
@property (nonatomic,strong) NSString *desL;
@property (nonatomic,strong) void (^changeLabel)(NSString *);
@property (nonatomic,strong) void (^changeLabel2)(NSString *);


@end
