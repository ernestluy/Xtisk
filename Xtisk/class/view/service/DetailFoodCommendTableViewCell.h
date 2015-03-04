//
//  DetailFoodCommendTableViewCell.h
//  Xtisk
//
//  Created by 卢一 on 15/2/18.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicDefine.h"
/*
 {
 "content": "在点个赞",
 "userName": "323",
 "commentsTime": "2015-03-03 13:13:07",
 "commentsId": "398",
 "storeId": "166"
 }
 */
@interface DetailFoodCommendTableViewCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UILabel *labName;
@property(nonatomic,weak)IBOutlet UILabel *labContent;
@property(nonatomic,weak)IBOutlet UILabel *labTime;
-(void)setDataWith:(CommentsItem *)ci;

@end
