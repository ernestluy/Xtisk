//
//  FoodDetailHeader.h
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicDefine.h"
@interface FoodDetailHeader : UIView


@property(nonatomic,weak)IBOutlet UILabel *labGoodNum;
@property(nonatomic,weak)IBOutlet UILabel *labTitle;
@property(nonatomic,weak)IBOutlet UILabel *labPj;
@property(nonatomic,weak)IBOutlet UILabel *labQs;
@property(nonatomic,weak)IBOutlet UILabel *labContent;
@property(nonatomic,weak)IBOutlet UILabel *labYysj;
@property(nonatomic,weak)IBOutlet UIButton *btnCommend;
@property(nonatomic,weak)IBOutlet UIButton *btnGood;
@property(nonatomic,weak)IBOutlet UIImageView *imgHeader;


-(void)setUIInit;

-(void)setStoreDetailData:(StoreItem *)storeItem;
@end
