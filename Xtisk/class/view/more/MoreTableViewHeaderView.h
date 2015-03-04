//
//  MoreTableViewHeaderView.h
//  Xtisk
//
//  Created by 卢一 on 15/2/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicDefine.h"
@interface MoreTableViewHeaderView : UIView


@property(nonatomic,weak)IBOutlet UIButton *btnLogin;
@property(nonatomic,weak)IBOutlet UIImageView *imageBg;
@property(nonatomic,weak)IBOutlet UIImageView *imageHead;



@property(nonatomic,weak)IBOutlet UIButton *inBtnReset;
@property(nonatomic,weak)IBOutlet UIImageView *inImageBg;
@property(nonatomic,weak)IBOutlet UIImageView *inImageHead;

@property(nonatomic,weak)IBOutlet UILabel *inLabName;
@property(nonatomic,weak)IBOutlet UILabel *inLabAccount;
@property(nonatomic,weak)IBOutlet UILabel *inLabSign;
@property(nonatomic,weak)IBOutlet UIView *inLine;


-(void)inSetDataWith:(IUser *)tuser;
@end
