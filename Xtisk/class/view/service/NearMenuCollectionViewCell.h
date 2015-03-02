//
//  NearMenuCollectionViewCell.h
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearMenuItem.h"
#import "PublicDefine.h"
@interface NearMenuCollectionViewCell : UICollectionViewCell

@property(nonatomic,weak)IBOutlet UILabel *title;
@property(nonatomic,weak)IBOutlet UILabel *content;
@property(nonatomic,weak)IBOutlet UIImageView *imageHeader;
@property(nonatomic,weak)IBOutlet UIImageView *imageBg;
@property(nonatomic,strong)MenuItem *mItem;


-(void)setMenuItem:(MenuItem *)tItem;
-(void)setItemData:(NearMenuItem *)sItem;

-(void)setFoodData:(NSString *)imgNme;
@end
