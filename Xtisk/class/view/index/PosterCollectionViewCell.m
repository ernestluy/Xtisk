//
//  PosterCollectionViewCell.m
//  Xtisk
//
//  Created by zzt on 15/2/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "PosterCollectionViewCell.h"
#import "PublicDefine.h"
@interface PosterCollectionViewCell (){
    BOOL isLoading;
}
@end
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
    self.layer.cornerRadius = XT_CELL_CORNER_RADIUS;
    isLoading = YES;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [super drawRect:rect];
    if (isLoading) {
        //draw mine
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0.859 green: 0.078 blue: 0.078 alpha: 1];
        UIColor* color2 = [UIColor colorWithRed: 0.557 green: 0.548 blue: 0.548 alpha: 1];
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = UIBezierPath.bezierPath;
        [bezierPath moveToPoint: CGPointMake(13.5, 13.5)];
        [bezierPath addLineToPoint: CGPointMake(25.5, 31.5)];
        [bezierPath addLineToPoint: CGPointMake(38.5, 13.5)];
        [bezierPath addLineToPoint: CGPointMake(13.5, 13.5)];
        [bezierPath closePath];
        [color setFill];
        [bezierPath fill];
        [color2 setStroke];
        bezierPath.lineWidth = 2;
        [bezierPath stroke];
    }
}
@end
