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

-(void)setLabHidden{
    self.lab0Num.hidden = YES;
    self.lab0Titel.hidden = YES;
    
    self.lab1Num.hidden = YES;
    self.lab1Titel.hidden = YES;
    
    self.lab2Num.hidden = YES;
    self.lab2Titel.hidden = YES;
    
    self.lab3Num.hidden = YES;
    self.lab3Titel.hidden = YES;
}

-(void)setData:(VoyageItem*)item{
    NSLog(@"setData");
    self.labSailTime.text = item.SETOFFTIME;
//    self.labPtwy.text = [NSString stringWithFormat:@"%d",item.ticketNum1];
//    self.labTdwy.text = [NSString stringWithFormat:@"%d",item.ticketNum2];
//    self.labHhwy.text = [NSString stringWithFormat:@"%d",item.ticketNum3];
    [self setLabHidden];
    
    for (int i = 0; i<item.DTSEATRANKPRICE.count; i++) {
        SeatRankPrice *seat = [item.DTSEATRANKPRICE objectAtIndex:i];
        UILabel *labTitle = nil;
        UILabel *labNum = nil;
        if (i == 0) {
            labTitle = self.lab0Titel;
            labNum = self.lab0Num;
        }else if (i == 1) {
            labTitle = self.lab1Titel;
            labNum = self.lab1Num;
        }else if (i == 2) {
            labTitle = self.lab2Titel;
            labNum = self.lab2Num;
        }else if (i == 3) {
            labTitle = self.lab3Titel;
            labNum = self.lab3Num;
        }
        labTitle.hidden = NO;
        labNum.hidden = NO;
        labTitle.text = [NSString stringWithFormat:@"%@余:",seat.SEATRANK];
        labNum.text = [item.mArrTicketNums objectAtIndex:i];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
