//
//  MainViewController.h
//  TestTabBarController
//
//  Created by 兴天科技 on 13-4-2.
//  Copyright (c) 2013年 luyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarViewController : UITabBarController<UITabBarControllerDelegate>
{
    UIImageView *m_posImage;
    int         m_selectedIndex;
}

-(void)doubleClick:(UIViewController *)controller;
@end
