//
//  AppDelegate.m
//  Xtisk
//
//  Created by 卢一 on 15-1-31.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "CustomNavigationController.h"
#import "MainTabBarViewController.h"
#import "XTFileManager.h"
#import "DBManager.h"
#import "PosterItem.h"
#import "PublicDefine.h"

#import "SettingService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    CustomNavigationController *nav = [[CustomNavigationController alloc]init];
//    nav.interactivePopGestureRecognizer.enabled = NO;
//    [nav pushViewController:[[LoginViewController alloc]init] animated:NO];
//    self.window.rootViewController = nav;
    
    
    MainTabBarViewController *mTabBar = [[MainTabBarViewController alloc]init];
    CustomNavigationController *nav = [[CustomNavigationController alloc]initWithRootViewController:mTabBar];
    nav.interactivePopGestureRecognizer.enabled = NO;
    self.window.rootViewController = nav;
    
    
    [self.window makeKeyAndVisible];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [XTFileManager shareInstance];
    [DBManager initDB];
    
    [PosterItem getPosterData];
    
//    NSData *dd = [Util strToData:@"12345"];
//    NSLog(@"%d",dd.length);
//    NSDictionary *dic = @{@"luyi":@"He is a good man.",@"age":[NSNumber numberWithInt:29]};
//    NSString *jsonStr= [Util getJsonStrWithObj:dic];
//    NSLog(@"%@",jsonStr);
    /*
     
     <NSHTTPCookie version:0 name:"JSESSIONID" value:"EE5AB6135EFCA21C3B2D16516CA943C5" expiresDate:(null) created:2015-02-28 09:32:38 +0000 (4.46809e+08) sessionOnly:TRUE domain:"116.7.243.122" path:"/ipop_tms/" isSecure:FALSE>

     */
//    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
//        NSLog(@"%@", cookie);
//    }
    
    [[SettingService sharedInstance] PermissionBaiduMap];
    //设置友盟Appkey
    [UMSocialData setAppKey:UmengAppkey];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    
    //设置手机QQ的AppId，指定你的分享url，若传nil，将使用友盟的网址
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    
    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    
    [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeImage; //设置QQ分享纯图片，默认分享图文消息
    [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeImage;  //设置微信好友分享纯图片
    [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeImage;  //设置微信朋友圈分享纯图片
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}
@end
