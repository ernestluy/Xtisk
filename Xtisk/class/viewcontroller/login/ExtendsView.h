//
//  ExtendsView.h
//  LoginDemo
//
//  Created by 兴天科技 on 14-3-3.
//  Copyright (c) 2014年 兴天科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExtendsViewDelegate <NSObject>
-(void)closeExtendsView;
@end

@interface ExtendsView : UIView
{
    __weak id<ExtendsViewDelegate>  extendsDelegate;
}

@property(weak,nonatomic)id<ExtendsViewDelegate>  extendsDelegate;
@end
