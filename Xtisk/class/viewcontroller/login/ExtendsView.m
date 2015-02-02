//
//  ExtendsView.m
//  LoginDemo
//
//  Created by 兴天科技 on 14-3-3.
//  Copyright (c) 2014年 兴天科技. All rights reserved.
//

#import "ExtendsView.h"

@implementation ExtendsView
@synthesize extendsDelegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"pointInside");
    // if the menu state is expanding, everywhere can be touch
    // otherwise, only the add button are can be touch
    if (CGRectContainsPoint(self.frame, point)) {
        return YES;
    }else{
        
        [extendsDelegate closeExtendsView];
        return NO;
    }
    return YES;
}

@end
