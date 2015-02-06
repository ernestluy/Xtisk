//
//  HisAccSelectView.m
//  Xtisk
//
//  Created by zzt on 15/2/6.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "HisAccSelectView.h"
#import "HisLoginAcc.h"
@implementation HisAccSelectView


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    [self layoutView];
    return self;
}
-(void)layoutView{
    scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:scrollView];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor darkGrayColor].CGColor;
}

-(void)setHisArr:(NSArray *)arr{
    int iw = self.frame.size.height;
    int ih = iw;
    
    scrollView.contentSize = CGSizeMake(iw *arr.count, ih);
    
    int iconw = 40;
    int nameH = 20;
    int nY = (self.frame.size.height - iconw - nameH)/2;
    for (int i = 0; i<arr.count; i++) {
        HisLoginAcc *la = [arr objectAtIndex:i];
        UIButton *btnHeader = [UIButton buttonWithType:UIButtonTypeCustom];
        btnHeader.frame = CGRectMake((iw - iconw)/2 + iw *i, nY, iconw, iconw);
        [btnHeader setBackgroundImage:la.headerIcon forState:UIControlStateNormal];
        [btnHeader addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btnHeader];
        btnHeader.tag = i;
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(iw *i, nY + iconw , iw, nameH)];
        name.font = [UIFont systemFontOfSize:13];
        name.textColor = [UIColor darkGrayColor];
        [scrollView addSubview:name];
        name.textAlignment = NSTextAlignmentCenter;
        
        name.text = la.account;
    }
}
-(void)selectAction:(UIButton*)btn{
    NSLog(@"tag:%d",(int)btn.tag);
}
@end
