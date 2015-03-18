//
//  MyActivityTableViewCell.m
//  Xtisk
//
//  Created by 卢一 on 15/2/20.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MyActivityTableViewCell.h"
#import "PublicDefine.h"
@interface MyActivityTableViewCell()
{
    int iOriginX;
    int iDelX;
    UIImage *imgSelect;
    UIImage *imgNoSelect;
    
    MyActivity *mAc;
}
@end
@implementation MyActivityTableViewCell

- (void)awakeFromNib {
    // Initialization code
    iOriginX = self.labTitle.frame.origin.x;
    iDelX = iOriginX + 20;
    
    imgSelect = [UIImage imageNamed:@"cell_del_select"];
    imgNoSelect = [UIImage imageNamed:@"cell_del_no_select"];
    [self.btnSelect setImage:imgNoSelect forState:UIControlStateNormal];
    [self.btnSelect setImage:imgSelect forState:UIControlStateSelected];
    self.btnSelect.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(MyActivity *)ac{
    mAc = ac;
    self.labTitle.text = ac.activityTitle;
    NSString *str1 = @"";
    if (ac.joinDate.length>16) {
        str1 = [ac.joinDate substringToIndex:iMinIndex];
    }else{
        str1 = ac.joinDate;
    }
    self.labSignUpTime.text = [NSString stringWithFormat:@"活动时间:%@",str1];
    str1 = @"";
    if (ac.activityBeginTime.length>16) {
        str1 = [ac.activityBeginTime substringToIndex:iMinIndex];
    }else{
        str1 = ac.activityBeginTime;
    }
    
    NSString *str2 = @"";
    if (ac.activityEndTime.length>16) {
        str2 = [ac.activityEndTime substringToIndex:iMinIndex];
    }else{
        str2 = ac.activityEndTime;
    }
    self.labAcLast.text = [NSString stringWithFormat:@"活动时间:%@ 至 %@",str1,str2];
    self.labStatus.text = ac.status;
    if(ac.status){
        if ([ac.status isEqualToString:AcStatusEnd]) {
            self.labStatus.textColor = listColorEnd;
        }else if ([ac.status isEqualToString:AcStatusIng]) {
            self.labStatus.textColor = listColorIng;
        }else if ([ac.status isEqualToString:AcStatusNoBegin]) {
            self.labStatus.textColor = listColorNoBegin;
        }
    }
    
}

-(void)setIsDeleting:(BOOL)b{
    int tx = iDelX;
    if (mAc.status && [mAc.status isEqualToString:AcStatusEnd]) {
        
        if (b) {
            self.btnSelect.hidden = NO;
            tx = iDelX;
        }else{
            self.btnSelect.hidden = YES;
            tx = iOriginX;
        }
    }else{
        self.btnSelect.hidden = YES;
        tx = iOriginX;
    }
    
    
    self.labTitle.frame = [Util getFrameWithX:self.labTitle.frame x:tx];
    self.labSignUpTime.frame = [Util getFrameWithX:self.labSignUpTime.frame x:tx];
    self.labAcLast.frame = [Util getFrameWithX:self.labAcLast.frame x:tx];
}


-(void)setItemSelect:(BOOL)b{
    if (b) {
        [self.btnSelect setImage:imgSelect forState:UIControlStateNormal];
    }else{
        [self.btnSelect setImage:imgNoSelect forState:UIControlStateNormal];
    }
}

@end
