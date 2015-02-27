//
//  GridMainView.m
//  Xtisk
//
//  Created by 卢一 on 15-2-4.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "GridMainView.h"
#import "PosterCollectionViewCell.h"
#import "PublicDefine.h"
/*
 具体用法：查看MJRefresh.h
 */
NSString *const ttCollectionViewCellIdentifier = @"Cell";


/**
 *  随机颜色
 */


@interface GridMainView(){
    int cInset ;
    UIView *cHeader;
    NSArray *tDataArr;
}

@end
@implementation GridMainView
@synthesize tCollectionView,btn,tIndexPath;

/**
 *  初始化
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    cInset = 10;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //    layout.itemSize = CGSizeMake(80, 80);
    //    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    //    layout.minimumInteritemSpacing = 20;
    //    layout.minimumLineSpacing = 20;
    //
    //    layout.headerReferenceSize = CGSizeMake(320, 30);
    //    layout.footerReferenceSize = CGSizeMake(320, 50);
    CGRect rt = self.bounds;
    tDataArr = @[];
    self.tCollectionView = [[LYCollectionView alloc] initWithFrame:rt collectionViewLayout:layout];
    
//    self.tCollectionView.bounces = NO;
    [self addSubview:self.tCollectionView];
    self.tCollectionView.delegate = self;
    self.tCollectionView.dataSource = self;
    self.tCollectionView.lyDelegate = self;
    //    self.collectionView.collectionViewLayout = layout;
    
    
    [self.tCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.tCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    // 1.初始化collectionView
    [self setupCollectionView];
    self.backgroundColor = [UIColor clearColor];
    self.tCollectionView.backgroundColor = [UIColor clearColor];
    
    
    // 2.集成刷新控件
    [self addHeader];
    [self addFooter];
    return self;
}

- (void)addHeader
{
//    UIView *outHeaderView  = [[UIView alloc]initWithFrame:CGRectMake(0, -50, self.frame.size.width, 50)];
//    outHeaderView.backgroundColor = [UIColor lightGrayColor];
//    [self.collectionView addSubview:outHeaderView];
}

- (void)addFooter
{
    
}
-(void)setDataArr:(NSArray*)arr{
    if (!arr) {
        return;
    }
    tDataArr = arr;
    
    
    
    [tCollectionView reloadData];
}
-(void)initFlushCtl{
    NSLog(@"initFlushCtl");
}
-(void)setHeaderView:(UIView *)headerView{
    cHeader = headerView;
    [self.tCollectionView reloadData];
}
/**
 *  初始化collectionView
 */
- (void)setupCollectionView
{
    self.tCollectionView.backgroundColor = [UIColor whiteColor];
    self.tCollectionView.alwaysBounceVertical = YES;
//    [self.tCollectionView registerClass:[PosterCollectionViewCell class] forCellWithReuseIdentifier:ttCollectionViewCellIdentifier];
    [self.tCollectionView registerNib:[UINib nibWithNibName:@"PosterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ttCollectionViewCellIdentifier];
}
-(void)deleteItem{
    NSLog(@"delete");
    
//    [self.tCollectionView deleteItemsAtIndexPaths:@[tIndexPath]];
    
    
    
    //    [self.collectionView performBatchUpdates:^{
    //        [self.fakeColors removeObjectAtIndex:tIndexPath.row];
    //        [self.collectionView deleteItemsAtIndexPaths:@[tIndexPath]];
    //    } completion:nil];
}

-(IBAction)btnAction:(id)sender{
    NSLog(@"asddf");
}
#pragma mark - LYFlushViewDelegate
- (void)startToFlushUp:(NSObject *)ly{
    NSLog(@"startToFlushUp");
}
- (void)startToFlushDown:(NSObject *)ly{
    NSLog(@"startToFlushUp");
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.tCollectionView setIsDraging:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    [self.tCollectionView judgeDragIng];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"drag end");
    [self.tCollectionView judgeDragEnd];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}
#pragma mark - collection数据源代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return tDataArr.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ttCollectionViewCellIdentifier forIndexPath:indexPath];
//    NSLog(@"row:%d",indexPath.row);
//    if (indexPath.row%3 == 0) {
//        PosterCollectionViewCell *pcc =  (PosterCollectionViewCell*)cell;
//        pcc.imageBg.image = nil;
//    }
    PosterCollectionViewCell *pcc =  (PosterCollectionViewCell*)cell;
    
    
    RecommendItem *ri = [tDataArr objectAtIndex:indexPath.row];
    UIImage *tImg = [XTFileManager getTmpFolderFileWithUrlPath:ri.recomPic];
    if (!tImg) {
        AsyncImgDownLoadRequest *request = [[AsyncImgDownLoadRequest alloc]initWithServiceAPI:ri.recomPic
                                                                                       target:self
                                                                                         type:HttpRequestType_Img_LoadDown];
        request.tTag = (int)indexPath.row;
        request.indexPath = indexPath;
        [request setRequestMethod:@"GET"];
        [request startAsynchronous];
    }else{
        pcc.imageBg.contentMode = DefaultImageViewContentMode;
        pcc.imageBg.image = tImg;
    }
    
    
    return cell;
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    tIndexPath = indexPath;
    if (self.delegate && [self.delegate respondsToSelector:@selector(gridMainView:)]) {
        [self.delegate gridMainView:self];
    }

}

//collectionView:layout:referenceSizeForHeaderInSection:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView * v = nil;
    if([kind isEqual:UICollectionElementKindSectionHeader]){
        v = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        for (UIView *view in v.subviews) {
            [view removeFromSuperview];
        }
        if (cHeader) {
            [v addSubview:cHeader];
        }
        
    }else{
        v = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        v.backgroundColor = [UIColor blackColor];
    }
    
    
    return v;
}
#pragma  mark -  UICollectionViewLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row%5 == 0) {
//        return CGSizeMake(160, 100);
//    }
    return CGSizeMake(145, 100);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(cInset, cInset, cInset, cInset);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return cInset;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return cInset;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (cHeader) {
        return cHeader.frame.size;
    }
    return CGSizeMake(320, 30);
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeMake(320, 50);
//}

#pragma mark -  AsyncHttpRequestDelegate
- (void) requestDidFinish:(AsyncHttpRequest *) request code:(HttpResponseType )responseCode{
    switch (request.m_requestType) {
        case HttpRequestType_Img_LoadDown:{
            if (HttpResponseTypeFinished ==  responseCode) {
                AsyncImgDownLoadRequest *ir = (AsyncImgDownLoadRequest *)request;
                NSData *data = [request getResponseData];
                if (!data || data.length <2000) {
                    NSLog(@"请求图片失败");
                    [request requestAgain];
                    return;
                }
                NSLog(@"img.len:%d",(int)data.length);
                UIImage *rImage = [UIImage imageWithData:data];
                RecommendItem *ri = [tDataArr objectAtIndex:ir.tTag];
                [XTFileManager saveTmpFolderFileWithUrlPath:ri.recomPic with:rImage];
                PosterCollectionViewCell * pc = (PosterCollectionViewCell * )[tCollectionView cellForItemAtIndexPath:ir.indexPath];
                if (pc) {
                    UIImageView *iv = pc.imageBg;
                    iv.contentMode = DefaultImageViewContentMode;
                    iv.image = rImage;
                }
                

            }else{
                [request requestAgain];
                NSLog(@"请求图片失败");
            }
            break;
        }
        default:{
            break;
        }
    }
}
@end
