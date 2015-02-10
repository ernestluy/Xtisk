//
//  EditTextViewController.m
//  Xtisk
//
//  Created by zzt on 15/2/9.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "EditTextViewController.h"

@interface EditTextViewController ()

@end

@implementation EditTextViewController


-(id)initWithType:(int)type delegate:(id<EditTextViewDelegate>) delegate{
    self = [super init];
    self.tDelegate = delegate;
    tType = type;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (tType == 0) {
        self.title = @"修改签名";
    }else if (tType == 1){
        self.title = @"企业";
    }
    self.labWarnning.text  = @"32";
    self.tTextView.layer.borderWidth = 1;
    self.tTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tTextView.layer.cornerRadius = 5;
    self.tTextView.backgroundColor = [UIColor whiteColor];
    self.tTextView.delegate = self;
    
    [self.tTextView becomeFirstResponder];
    UIButton * okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(0, 0, 40, 28);
    okBtn.layer.borderWidth = 1;
    okBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    okBtn.layer.cornerRadius = 5;
    okBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [okBtn addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * ritem = [[UIBarButtonItem alloc] initWithCustomView:okBtn] ;
    [self.navigationItem setRightBarButtonItem:ritem];
    
    [self textViewDidChange:self.tTextView];
}
-(void)submit:(id)sender{
    NSLog(@"submit");
    [self.tTextView resignFirstResponder];
    if (self.tDelegate &&  [self.tDelegate respondsToSelector:@selector(editTextDone:type:)]) {
        [self.tDelegate editTextDone:self.tTextView.text type:tType];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -  UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *gStr = text;
    if ([gStr isEqualToString:@""]) {//删除
        
    }else if ([gStr isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }else if (textView.text.length >= 32){
        return NO;
    }
    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    int dd = 32 - (int)textView.text.length;
    self.labWarnning.text = [NSString stringWithFormat:@"%d",dd];
}
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
