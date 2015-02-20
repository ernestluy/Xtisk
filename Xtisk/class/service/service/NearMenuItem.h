//
//  NearMenuItem.h
//  Xtisk
//
//  Created by 卢一 on 15/2/17.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NearMenuItem : NSObject


@property(nonatomic,copy)NSString *tTitle;
@property(nonatomic,copy)NSString *tContent;
@property(nonatomic,copy)NSString *imgNme;
@property(nonatomic)BOOL isValide;
@property(nonatomic,copy)UIColor *tintColor;

@end
