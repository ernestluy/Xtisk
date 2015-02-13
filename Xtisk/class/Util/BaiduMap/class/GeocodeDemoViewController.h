//
//  GeocodeDemoViewController.h
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface GeocodeDemoViewController : UIViewController<BMKMapViewDelegate, BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate> {
	IBOutlet BMKMapView* _mapView;
	IBOutlet UITextField* _coordinateXText;
	IBOutlet UITextField* _coordinateYText;
	IBOutlet UITextField* _cityText;
	IBOutlet UITextField* _addrText;
	BMKGeoCodeSearch* _geocodesearch;
    BMKLocationService* _locService;
}
-(IBAction)onClickGeocode;
-(IBAction)onClickReverseGeocode;
- (IBAction)textFiledReturnEditing:(id)sender;
@end
