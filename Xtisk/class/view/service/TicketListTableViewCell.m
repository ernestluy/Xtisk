//
//  TicketListTableViewCell.m
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "TicketListTableViewCell.h"
#import "PublicDefine.h"
@implementation TicketListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    for (UIView *v in self.contentView.subviews) {
        if ([v isKindOfClass:[UILabel class]]) {
            UILabel *lab = (UILabel *)v;
            if (lab.tag == 0) {
                lab.textColor = defaultTextColor;
            }else if (1 == lab.tag){
                lab.textColor = defaultTextGrayColor;
            }else if (2 == lab.tag){
                lab.textColor = headerColor;
            }else if (3 == lab.tag){
                lab.textColor = _rgb2uic(0xed4d1c , 1);
            }
            
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
