//
//  NSDate+utils.h
//  Unicom_BOX
//
//  Created by Jack Zhao on 13-3-20.
//  Copyright (c) 2013年 duanye. All rights reserved.
//

#import <Foundation/Foundation.h>

//NSObject+logProperties.m
#import <objc/runtime.h>

@interface NSDate (utils)

+(NSDate *)dateFromString:(NSString *)dateStr withFormatedString:(NSString *)formatedStr;
-(NSString *)dateStringWithFormatedString:(NSString *)formatedStr;

+(NSDate *)dateGmtZone;
-(NSDate *)gmtZoneDate;
- (NSDate *) dateByAddingMinutes: (NSUInteger) dMinutes;
- (BOOL) isToday;
- (BOOL) isYesterday;
- (BOOL) isMoreBefore;
- (NSDate *) dateBySubtractingHours: (NSUInteger) dHours;
+ (NSDate *) dateWithDaysBeforeNow: (NSUInteger) days;
+ (NSDate *) dateYesterday;
- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
@end

@interface NSString (utils)
+(NSString*)GUIDString ;
- (NSString *)stringByDecodingXMLEntities;
@end




//NSObject+logProperties.h
@interface NSObject (logProperties)
- (void) logProperties;
@end


