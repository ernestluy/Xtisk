//
//  BadgeView.m
//  Xtisk
//
//  Created by zzt on 15/3/9.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "BadgeView.h"

@implementation BadgeView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    return self;
}

-(void)setTnum:(int)num{
    if (num == 0) {
        self.hidden = YES;
        return;
    }
    self.hidden = NO;
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
    CGRect ovalRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: ovalRect];
    [color setFill];
    [ovalPath fill];
    {
        NSString* textContent = strNum;
        CGFloat fs = 10;
        if ([strNum intValue]>100) {
            fs = 10;
        }else{
            fs = 14;
        }
        UIFont* ovalFont = [UIFont systemFontOfSize: fs];
        [UIColor.whiteColor setFill];
        [textContent drawInRect: CGRectOffset(ovalRect, 0, (CGRectGetHeight(ovalRect) - [textContent sizeWithFont: ovalFont constrainedToSize: ovalRect.size lineBreakMode: NSLineBreakByWordWrapping].height) / 2) withFont: ovalFont lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
    }

}


@end
