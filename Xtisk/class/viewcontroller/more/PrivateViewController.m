//
//  PrivateViewController.m
//  Xtisk
//
//  Created by zzt on 15/2/9.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "PrivateViewController.h"
#import "PublicDefine.h"
#import "PopoverView.h"
#import "CTLCustom.h"
#import "EditTextViewController.h"
#import "SVProgressHUD.h"
#import "Util.h"
@interface PrivateViewController ()
{
    NSArray *titleArr;
    UIActionSheet *tActionSheet;
    NSDateFormatter *dateFormatter;
    
    UIDatePicker *birthPicker;
    
    UILabel *labNick;
    UILabel *labAccount;
    UILabel *labSign;
    UILabel *labSex;
    UILabel *labBirthDate;
    UILabel *labMarStatus;
    UILabel *labCom;
    
    UIImageView *headerImageView;
    
    int headerCellHeight;
    
    int catchPhotoMethod;
    
}
-(void)datePickerAction:(id)sender;
@end

@implementation PrivateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    headerCellHeight = 100;
    titleArr = @[@"我的头像",@"我的昵称",@"账号",@"个性签名",@"性别",@"生日",@"婚姻状况",@"企业"];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    self.title = @"个人信息";
}


-(UILabel*)getCusRightLabel:(CGRect)rect{
    UILabel *lab = [[UILabel alloc]initWithFrame:rect];
    lab.textAlignment = NSTextAlignmentRight;
    lab.textColor = [UIColor darkGrayColor];
//    lab.backgroundColor = [UIColor yellowColor];
    lab.font = [UIFont systemFontOfSize:14];
    return lab;
}
-(void)datePickerAction:(id)sender;{
    UIView *dp = (UIView *)sender;
    switch (dp.tag) {
        case 0:{
            if (labBirthDate == nil) {
                return;
            }
            
            labBirthDate.text = [dateFormatter stringFromDate:birthPicker.date];
            birthPicker = nil;
            if (self.tPopView) {
                [self.tPopView dismiss];
                self.tPopView = nil;
            }
            break;
        }
        default:
            break;
    }
}
- (void)dismissActionSheet:(id)sender
{
    [tActionSheet dismissWithClickedButtonIndex:0 animated:YES];
    tActionSheet = nil;
}

#pragma mark -EditTextViewDelegate
- (void)editTextDone:(NSString *)str type:(int)ty{
    if (PrivateEditTextSign == ty) {
        NSLog(@"签名");
        labSign.text = str;
    }else if(PrivateEditTextCom == ty) {
        NSLog(@"企业");
        labCom.text = str;
    }
}
#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArr.count;
}


-(UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = [NSString stringWithFormat:@"cell_%d",(int)indexPath.row];
    UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
    if (cell ==nil) {
        CGRect cRect = CGRectMake(tv.frame.size.width - 30 - 190, 0, 190.0, DEFAULT_CELL_HEIGHT);
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor darkGrayColor];
        switch (indexPath.row) {
            case 0:{
                int headerW = 65;
                
                headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 100, (headerCellHeight - headerW)/2, headerW, headerW)];
                headerImageView.layer.masksToBounds = YES;
                headerImageView.layer.cornerRadius = headerImageView.frame.size.width/2;
                headerImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
                headerImageView.layer.borderWidth = 0.7;
                headerImageView.image = [UIImage imageNamed:@"default_header_black"];
                [cell addSubview:headerImageView];
                break;
            }
            case 1:{
                labNick = [self getCusRightLabel:cRect];
                [cell addSubview:labNick];
                labNick.text = @"luyi";
                break;
            }
            case 2:{
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryNone;
                labAccount = [self getCusRightLabel:cRect];
                [cell addSubview:labAccount];
                labAccount.text = @"13418884362";
                break;
            }
            case 3:{
                labSign= [self getCusRightLabel:cRect];
                [cell addSubview:labSign];
                labSign.text = @"这是我的签名";
                break;
            }
            case 4:{
                labSex= [self getCusRightLabel:cRect];
                [cell addSubview:labSex];
                labSex.text = @"男";
                break;
            }
            case 5:{
                labBirthDate = [self getCusRightLabel:cRect];
                [cell addSubview:labBirthDate];
                labBirthDate.text = @"1988-08-8";
                //                cell.accessoryView  = labBirthDate;
                break;
            }
            case 6:{
                labMarStatus= [self getCusRightLabel:cRect];
                [cell addSubview:labMarStatus];
                labMarStatus.text = @"未婚";
                break;
            }
            case 7:{
                labCom= [self getCusRightLabel:cRect];
                [cell addSubview:labCom];
                labCom.text = @"兴天技术责任有限公司";
                break;
            }
            default:
                break;
         }
    }
    
    cell.textLabel.text = [titleArr objectAtIndex:(int)indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, MORE_HEIGHT)];
//    view.backgroundColor = [UIColor redColor];
//    return view;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return headerCellHeight;
    }
    return DEFAULT_CELL_HEIGHT;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 1.0;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"设置头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
            [as showInView:[UIApplication sharedApplication].keyWindow];
            break;
        }
        case 1:{
            
            break;
        }
        case 2:{
            
            break;
        }
        case 3:{
            EditTextViewController *et = [[EditTextViewController alloc]initWithType:PrivateEditTextSign delegate:self];
            [self.navigationController pushViewController:et animated:YES];
            break;
        }
        case 7:{
            EditTextViewController *et = [[EditTextViewController alloc]initWithType:PrivateEditTextCom delegate:self];
            [self.navigationController pushViewController:et animated:YES];
            break;
        }
        case 5:{
            [self changeBirthDate];
            break;
        }
        default:
            break;
    }
    
}

#pragma mark - UIDatePicker


-(void)changeBirthDate
{
    CGRect rt = [UIScreen mainScreen].bounds;
    UIView *tView = [[UIView alloc]init];
    
    UIView *toolbar = [[UIView alloc]initWithFrame: CGRectMake(0.0f, 0.0f,rt.size.width, 44.0f)];
    toolbar.backgroundColor = [UIColor lightGrayColor];
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setTitle:@"确定" forState:UIControlStateNormal];
    doneButton.tag = 0;
    doneButton.layer.borderWidth = 1;
    doneButton.layer.borderColor = [UIColor whiteColor].CGColor;
    doneButton.layer.cornerRadius = 4;
    doneButton.frame = CGRectMake(CGRectGetMaxX(toolbar.frame) - 70.0, 4, 64.0, 44.0-8);
    [doneButton addTarget: self action: @selector(datePickerAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolbar addSubview: doneButton];
    [tView addSubview: toolbar];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, rt.size.width, 216)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.tag = 0;
    birthPicker = datePicker;
    [tView addSubview:datePicker];
    if (labBirthDate.text && labBirthDate.text.length>4) {
        NSDate *date = [dateFormatter dateFromString:labBirthDate.text];
        datePicker.date = date;
    }
    
    
    int allH = 216 + 44;
    tView.frame = CGRectMake(0, rt.size.height - allH, rt.size.width, allH);
    
    
    self.tPopView = [PopoverView showPopoverAtPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 ) inView:self.view withContentView:tView];
    
}
#pragma mark -
- (void)choosePhoto:(id)sender{
    

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    if ( catchPhotoMethod == 0) {
        //相册
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }else if(catchPhotoMethod == 1){
        //拍照
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [SVProgressHUD showErrorWithStatus:@"模拟器不支持拍照" duration:2];
            return;
        }
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex:%d",(int)buttonIndex);
    catchPhotoMethod = (int)buttonIndex;
    if ( 0 == buttonIndex) {
        //相册
        [self choosePhoto:nil];
    }else if (1 == buttonIndex){
        //拍照
        [self choosePhoto:nil];
    }else if (2 == buttonIndex){
        //cancel
        return;
    }
}
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet{
    NSLog(@"%@",actionSheet);
}
- (void)didPresentActionSheet:(UIActionSheet *)actionSheet{
    NSLog(@"%@",actionSheet);
}


#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *tmpImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    UIImage *rImg =  [Util reSizeImage:tmpImage toSize:CGSizeMake(200, 200)]; //[tmpImage imageByScalingToSize:CGSizeMake(100, 100)];
    headerImageView.image = rImg;
    [XTFileManager writeImage:rImg toFileAtPath:PathDocFile(@"myheader.jpg")];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    
    return UIInterfaceOrientationMaskPortrait;
    
}
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
