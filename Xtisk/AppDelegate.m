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
#import "CustomMenuTutorialController.h"
#import "MsgPlaySound.h"
#import "UMessage.h"

#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define _IPHONE80_ 80000

#define isNeedDelDB NO

@interface AppDelegate ()
{
    BOOL isBackToFore;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    CustomNavigationController *nav = [[CustomNavigationController alloc]init];
//    nav.interactivePopGestureRecognizer.enabled = NO;
//    [nav pushViewController:[[LoginViewController alloc]init] animated:NO];
//    self.window.rootViewController = nav;
    isBackToFore = NO;
    
    
    CustomNavigationController *nav = [[CustomNavigationController alloc]init];
    nav.interactivePopGestureRecognizer.enabled = NO;
    self.window.rootViewController = nav;
    NSObject *obj = [[NSUserDefaults standardUserDefaults] objectForKey:GuideMark];
    if (obj) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        MainTabBarViewController *mTabBar = [[MainTabBarViewController alloc]init];
        [nav pushViewController:mTabBar animated:NO];
    }else{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        CustomMenuTutorialController *cc = [[CustomMenuTutorialController alloc]init];
        [nav pushViewController:cc animated:NO];
    }
    
    
    [self.window makeKeyAndVisible];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [XTFileManager shareInstance];
    if (isNeedDelDB) {
        [XTFileManager deleteFileAtPath:kDATABASE_REAL_PATH];
    }
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
    
    
    //set umeng AppKey and LaunchOptions
    [UMessage startWithAppkey:@"54f3fcc9fd98c559e30005f7" launchOptions:launchOptions];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //register remoteNotification types
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    
    //for log
//    [UMessage setLogEnabled:YES];
    
    NSString *tToken = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken];
    if (tToken) {
        [SettingService sharedInstance].deviceToken = tToken;
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    
    
    
    
    return YES;
}

/* 友盟推送消息 web端的一些配置数据
 AppKey：54f3fcc9fd98c559e30005f7
 
 App Master Secret：rr0ckf9tnqkuh8jqhxmlt4xfcdgdbwxl
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [UMessage registerDeviceToken:deviceToken];
    [SettingService sharedInstance].deviceToken = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                                    stringByReplacingOccurrencesOfString: @">" withString: @""]
                                                   stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSLog(@"%@",[SettingService sharedInstance].deviceToken);
    if ([SettingService sharedInstance].deviceToken) {
        [[NSUserDefaults standardUserDefaults] setObject:[SettingService sharedInstance].deviceToken forKey:kDeviceToken];
    }
    
    
}

/*
 - register param [{
 "device_token" = 5eded537d7bbf7d29b512ba153d4c9f91be32204e2ead470875a9d5430f4a205;
 header =     {
 access = WiFi;
 "app_version" = 1;
 appkey = 54f3fcc9fd98c559e30005f7;
 carrier = "\U4e2d\U56fd\U79fb\U52a8";
 channel = "App Store";
 country = CN;
 "device_model" = "iPhone6,2";
 "display_name" = ishekou;
 idfv = "0F6C72CA-85C1-407F-AA0C-0C181A5729AD";
 "is_jailbroken" = NO;
 "is_pirated" = YES;
 language = "zh-Hans";
 oid = 6a0f79bc1287ad2754d39912f58611717684fdf9;
 os = iOS;
 "os_version" = "8.1.1";
 "package_name" = "com.citen.ishekou";
 "req_time" = "1425546076.652506";
 resolution = "1136 x 640";
 "sdk_type" = iOS;
 "sdk_version" = "1.1.0(185dccd)";
 "short_version" = "1.0.1";
 timezone = 8;
 };
 }]
 */

/*
 {
 aps =     {
 alert =         {
 "action-loc-key" = "launch apns";//自定义数据
 "loc-key" = "show text";//推送弹出框的显示内容
 };
 badge = 3;
 sound = default;
 };
 custom1 = value1;
 }
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
 
    [UMessage didReceiveRemoteNotification:userInfo];
    if (userInfo) {
        NSString *msgType = [userInfo objectForKey:@"msgType"];
        NSString *productId = [userInfo objectForKey:@"productId"];
        NSLog(@"didReceiveRemote msgType:%@,productId:%@",msgType,productId);
    }
//        self.userInfo = userInfo;
//    NSLog(@"userInfo:%@",[userInfo description]);
    /*
     userInfo:{
     aps =     {
     alert = 9999444;
     badge = 0;
     sound = chime;
     };
     d = us80596142596481520601;
     msgId = 1513;
     msgType = 1;
     p = 0;
     text = 9999444;
     }
     */
        //定制自定的的弹出框
//        if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
//        {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
//                                                                message:@"Test On ApplicationStateActive"
//                                                               delegate:self
//                                                      cancelButtonTitle:@"确定"
//                                                      otherButtonTitles:nil];
//    
//            [alertView show];
//            
//        }
    if (!isBackToFore){
        [[NSNotificationCenter defaultCenter] postNotificationName:kPushMessageReceiveRemote object:nil];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"\n ===> 程序暂行 !");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"\n ===> 程序进入后台 !");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"\n ===> 程序进入前台 !");
    isBackToFore = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:kPushMessageReceiveRemote object:nil];
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"\n ===> applicationDidBecomeActive !");
    isBackToFore = NO;
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
