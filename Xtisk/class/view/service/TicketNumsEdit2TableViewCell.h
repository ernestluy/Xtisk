//
//  TicketNumsEdit2TableViewCell.h
//  Xtisk
//
//  Created by zzt on 15/3/11.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketNumsEdit2TableViewCell : UITableViewCell


@property(nonatomic,weak)IBOutlet UILabel *labSType;
@property(nonatomic,weak)IBOutlet UILabel *labCType;
@property(nonatomic,weak)IBOutlet UILabel *labNums;
@property(nonatomic,weak)IBOutlet UILabel *labTotalPrice;

-(void)setDataArr:(NSArray *)arr;
@end
