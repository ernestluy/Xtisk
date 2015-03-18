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
    
    self.imgBar.alpha = 0.3;
    
    
}

-(void)setData:(ActivityItem *)item{
    self.labTitle.text = item.activityTitle;
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    NSString *tmpStr = item.activityTime;
    if (tmpStr && tmpStr.length>10) {
        tmpStr = [tmpStr substringToIndex:10];
    }
    
    NSDate *date = [dateFormatter dateFromString:tmpStr];
    NSString *strDate = [dateFormatter stringFromDate:date];
    self.labTime.text = strDate;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
