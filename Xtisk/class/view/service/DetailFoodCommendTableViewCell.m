//
//  DetailFoodCommendTableViewCell.m
//  Xtisk
//
//  Created by 卢一 on 15/2/18.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "DetailFoodCommendTableViewCell.h"
#import "PublicDefine.h"
@implementation DetailFoodCommendTableViewCell

- (void)awakeFromNib {
    // Initialization code
    UILabel *labc = [[UILabel alloc]initWithFrame:self.labContent.frame];
    [self addSubview:labc];
    labc.lineBreakMode = NSLineBreakByWordWrapping;
    labc.numberOfLines = 0;
    labc.font = [UIFont systemFontOfSize:12];
    self.labContent.hidden = YES;
    self.labContent = labc;
    
    self.imgHeader.layer.cornerRadius = self.imgHeader.frame.size.width/2;
    self.imgHeader.layer.masksToBounds = YES;
}
-(void)setDataWith:(CommentsItem *)ci{
    item = ci;
    self.labContent.text = ci.content;
    self.labName.text = ci.userName;
    self.labTime.text = ci.commentsTime;
}

-(int)getCellHeight{
    if (!item.content) {
        return 110;
    }
    int startY = 52;
    CGSize size = [Util sizeForString:item.content fontSize:12 andWidth:274];
    int allHeight = startY + size.height;
    if (allHeight < 110) {
        return 110;
    }
    return size.height + startY;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
