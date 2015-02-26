//
//  AsyncImgDownLoadRequest.h
//  Xtisk
//
//  Created by 卢一 on 15/2/7.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "AsyncHttpRequest.h"

@interface AsyncImgDownLoadRequest : AsyncHttpRequest


@property (nonatomic,strong) NSIndexPath  *indexPath;
@property (nonatomic,strong) UIImageView  *tImageView;
@property (nonatomic) int  tTag;
@end
