//
//  MainViewController.m
//  TestTabBarController
//
//  Created by 兴天科技 on 13-4-2.
//  Copyright (c) 2013年 luyi. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "Util.h"
#import "PublicDefine.h"
#import "IndexTabViewController.h"
#import "MessageTabViewController.h"
#import "ServiceTabViewController.h"
#import "MoreTabViewController.h"
typedef enum {
    TAB_BAR_INDEX = 0,
    TAB_BAR_MSG,
    TAB_BAR_SERVICE,
    TAB_BAR_MORE,
}TabBarIndex;

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (id)init
{
    self = [super init];
    if (self) {
     
        m_selectedIndex=-1;

    }
    return self;
}
-(void)viewDidUnload{
    [super viewDidUnload];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad
{

    [super viewDidLoad];
    NSMutableArray *baritems = [NSMutableArray array];

    NSArray *xibArray = [NSArray arrayWithObjects:@"IndexTabViewController",@"MessageTabViewController",@"ServiceTabViewController",@"MoreTabViewController", nil];
    NSArray *tabBarItemBg = [NSArray arrayWithObjects:@"tab_bar_1.png",@"tab_bar_1.png",@"tab_bar_1.png",@"tab_bar_1.png", nil];
    NSArray *tabBarItemSelectedBg = [NSArray arrayWithObjects:@"tab_bar_1_selected.png",@"tab_bar_1_selected.png",@"tab_bar_1_selected.png",@"tab_bar_1_selected.png", nil];
    NSArray *btnName = [NSArray arrayWithObjects:@"首页",@"消息",@"服务",@"更多",nil];
    for (int i = 0; i<[xibArray count]; i++) {
        UIViewController *ctl =nil;
        if (i == TAB_BAR_INDEX) {
            ctl = [[IndexTabViewController alloc] initWithNibName:[xibArray objectAtIndex:i] bundle:nil];
        }else if(i == TAB_BAR_MSG){
            ctl = [[MessageTabViewController alloc] initWithNibName:[xibArray objectAtIndex:i] bundle:nil];
        }else if(i == TAB_BAR_SERVICE){
            
            ctl = [[ServiceTabViewController alloc] initWithNibName:[xibArray objectAtIndex:i] bundle:nil];
        }else if(i == TAB_BAR_MORE){
            ctl = [[MoreTabViewController alloc] initWithNibName:[xibArray objectAtIndex:i] bundle:nil];
        }
        
//        ctl.title = [tabBarItemBg objectAtIndex:i];
        UIImage *imageBg = [UIImage imageNamed:[tabBarItemBg objectAtIndex:i]];
//        UIImage *imageSelectedBg = [UIImage imageNamed:[tabBarItemSelectedBg objectAtIndex:i]];
//        UITabBarItem *item = [[UITabBarItem alloc] init] ;
//        item.tag = i;
//        item.title = [btnName objectAtIndex:i];
//        [item setFinishedSelectedImage:imageSelectedBg withFinishedUnselectedImage:imageBg];
//        UIColor *selectedColor = [UIColor colorWithRed:71.0/255.0 green:94.0/255.0 blue:136.0/255.0 alpha:1.0];
//        [item setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor redColor] } forState:UIControlStateNormal];
//        [item setTitleTextAttributes:@{ UITextAttributeTextColor : selectedColor } forState:UIControlStateHighlighted];
//        ctl.tabBarItem  = item;
        
        ctl.tabBarItem = [[UITabBarItem alloc] initWithTitle:[btnName objectAtIndex:i] image:imageBg tag:i];
        
        [baritems addObject:ctl];
        
    }
    

    
    
    self.delegate = self;
    self.viewControllers = baritems;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [self.tabBar setTintColor:headerColor];
    }else{
        [self.tabBar setTintColor:_rgb2uic(0xFFFFFF, 1)];
        [self.tabBar setSelectedImageTintColor:headerColor];
        self.tabBar.shadowImage = nil;
    }
}




-(void)doubleClick:(UIViewController *)controller{
    int index = (int)controller.tabBarItem.tag;
    //NSLog(@"didSelectViewController:%d",index);
    if (m_selectedIndex == index  && m_selectedIndex == TAB_BAR_INDEX) {
        
    }
    
    m_selectedIndex = index;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"didSelectViewController");
//    [self doubleClick:viewController];
}

#pragma mark -
#pragma mark UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0){
    NSLog(@"shouldSelectViewController");
    if((int)viewController.tabBarItem.tag == 1){
        return NO;
    }
    return YES;
}


#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


