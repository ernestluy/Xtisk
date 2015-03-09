//
//  BadgeView.m
//  Xtisk
//
//  Created by zzt on 15/3/9.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "BadgeView.h"

@implementation BadgeView

-(void)setTnum:(int)num{
    strNum = [NSString stringWithFormat:@"%d",num];
    [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 0 blue: 0 alpha: 1];
    
    //// Oval Drawing
    CGRect ovalRect = CGRectMake(0, 0, 15, 15);
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: ovalRect];
    [color setFill];
    [ovalPath fill];
    {
        NSString* textContent = strNum;
        UIFont* ovalFont = [UIFont systemFontOfSize: 8];
        [UIColor.whiteColor setFill];
        [textContent drawInRect: CGRectOffset(ovalRect, 0, (CGRectGetHeight(ovalRect) - [textContent sizeWithFont: ovalFont constrainedToSize: ovalRect.size lineBreakMode: NSLineBreakByWordWrapping].height) / 2) withFont: ovalFont lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
    }

}


@end
