//
//  ActivityListTableViewCell.m
//  Xtisk
//
//  Created by 卢一 on 15/2/19.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "ActivityListTableViewCell.h"
#import "PublicDefine.h"
@implementation ActivityListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.imgHeader.backgroundColor = _rgb2uic(0xf6f6f6, 1);
    
//    self.imgBar.alpha = 0.3;
    
    self.labStatus.hidden = YES;
    self.labStatus.backgroundColor = _rgb2uic(0x777777, 1);
}

-(void)setData:(ActivityItem *)item{
    self.labTitle.text = item.activityTitle;
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *tmpStr = item.activityTime;
    if (tmpStr && tmpStr.length>10) {
        tmpStr = [tmpStr substringToIndex:10];
    }
    
    NSDate *date = [dateFormatter dateFromString:tmpStr];
    NSString *strDate = [dateFormatter stringFromDate:date];
    self.labTime.text = strDate;
    
    
    NSDate *nDate = nil;
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *strServerDate = [SettingService sharedInstance].strTime;
    nDate = [dateFormatter dateFromString:strServerDate];
    if(nDate == nil){
        nDate = [NSDate date];
    }
    NSDate *eDate = [dateFormatter dateFromString:item.activityEndTime];
    NSComparisonResult r = [nDate compare:eDate];
    if (NSOrderedDescending == r) {
        //当前时间比结束时间晚，说明已经结束
        
        self.labTime.hidden = YES;
        self.labStatus.hidden = NO;
    }else{
        //还没结束
        self.labTime.hidden = NO;
        self.labStatus.hidden = YES;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
