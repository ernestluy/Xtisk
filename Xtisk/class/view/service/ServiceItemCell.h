//
//  ServiceItemCell.h
//  Xtisk
//
//  Created by 卢一 on 15/2/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceItem.h"
@interface ServiceItemCell : UICollectionViewCell


@property(nonatomic,weak)IBOutlet UILabel *title;
@property(nonatomic,weak)IBOutlet UIImageView *imageBg;

-(void)setItemData:(ServiceItem *)sItem;
@end
