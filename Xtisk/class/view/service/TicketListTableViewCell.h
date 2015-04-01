//
//  TicketListTableViewCell.h
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoyageItem.h"
@interface TicketListTableViewCell : UITableViewCell
{
    
}
@property(nonatomic,weak)IBOutlet UILabel *labSailTime;

@property(nonatomic,weak)IBOutlet UILabel *lab0Titel;
@property(nonatomic,weak)IBOutlet UILabel *lab0Num;

@property(nonatomic,weak)IBOutlet UILabel *lab1Titel;
@property(nonatomic,weak)IBOutlet UILabel *lab1Num;

@property(nonatomic,weak)IBOutlet UILabel *lab2Titel;
@property(nonatomic,weak)IBOutlet UILabel *lab2Num;

@property(nonatomic,weak)IBOutlet UILabel *lab3Titel;
@property(nonatomic,weak)IBOutlet UILabel *lab3Num;


-(void)setData:(VoyageItem*)item;
@end
