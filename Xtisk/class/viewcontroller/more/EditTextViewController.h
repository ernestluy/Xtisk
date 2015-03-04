//
//  EditTextViewController.h
//  Xtisk
//
//  Created by 卢一 on 15/2/9.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
@protocol EditTextViewDelegate <NSObject>
- (void)editTextDone:(NSString *)str type:(int)ty;
@end
@interface EditTextViewController : SecondaryViewController<UITextViewDelegate ,AsyncHttpRequestDelegate>
{
    int tType;
}

@property(nonatomic,weak)IBOutlet UITextView *tTextView;
@property(nonatomic,weak)IBOutlet UILabel *labWarnning;
@property(nonatomic,weak)id<EditTextViewDelegate> tDelegate;
@property(nonatomic)int tType;
@property(nonatomic) int storeId;
@property(nonatomic) int activityId;

-(id)initWithType:(int)type delegate:(id<EditTextViewDelegate>) delegate;
@end
