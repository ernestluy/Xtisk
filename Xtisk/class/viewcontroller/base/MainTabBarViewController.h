//
//  MainViewController.h
//  TestTabBarController
//
//  Created by 兴天科技 on 13-4-2.
//  Copyright (c) 2013年 luyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
@interface MainTabBarViewController : UITabBarController<UITabBarControllerDelegate,LoginViewControllerDelegate,AsyncHttpRequestDelegate>
{
    UIImageView *m_posImage;
    int         m_selectedIndex;
}

-(void)doubleClick:(UIViewController *)controller;

-(void)requestMsgData;
-(void)dealRemoteMsg;
-(void)dealTicketOrderMsg;
@end
