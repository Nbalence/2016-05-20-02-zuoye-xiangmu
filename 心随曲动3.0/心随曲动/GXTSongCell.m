//
//  GXTSongCell.m
//  01-本地歌曲
//
//  Created by qingyun on 16/5/17.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "GXTSongCell.h"
#import "SongMode.h"

@interface GXTSongCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *songName;
@property (weak, nonatomic) IBOutlet UILabel *songType;
@end

@implementation GXTSongCell

//重写set方法
-(void)setMode:(SongMode *)mode
{
    _mode = mode;
    _songName.text = mode.kName;
    _songType.text = mode.kType;
    _songType.font = [UIFont systemFontOfSize:14];
    _imgView.image = [UIImage imageNamed:mode.icon];
    
    _imgView.layer.cornerRadius  = 38;
    _imgView.layer.masksToBounds = YES;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
