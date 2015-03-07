//
//  VoyageRequestPar.m
//  Xtisk
//
//  Created by zzt on 15/3/5.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "VoyageRequestPar.h"

@implementation VoyageRequestPar
-(id)init{
    
    self = [super init];
    self.currencyCode = @"RMB";
    self.isRoundtrip = @"0";
    self.lang = @"C";
    return self;
}
@end
