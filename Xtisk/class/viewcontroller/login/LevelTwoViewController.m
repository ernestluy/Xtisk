//
//  LevelTwoViewController.m
//  LoginDemo
//
//  Created by 兴天科技 on 14-3-4.
//  Copyright (c) 2014年 兴天科技. All rights reserved.
//

#import "LevelTwoViewController.h"

@interface LevelTwoViewController ()
{
    int index ;
}
@end

@implementation LevelTwoViewController

-(id)initWithIndex:(int)i{
    self = [super init];
    if (self) {
        index = i;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    
    
    UIButton *tBt = [UIButton buttonWithType:UIButtonTypeSystem];
    tBt.frame = CGRectMake(20, 300, 80, 20);
    [tBt setTitle:@"test" forState:UIControlStateNormal];
    tBt.backgroundColor = [UIColor yellowColor];
    [tBt addTarget:self action:@selector(addController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tBt];
}

-(void)addController{
    NSArray *tmpArray = self.navigationController.viewControllers;
    NSLog(@"count:%d",tmpArray.count);
    [self.navigationController pushViewController:[[LevelTwoViewController alloc]initWithIndex:61] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
