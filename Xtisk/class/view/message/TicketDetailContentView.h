//
//  Xtisk
//
//  Created by 卢一 on 15/2/21.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketDetailContentView : UIView
@property(nonatomic,weak)IBOutlet UILabel *labCode;
@property(nonatomic,weak)IBOutlet UILabel *labStatus;


@property(nonatomic,weak)IBOutlet UILabel *labHbxx1;
@property(nonatomic,weak)IBOutlet UILabel *labKhsj1;
@property(nonatomic,weak)IBOutlet UILabel *labCclx1;
@property(nonatomic,weak)IBOutlet UILabel *labPs1;

@property(nonatomic,weak)IBOutlet UILabel *labHbxx2;
@property(nonatomic,weak)IBOutlet UILabel *labKhsj2;
@property(nonatomic,weak)IBOutlet UILabel *labCclx2;
@property(nonatomic,weak)IBOutlet UILabel *labPs2;

@property(nonatomic,weak)IBOutlet UILabel *labNme;
@property(nonatomic,weak)IBOutlet UILabel *labEmail;
@property(nonatomic,weak)IBOutlet UILabel *labTel;
@property(nonatomic,weak)IBOutlet UILabel *labIdCard;

@property(nonatomic,weak)IBOutlet UILabel *labTicket1;
@property(nonatomic,weak)IBOutlet UILabel *labTicket2;
@property(nonatomic,weak)IBOutlet UILabel *labMoney;
@end
