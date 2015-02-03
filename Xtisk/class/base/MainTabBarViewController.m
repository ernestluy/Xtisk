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

    [super viewDidLoad];
    int btnWidth = 32;
    int btnHeight = 32;
//    CGSize imageSize = CGSizeMake(btnWidth, btnHeight);
	// Do any additional setup after loading the view.
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
        [item setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor redColor] } forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{ UITextAttributeTextColor : selectedColor } forState:UIControlStateHighlighted];
        ctl.tabBarItem  = item;
         
        [baritems addObject:ctl];
    }
    
//    self.tabBar.backgroundImage = bbbimage;
    self.delegate = self;
    self.viewControllers = baritems;
    
    

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


-(void)doubleClick:(UIViewController *)controller{
    int index = (int)controller.tabBarItem.tag;
    //NSLog(@"didSelectViewController:%d",index);
    if (m_selectedIndex == index  && m_selectedIndex == TAB_BAR_INDEX) {
        
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


