//
//  TicketNumsEdit1TableViewCell.h
//  Xtisk
//
//  Created by zzt on 15/3/10.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketNumsEdit1TableViewCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UILabel *labTicketType;
@property(nonatomic,weak)IBOutlet UILabel *labTicketPrice;
@property(nonatomic,weak)IBOutlet UILabel *labTicketNum;

@property(nonatomic,weak)IBOutlet UIButton *btnDel;
@property(nonatomic,weak)IBOutlet UIButton *btnAdd;
@end
