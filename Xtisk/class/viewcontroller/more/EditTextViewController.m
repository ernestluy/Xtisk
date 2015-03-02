//
//  EditTextViewController.m
//  Xtisk
//
//  Created by zzt on 15/2/9.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "EditTextViewController.h"
#import "PublicDefine.h"
@interface EditTextViewController ()
{
    int limitNum;
}
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
    if (tType == PrivateEditTextNick) {
        self.title = @"昵称";
        limitNum = 15;
    }
    else if (tType == PrivateEditTextSign) {
        self.title = @"修改签名";
        limitNum = 32;
    }else if (tType == PrivateEditTextCom){
        self.title = @"企业";
        limitNum = 32;
    }else if (tType == PrivateEditTextFoodCommend){
        self.title = @"评价";
        limitNum = 160;
    }else if (tType == PrivateEditTextAdvise){
        self.title = @"建议反馈";
        limitNum = 160;
    }
    self.labWarnning.text  = [NSString stringWithFormat:@"%d",limitNum];
    self.tTextView.layer.borderWidth = 1;
    self.tTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tTextView.layer.cornerRadius = 5;
    self.tTextView.backgroundColor = [UIColor whiteColor];
    self.tTextView.delegate = self;
    
    [self.tTextView becomeFirstResponder];
    UIButton * okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(0, 0, 40, 25);
    okBtn.layer.borderWidth = 1;
    okBtn.layer.borderColor = headerColor.CGColor;
    okBtn.layer.cornerRadius = 5;
    okBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:headerColor forState:UIControlStateNormal];
    
    
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
    [SVProgressHUD showWithStatus:DefaultRequestPrompt];
    if (PrivateEditTextFoodCommend == tType) {
        [[[HttpService sharedInstance] getRequestStoreComments:self storeId:int2str(self.storeId) content:self.tTextView.text]startAsynchronous];
    }
//    [self.navigationController popViewControllerAnimated:YES];
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
    }else if (textView.text.length >= limitNum){
        return NO;
    }
    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    int dd = limitNum - (int)textView.text.length;
    self.labWarnning.text = [NSString stringWithFormat:@"%d",dd];
    
}

#pragma mark - AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    switch (request.m_requestType) {
        
        case HttpRequestType_XT_STORECOMMENTS:{
            if ( HttpResponseTypeFinished == responseCode) {
                BaseResponse *br = [[HttpService sharedInstance] dealResponseData:request.receviedData];
                
                if (ResponseCodeSuccess == br.code) {
                    [SVProgressHUD showSuccessWithStatus:@"评价成功" duration:DefaultRequestDonePromptTime];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [SVProgressHUD showErrorWithStatus:br.msg duration:1.5];
                }
            }else{
                //XT_SHOWALERT(@"请求失败");
                NSLog(@"请求失败");
            }
            break;
        }
        default:
            break;
    }
}

@end
