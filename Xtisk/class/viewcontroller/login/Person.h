//
//  Person.h
//  LoginDemo
//
//  Created by 兴天科技 on 14-3-3.
//  Copyright (c) 2014年 兴天科技. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    NSString *name;
    NSString *add;
    int age;
}
@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *add;
@property(nonatomic)int age;
@end
