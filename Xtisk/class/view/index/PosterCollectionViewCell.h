//
//  PosterCollectionViewCell.h
//  Xtisk
//
//  Created by zzt on 15/2/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PosterCollectionViewCell : UICollectionViewCell


@property(nonatomic,weak)IBOutlet UIImageView *imageBg;
@property(nonatomic,weak)IBOutlet UIImageView *imgIcon;
@property(nonatomic,weak)IBOutlet UILabel *labelContent;
@property(nonatomic,weak)IBOutlet UIView *viewAlphe;

-(void)setData;
@end