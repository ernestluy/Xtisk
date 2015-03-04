//
//  PosterCollectionViewCell.m
//  Xtisk
//
//  Created by 卢一 on 15/2/5.
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
    
    self.backgroundColor = _rgb2uic(0xf6f6f6, 1);
    self.viewAlphe.hidden = YES;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    return self;
}

/*
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    if (isLoading) {
        //draw mine
        //// Color Declarations
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        
        //// Image Declarations
        UIImage* down1 = [UIImage imageNamed: @"down_img"];
        int startX = (rect.size.width - down1.size.width )/2;
        int startY = ( rect.size.height - down1.size.height)/2;
        //// Rectangle Drawing
//        CGRect rectangleRect = CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), down1.size.width, down1.size.height);
//        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: rectangleRect];
        CGContextSaveGState(context);
//        [rectanglePath addClip];
        [down1 drawInRect: CGRectMake(startX, startY, down1.size.width, down1.size.height)];
        CGContextRestoreGState(context);
    }
}
 */
@end
