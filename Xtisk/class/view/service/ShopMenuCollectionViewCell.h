//
//  ShopMenuCollectionViewCell.h
//  Xtisk
//
//  Created by 卢一 on 15/2/19.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicDefine.h"
#import "StarCommendView.h"
@interface ShopMenuCollectionViewCell : UICollectionViewCell

@property(nonatomic,weak)IBOutlet UIImageView *imgShow;
@property(nonatomic,weak)IBOutlet UILabel *labTitle;
@property(nonatomic,weak)IBOutlet UILabel *labJg;
@property(nonatomic,weak)IBOutlet StarCommendView *viewStar;
@end
