//
//  EditTextViewController.h
//  Xtisk
//
//  Created by zzt on 15/2/9.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
@protocol EditTextViewDelegate <NSObject>
- (void)editTextDone:(NSString *)str type:(int)ty;
@end
@interface EditTextViewController : SecondaryViewController<UITextViewDelegate >
{
    int tType;
}

@property(nonatomic,weak)IBOutlet UITextView *tTextView;
@property(nonatomic,weak)IBOutlet UILabel *labWarnning;
@property(nonatomic,weak)id<EditTextViewDelegate> tDelegate;

-(id)initWithType:(int)type delegate:(id<EditTextViewDelegate>) delegate;
@end
