//
//  DetailFoodTableViewCell.h
//  Xtisk
//
//  Created by 卢一 on 15/2/18.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarCommendView.h"
@interface DetailFoodTableViewCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UILabel *labJg;
@property(nonatomic,weak)IBOutlet UIImageView *imgViewTj;
@property(nonatomic,weak)IBOutlet StarCommendView *viewStar;
@end