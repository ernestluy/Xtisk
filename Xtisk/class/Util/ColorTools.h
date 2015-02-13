//
//  ColorTools.h
//  Stock_Pro
//
//  Created by imuse on 10-11-20.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define getColorRGB(a,b) a>b?[UIColor colorWithRed:0.910 green:0.220 blue:0.275 alpha:1]:a==b?[UIColor blackColor]:[UIColor colorWithRed:0.090 green:0.780 blue:0.725 alpha:1]
#define getColorRGW24(a,b) a>b?0xE83846:a==b?0x1CBBFD:0x17C7b9
#define getColorRGWE(a, b) a>b?[UIColor colorWithRed:0.910 green:0.220 blue:0.275 alpha:1]:a==b?[UIColor colorWithWhite:0.5 alpha:1]:[UIColor colorWithRed:0.090 green:0.780 blue:0.725 alpha:1]
#define getColorRGW(a,b) a==0?[UIColor colorWithWhite:0.5 alpha:1]:getColorRGWE(a,b)
//#define getColorRGW(a,b) a==0?[UIColor whiteColor]:getColorRGW(a,b)//a>b?@"STYLER":a==b?@"STYLEW":@"STYLEG"

#define getColorGrayRGWE(a, b) a>b?[UIColor colorWithRed:0.910 green:0.220 blue:0.275 alpha:1]:a==b?[UIColor colorWithWhite:0.5 alpha:1]:[UIColor colorWithRed:0.090 green:0.780 blue:0.725 alpha:1]
#define getColorGrayRGW(a,b) a==0?[UIColor colorWithWhite:0.5 alpha:1]:getColorRGWE(a,b)

#define getColorBS(a) a=='B'?0xFF0000:a=='S'?0x00AA00:0xFFFFFF


#define _rgb2uic(i,a) [UIColor colorWithRed:(i>>16&0xFF)/255.0 green:(i>>8&0xFF)/255.0 blue:(i&0xFF)/255.0 alpha:a]
#define getColorRGB_DG(a,b) a>b?[UIColor colorWithRed:0.910 green:0.220 blue:0.275 alpha:1]:a==b?[UIColor blackColor]:[UIColor colorWithRed:0.090 green:0.780 blue:0.725 alpha:1]

#define headerColor [UIColor colorWithRed:0.110 green:0.749 blue:0.992 alpha:1]
//0095f1

#define defaultTouchedColor [UIColor colorWithRed:0.980 green:0.659 blue:0.902 alpha:1]

#define riseColor [UIColor colorWithRed:0.910 green:0.220 blue:0.275 alpha:1]
#define riseTouchedColor [UIColor colorWithRed:0.820 green:0.200 blue:0.243 alpha:1]

#define fallColor [UIColor colorWithRed:0.090 green:0.780 blue:0.725 alpha:1]
#define fallTouchedColor [UIColor colorWithRed:0.082 green:0.702 blue:0.654 alpha:1]

#define bgColor [UIColor colorWithRed:0.976 green:0.976 blue:0.976 alpha:1]



@interface ColorTools : NSObject {

}


@end
