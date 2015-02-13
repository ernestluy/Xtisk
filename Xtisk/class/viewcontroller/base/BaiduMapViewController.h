//
//  BaiduMapViewController.h
//  Xtisk
//
//  Created by zzt on 15/2/12.
//  Copyright (c) 2015年 卢一. All rights reserved.
//

#import "SecondaryViewController.h"
#import "PublicDefine.h"
#import "BMapKit.h"
@interface BaiduMapViewController : SecondaryViewController<BMKMapViewDelegate, BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate>
{
    IBOutlet BMKMapView* _mapView;
    BMKGeoCodeSearch* _geocodesearch;
    BMKLocationService* _locService;
}

-(id)initWithLong:(float)longitude   lat:(float) latitude;
-(void)reverseGeoCode:(float)lat long:(float)lg;
@end
