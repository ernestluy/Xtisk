//
//  CustomNavigationController.m
//  Xtisk
//
//  Created by zzt on 15/2/3.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "CustomNavigationController.h"
#import "PublicDefine.h"
@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationBar setTintColor:_rgb2uic(0xF9F9F9, 1)];
    self.navigationBar.barTintColor = headerColor;
    
    self.navigationBar.translucent = NO;
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor], UITextAttributeTextColor,
                                    nil]];
    

}
-(void)onBack:(id)sender{
    [self popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
