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
#import "PublicDefine.h"
#import "SettingViewController.h"
#import "SettingService.h"
@interface PrivateViewController ()
{
    NSArray *titleArr0;
    NSArray *titleArr1;
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
    
    UIPickerView *mgPickerView;
    int pickerType;
    
    
    NSArray *genderArr;
    NSArray *marritalArr;
    
}
-(void)datePickerAction:(id)sender;
@end

@implementation PrivateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect bounds = [[UIScreen mainScreen] applicationFrame];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        bounds = [[UIScreen mainScreen] bounds];
        bounds.size.height = bounds.size.height -20;
        
    }
    genderArr = @[@"男",@"女"];
    marritalArr = @[@"未婚",@"已婚"];
    headerCellHeight = 80;
    titleArr0 = @[@"我的头像",@"我的昵称",@"我的账号"];
    titleArr1 = @[@"性别",@"生日",@"婚姻状况",@"企业",@"个性签名"];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    self.title = @"个人信息";
    
    
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 60)];
    footView.backgroundColor = [UIColor clearColor];
    self.tTableView.tableFooterView = footView;
    
    UIButton *btnOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    int startX = 15;
    btnOrder.frame = CGRectMake(startX, 10, bounds.size.width - 15*2, 40);
    [btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnOrder setTitle:@"注销账号" forState:UIControlStateNormal];
    [btnOrder setBackgroundImage:[UIImage imageNamed:@"radiu_done"] forState:UIControlStateNormal];
    btnOrder.backgroundColor = [UIColor clearColor];
    [btnOrder addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnOrder];
    
    
    
    
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
-(void)logout:(id)sender{
    [[SettingService sharedInstance] logout];
    [self.navigationController popViewControllerAnimated:YES];
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
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return titleArr0.count;
    }else if (1 == section){
        return titleArr1.count;
    }else if (2 == section){
        return 1;
    }
    return 0;
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
//        cell.
        if (0 == indexPath.section) {
            switch (indexPath.row) {
                case 0:{
                    int headerW = 65;
                    
                    headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 100, (headerCellHeight - headerW)/2, headerW, headerW)];
                    headerImageView.layer.masksToBounds = YES;
                    headerImageView.layer.cornerRadius = headerImageView.frame.size.width/2;
                    headerImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
                    headerImageView.layer.borderWidth = 0.7;
                    headerImageView.image = [UIImage imageNamed:@"default_header_gray"];
                    [cell addSubview:headerImageView];
                    break;
                }
                case 1:{
                    labNick = [CTLCustom getCusRightLabel:cRect];
                    [cell addSubview:labNick];
                    labNick.text = @"luyi";
                    break;
                }
                case 2:{
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    labAccount = [CTLCustom getCusRightLabel:cRect];
                    [cell addSubview:labAccount];
                    labAccount.text = @"13418884362";
                    break;
                }
                
                default:
                    break;
            }
            cell.textLabel.text = [titleArr0 objectAtIndex:(int)indexPath.row];
        }else if (1 == indexPath.section){
            switch (indexPath.row) {
                
                case 0:{
                    labSex= [CTLCustom getCusRightLabel:cRect];
                    [cell addSubview:labSex];
                    labSex.text = @"男";
                    break;
                }
                case 1:{
                    labBirthDate = [CTLCustom getCusRightLabel:cRect];
                    [cell addSubview:labBirthDate];
                    labBirthDate.text = @"1988-08-8";
                    //                cell.accessoryView  = labBirthDate;
                    break;
                }
                case 2:{
                    labMarStatus= [CTLCustom getCusRightLabel:cRect];
                    [cell addSubview:labMarStatus];
                    labMarStatus.text = @"未婚";
                    break;
                }
                case 3:{
                    labCom= [CTLCustom getCusRightLabel:cRect];
                    [cell addSubview:labCom];
                    labCom.text = @"兴天技术责任有限公司";
                    break;
                }
                case 4:{
                    labSign= [CTLCustom getCusRightLabel:cRect];
                    [cell addSubview:labSign];
                    labSign.text = @"这是我的签名";
                    break;
                }
                default:
                    break;
            }
            cell.textLabel.text = [titleArr1 objectAtIndex:(int)indexPath.row];
        }else if (2 == indexPath.section){
            if (indexPath.row == 0) {
                cell.backgroundColor = [UIColor clearColor];
                cell.separatorInset = UIEdgeInsetsMake(0, 400, 0, 0);
                UIButton *btnOrder = [UIButton buttonWithType:UIButtonTypeCustom];
                int startX = 15;
                CGRect bounds = [[UIScreen mainScreen] applicationFrame];
                btnOrder.frame = CGRectMake(startX, 10, bounds.size.width - 15*2, 40);
                [btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btnOrder setTitle:@"注销账号" forState:UIControlStateNormal];
                [btnOrder setBackgroundImage:[UIImage imageNamed:@"radiu_done"] forState:UIControlStateNormal];
                btnOrder.backgroundColor = [UIColor clearColor];
                [btnOrder addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:btnOrder];
            }
        }
    }
    
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, MORE_HEIGHT)];
//    view.backgroundColor = [UIColor redColor];
//    return view;
//}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0 && indexPath.section == 0){
        return headerCellHeight;
    }
    if(indexPath.row == 0 && indexPath.section == 2){
        return 50;
    }
    return DEFAULT_CELL_HEIGHT;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.section) {
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
            default:
                break;
        }
    }else if (1 == indexPath.section){
        switch (indexPath.row) {
            
            case 0:{
                pickerType = 0;
                [self changeGenderMarrital:0];
                break;
            }
            
            case 1:{
                [self changeBirthDate];
                break;
            }
            case 2:{
                pickerType = 1;
                [self changeGenderMarrital:1];
                break;
            }
            case 3:{
                EditTextViewController *et = [[EditTextViewController alloc]initWithType:PrivateEditTextSign delegate:self];
                [self.navigationController pushViewController:et animated:YES];
                break;
            }
            case 4:{
                EditTextViewController *et = [[EditTextViewController alloc]initWithType:PrivateEditTextCom delegate:self];
                [self.navigationController pushViewController:et animated:YES];
                break;
            }
            default:
                break;
        }
    }
    
    
}

#pragma mark -
-(void)changeGMAction:(id)sender{
    NSLog(@"changeGMAction");
//    UIButton *btn = (UIButton *)sender;
    if (0 == pickerType) {
        int ir = (int)[mgPickerView selectedRowInComponent:0];
        mgPickerView = nil;
        NSString *rStr = [genderArr objectAtIndex:ir];
        NSLog(@"%@",rStr);
        if (self.tPopView) {
            [self.tPopView dismiss];
            self.tPopView = nil;
        }
    }else if (1 == pickerType){
        int ir = (int)[mgPickerView selectedRowInComponent:0];
        mgPickerView = nil;
        NSString *rStr = [marritalArr objectAtIndex:ir];
        NSLog(@"%@",rStr);
        if (self.tPopView) {
            [self.tPopView dismiss];
            self.tPopView = nil;
        }
    }
}
#pragma mark - UIPickerView 姓别、婚姻状况
-(void)changeGenderMarrital:(int)gm
{
    pickerType = gm;
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
    [doneButton addTarget: self action: @selector(changeGMAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolbar addSubview: doneButton];
    [tView addSubview: toolbar];
    
    UIPickerView *pv = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, rt.size.width, 216)];
    pv.delegate = self;
    pv.dataSource = self;
    [tView addSubview:pv];
    mgPickerView = pv;
    
    int allH = 216 + 44;
    tView.frame = CGRectMake(0, rt.size.height - allH, rt.size.width, allH);
    
    
    self.tPopView = [PopoverView showPopoverAtPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 ) inView:self.view withContentView:tView];
    
}
#pragma mark - UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return genderArr.count;
}
#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (0 == pickerType) {
        return [genderArr objectAtIndex:row];
    }else if (1 == pickerType) {
        return [marritalArr objectAtIndex:row];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}

#pragma mark - UIDatePicker 修改出声年月
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
#pragma mark - 修改头像
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
