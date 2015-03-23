//
//  NearFilterView.h
//  Xtisk
//
//  Created by zzt on 15/3/23.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NearFilterViewDelegate <NSObject>
- (void)filterDidSelected:(int)selectedIndex;
@end
@interface NearFilterView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,assign)id<NearFilterViewDelegate> delegate;
@end
