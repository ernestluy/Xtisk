//
//  TicketNumsEdit2TableViewCell.m
//  Xtisk
//
//  Created by zzt on 15/3/11.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "TicketNumsEdit2TableViewCell.h"

@implementation TicketNumsEdit2TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setDataArr:(NSArray *)arr{
    self.labSType.text = [arr objectAtIndex:0];
    self.labCType.text = [arr objectAtIndex:1];
    self.labNums.text = [arr objectAtIndex:2];
    self.labTotalPrice.text = [arr objectAtIndex:3];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
