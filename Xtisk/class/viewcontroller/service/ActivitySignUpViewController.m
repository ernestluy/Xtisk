//
//  ActivitySignUpViewController.m
//  Xtisk
//
//  Created by 卢一 on 15/2/20.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ActivitySignUpViewController.h"
#import "PublicDefine.h"
#import "CTLCustom.h"
#import "PopoverView.h"
@interface ActivitySignUpViewController ()
{
    NSMutableArray *titleArr;
    UITextField *tfNme;
    UITextField *tfTel;
    UILabel *labGender;
    UITextField *tfEmail;
    
    UITextField *nowTextField;
    
    PopoverView *tPopView;
    UIPickerView *mPickerView;
    
    NSArray *genderArr;
}
@end

@implementation ActivitySignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"填写报名信息";
    genderArr = @[@"男",@"女"];
    titleArr = [NSMutableArray arrayWithArray:@[@"姓名:",@"手机号码:",@"性别:",@"邮箱:"]];
    CGRect bounds = [UIScreen mainScreen].bounds;
    //    CGRectMake(0, 64, mRect.size.width, mRect.size.height - 64)
    CGRect tableRect = CGRectMake(0, 0, bounds.size.width, bounds.size.height - 64);
    tTableView = [[UITableView alloc]initWithFrame:tableRect style:UITableViewStyleGrouped];
    [self.view addSubview:tTableView];
    tTableView.dataSource = self;
    tTableView.delegate = self;
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, bounds.size.width, 60)];
    footView.backgroundColor = [UIColor clearColor];
    tTableView.tableFooterView = footView;
    
    UIButton *btnOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    int startX = 15;
    btnOrder.frame = CGRectMake(startX, 10, bounds.size.width - 15*2, 40);
    [btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnOrder setTitle:@"报名" forState:UIControlStateNormal];
    [btnOrder setBackgroundImage:[UIImage imageNamed:@"radiu_done"] forState:UIControlStateNormal];
    btnOrder.backgroundColor = [UIColor clearColor];
    [btnOrder addTarget:self action:@selector(signUp:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:btnOrder];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.view addGestureRecognizer:tap];
    
}

-(void)changeGenderDone{
    labGender.text = [genderArr objectAtIndex:[mPickerView selectedRowInComponent:0]];
    if (tPopView) {
        [tPopView dismiss];
    }
}

-(void)selectGender:(id)sender{
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
    [doneButton addTarget: self action: @selector(changeGenderDone) forControlEvents:UIControlEventTouchUpInside];
    [toolbar addSubview: doneButton];
    [tView addSubview: toolbar];
    
    UIPickerView *pv = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, rt.size.width, 216)];
    pv.delegate = self;
    pv.dataSource = self;
    [tView addSubview:pv];
    mPickerView = pv;
    
    int allH = 216 + 44;
    tView.frame = CGRectMake(0, rt.size.height - allH, rt.size.width, allH);
    
    
    tPopView = [PopoverView showPopoverAtPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 ) inView:self.view withContentView:tView];
}


-(void)signUp:(id)sender{
    NSLog(@"signUp");
}
-(void)tapped:(UITapGestureRecognizer *)tap
{
    if (nowTextField) {
        [nowTextField resignFirstResponder];
    }
    
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
    
    return [genderArr objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}

#pragma mark textfieldDelegate
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    
    if (tfNme == textField) {
        [tfTel becomeFirstResponder];
    }else if (tfTel == textField) {
        [tfEmail becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location >= 40)
    {
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    nowTextField = textField;
    return YES;
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
    NSString *identifier = [NSString stringWithFormat:@"cell%d%d",(int)indexPath.section,(int)indexPath.row];
    UITableViewCell * cell = [tv dequeueReusableCellWithIdentifier:identifier];
    
    if (cell ==nil) {
        int textFieldWidth = 170;
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [titleArr objectAtIndex:indexPath.row];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        int startX = 15 + [cell.textLabel.text sizeWithFont:cell.textLabel.font].width + 5 ;
        CGRect textFieldRect = CGRectMake(startX, 0.0f, textFieldWidth, 44.0);
        
        if (2 == indexPath.row) {
            UILabel *tLab = [CTLCustom getCusRightLabel:textFieldRect];
            [cell addSubview:tLab];
            tLab.textAlignment = NSTextAlignmentLeft;
            labGender = tLab;
            tLab.text = @"男";
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, 320, 44);
            [btn addTarget:self action:@selector(selectGender:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn];
        }else{
            UITextField *theTextField = [[UITextField alloc] initWithFrame:textFieldRect];
            theTextField.textAlignment = NSTextAlignmentLeft;
            theTextField.tag = indexPath.row;
            theTextField.returnKeyType = UIReturnKeyNext;
            theTextField.delegate = self;
            theTextField.placeholder = @"请输入";
            theTextField.font = cell.textLabel.font;
            [cell addSubview:theTextField];
            //        theTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            if (0 == indexPath.row) {
                tfNme = theTextField;
            }else if (1 == indexPath.row) {
                tfTel = theTextField;
            }else if (3 == indexPath.row) {
                tfEmail = theTextField;
                theTextField.returnKeyType = UIReturnKeyDone;
            }
        }
        
    }
    
    return cell;
    
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
