//
//  PosterCollectionViewCell.m
//  Xtisk
//
//  Created by zzt on 15/2/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "PosterCollectionViewCell.h"
#import "PublicDefine.h"
@implementation PosterCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    NSLog(@"awakeFromNib");
    self.labelContent.numberOfLines = 2;
    self.labelContent.textAlignment = NSTextAlignmentLeft;
    self.labelContent.lineBreakMode = NSLineBreakByTruncatingTail;//NSLineBreakByWordWrapping;
    self.labelContent.text = @"网谷杯，IT青年足球赛正式开赛，有胆你就来，大奖在等你！";
    self.viewAlphe.backgroundColor = _rgb2uic(0x000000, 0.5);
    
    self.layer.borderColor = _rgb2uic(0xdbdbdb, 1).CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = XT_CORNER_RADIUS;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    return self;
}
@end
