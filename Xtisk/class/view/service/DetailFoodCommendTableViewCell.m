//
//  DetailFoodCommendTableViewCell.m
//  Xtisk
//
//  Created by 卢一 on 15/2/18.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "DetailFoodCommendTableViewCell.h"

@implementation DetailFoodCommendTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setDataWith:(CommentsItem *)ci{
    self.labContent.text = ci.content;
    self.labName.text = ci.userName;
    self.labTime.text = ci.commentsTime;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
