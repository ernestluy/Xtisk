//
//  MoreTableViewHeaderView.m
//  Xtisk
//
//  Created by zzt on 15/2/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MoreTableViewHeaderView.h"

@implementation MoreTableViewHeaderView


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    return self;
}
-(id)init{
    self = [super init];
    return self;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    return self;
}

-(void)inSetDataWith:(IUser *)tuser{
    self.inLabName.text = tuser.nickName;
    self.inLabAccount.text = tuser.phone;
    self.inLabSign.text = @"哈哈";//tuser.signature;
}
@end
