//
//  StarCommendView.m
//  Xtisk
//
//  Created by 卢一 on 15/2/19.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "StarCommendView.h"
@interface StarCommendView()
{
    float nums;
}
@end
@implementation StarCommendView

-(void)setNums:(float)num{
    nums = num;
    [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Image Declarations
    UIImage* image_good_star = [UIImage imageNamed: @"good_star"];
    UIImage* image_bad_star = [UIImage imageNamed: @"bad_star"];
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 75, 15)];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawTiledImage(context, CGRectMake(0, 0, image_bad_star.size.width, image_bad_star.size.height), image_bad_star.CGImage);
    CGContextRestoreGState(context);
    
    float iw = 75 *(nums/10.0);
    //// Rectangle Drawing
    UIBezierPath* rectanglePath2 = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, iw, 15)];
    CGContextSaveGState(context);
    [rectanglePath2 addClip];
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawTiledImage(context, CGRectMake(0, 0, image_good_star.size.width, image_good_star.size.height), image_good_star.CGImage);
    CGContextRestoreGState(context);
}


@end
