//
//  EditTextViewController.h
//  Xtisk
//
//  Created by zzt on 15/2/9.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"

@interface EditTextViewController : SecondaryViewController<UITextViewDelegate >
{
    int tType;
}

@property(nonatomic,weak)IBOutlet UITextView *tTextView;
@property(nonatomic,weak)IBOutlet UILabel *labWarnning;

-(id)initWithType:(int)type;
@end
