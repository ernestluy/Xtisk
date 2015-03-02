//
//  FoodListTableViewCell.h
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicDefine.h"
@interface FoodListTableViewCell : UITableViewCell


@property(nonatomic,weak)IBOutlet UIImageView *imgHeader;
@property(nonatomic,weak)IBOutlet UIImageView *imgGood;
@property(nonatomic,weak)IBOutlet UILabel *labGood;
@property(nonatomic,weak)IBOutlet UILabel *labTitle;
@property(nonatomic,weak)IBOutlet UILabel *labPj;
@property(nonatomic,weak)IBOutlet UILabel *labQs;
@property(nonatomic,weak)IBOutlet UILabel *labAddress;

-(void)setStoreDataWithStoreItem:(StoreItem *)storeItem;
@end
