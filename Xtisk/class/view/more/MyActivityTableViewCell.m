//
//  MyActivityTableViewCell.m
//  Xtisk
//
//  Created by 卢一 on 15/2/20.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "MyActivityTableViewCell.h"

@implementation MyActivityTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setData:(MyActivity *)ac{
    self.labTitle.text = ac.activityTitle;
    self.labSignUpTime.text = [NSString stringWithFormat:@"活动时间:%@",ac.joinDate];
    self.labAcLast.text = [NSString stringWithFormat:@"活动时间:%@ 至 %@",ac.activityBeginTime,ac.activityEndTime];
    self.labStatus.text = ac.status;
}
@end
