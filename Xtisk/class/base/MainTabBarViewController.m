//
//  MainViewController.m
//  TestTabBarController
//
//  Created by 兴天科技 on 13-4-2.
//  Copyright (c) 2013年 luyi. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "Util.h"
typedef enum {
    TAB_BAR_IMSHOW = 0,
    TAB_BAR_CROP,
    TAB_BAR_DIAL,
    TAB_BAR_CONF,
    TAB_BAR_TOOL,
}TabBarIndex;

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (id)init
{
    self = [super init];
    if (self) {
     
        //Custom initialization
        m_selectedIndex=-1;

    }
    return self;
}
-(void)viewDidUnload{
    [super viewDidUnload];
}
- (void)viewDidLoad
{
//#import "DialViewController.h"
//#import "CropViewController.h"
//#import "IMShowViewController.h"
//#import "IndexConfViewController.h"
//#import "ToolViewController.h"
    [super viewDidLoad];
    int btnWidth = 32;
    int btnHeight = 32;
    CGSize imageSize = CGSizeMake(btnWidth, btnHeight);
	// Do any additional setup after loading the view.
    NSMutableArray *baritems = [NSMutableArray array];

    NSArray *xibArray = [NSArray arrayWithObjects:@"IMShowViewController",@"CropViewController",@"DialViewController",@"IndexConfViewController",@"ToolViewController", nil];
    NSArray *tabBarItemBg = [NSArray arrayWithObjects:@"tab_bar_im_lately.png",@"tab_bar_contact.png",@"tab_bar_phone_extend_normal.png",@"tab_bar_phone_conf.png",@"tab_bar_box.png", nil];
    NSArray *tabBarItemSelectedBg = [NSArray arrayWithObjects:@"tab_bar_im_lately_click.png",@"tab_bar_contact_click.png",@"tab_bar_phone_extend_click.png",@"tab_bar_phone_conf_click.png",@"tab_bar_box_click.png", nil];
    NSArray *btnName = [NSArray arrayWithObjects:@"会话",@"通讯录",@"拨号",@"会议",@"工具箱", nil];
    for (int i = 0; i<[tabBarItemBg count]; i++) {
        UIViewController *ctl =nil;
        if (i == TAB_BAR_DIAL) {
            ctl = nil;
        }else if(i == TAB_BAR_CROP){
            ctl = nil;
        }else if(i == TAB_BAR_IMSHOW){
            
            ctl = nil;
        }else if(i == TAB_BAR_CONF){
            ctl = nil;
        }else if(i == TAB_BAR_TOOL){
            ctl = nil;
        }
        
        ctl.title = [tabBarItemBg objectAtIndex:i];
        UIImage *imageBg = [UIImage imageNamed:[tabBarItemBg objectAtIndex:i]];
        //imageBg = [imageBg imageByScalingToSize:imageSize];
        //imageBg.size = imageSize;
        UITabBarItem *item = [[UITabBarItem alloc] init] ;
        item.tag = i;
        item.title = [btnName objectAtIndex:i];
        UIImage *imageSelectedBg = [UIImage imageNamed:[tabBarItemSelectedBg objectAtIndex:i]];//[[UIImage imageNamed:[tabBarItemSelectedBg objectAtIndex:i]] imageByScalingToSize:imageSize];
        [item setFinishedSelectedImage:imageSelectedBg withFinishedUnselectedImage:imageBg];
        UIColor *selectedColor = [UIColor colorWithRed:71.0/255.0 green:94.0/255.0 blue:136.0/255.0 alpha:1.0];
        [item setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor whiteColor] } forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{ UITextAttributeTextColor : selectedColor } forState:UIControlStateHighlighted];
        ctl.tabBarItem  = item;
         
        [baritems addObject:ctl];
    }
    //self.tabBar.frame = CGRectMake(0, 460 - 49, 320, 49);
    //CGRect rect = self.tabBar.frame;
    //self.tabBar.frame = CGRectMake(0, rect.origin.y -10, rect.size.width, rect.size.height);
    UIImage *bbbimage = [[UIImage imageNamed:@"navigation_bar.png"] imageByScalingToSize:CGSizeMake(self.tabBar.frame.size.width, self.tabBar.frame.size.height)];

    self.tabBar.backgroundImage = bbbimage;
    self.delegate = self;
    self.viewControllers = baritems;
    
    
    m_posImage = [[UIImageView alloc] init] ;
    m_posImage.frame = CGRectMake(320/10 -20/2, 0, 20, 8);
    m_posImage.image = [UIImage imageNamed:@"tab_bar_pos.png"];
    
    
    //[self setSelectedIndex:0];
    [self.tabBar addSubview:m_posImage];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


-(void)doubleClick:(UIViewController *)controller{
    int index = (int)controller.tabBarItem.tag;
    //NSLog(@"didSelectViewController:%d",index);
    if (m_selectedIndex == index  && m_selectedIndex == TAB_BAR_DIAL) {
        
    }
    
    m_selectedIndex = index;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    int index = (int)viewController.tabBarItem.tag;
    //NSLog(@"didSelectViewController:%d",index);
    [self doubleClick:viewController];
//    [self setSelectedImagePositon:index+1];
}

#pragma mark -
#pragma mark UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0){
    //NSLog(@"shouldSelectViewController");
    return YES;
}


- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers NS_AVAILABLE_IOS(3_0){
    //NSLog(@"willBeginCustomizingViewControllers");
}
- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed NS_AVAILABLE_IOS(3_0){
    //NSLog(@"willEndCustomizingViewControllers");
}
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed{
    //NSLog(@"didEndCustomizingViewControllers");
}
#pragma mark -

-(void)setSelectedFirst{
//    [self setSelectedImagePositon:0];
}
-(void)setSelectedImagePositon:(int)pos{
    int btnwidth = 320/5;
    m_posImage.frame = CGRectMake( btnwidth*pos -btnwidth/2 -20/2, 0, 20, 8);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end


