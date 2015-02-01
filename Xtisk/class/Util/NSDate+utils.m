//
//  NSDate+utils.m
//  Unicom_BOX
//
//  Created by Jack Zhao on 13-3-20.
//  Copyright (c) 2013年 duanye. All rights reserved.
//

#import "NSDate+utils.h"

#define DEFAULT_DATE_FORMAT @"yyyy-MM-dd HH:mm:ss"
#define D_DAY		86400
#define CURRENT_CALENDAR  [[[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar] autorelease]
#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)


@implementation NSDate (utils)

static NSDateFormatter* formatter = nil;

+ (NSDateFormatter*)stringDateFormatter
{
    if (formatter == nil)
    {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:DEFAULT_DATE_FORMAT];
    }
    return formatter;
}

+(NSDate *)dateFromString:(NSString *)dateStr withFormatedString:(NSString *)formatedStr{
    @synchronized([NSDate stringDateFormatter]){
        if(formatedStr)  [[NSDate stringDateFormatter] setDateFormat:formatedStr];
        return [[NSDate stringDateFormatter] dateFromString:dateStr];
    };
}
-(NSString *)dateStringWithFormatedString:(NSString *)formatedStr{
    @synchronized([NSDate stringDateFormatter]){
        if(formatedStr)  [[NSDate stringDateFormatter] setDateFormat:formatedStr];
        return [[NSDate stringDateFormatter] stringFromDate:self];
    };
}

+(NSDate *)dateGmtZone{
    NSDate* sourceDate = [NSDate date];
    
    return  [sourceDate gmtZoneDate];
}
- (NSDate *) dateByAddingMinutes: (NSUInteger) dMinutes
{
#define D_MINUTE	60
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}


#define D_HOUR		3600
- (NSDate *) dateByAddingHours: (NSUInteger) dHours
{
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

- (NSDate *) dateBySubtractingHours: (NSUInteger) dHours
{
	return [self dateByAddingHours: (dHours * -1)];
}
-(NSDate *)gmtZoneDate{
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:self];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:self];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate* destinationDate = [[[NSDate alloc] initWithTimeInterval:interval sinceDate:self] autorelease];
    return  destinationDate;
}
+ (NSDate *) dateWithDaysBeforeNow: (NSUInteger) days
{
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_DAY * days;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}
+ (NSDate *) dateYesterday
{
	return [NSDate dateWithDaysBeforeNow:1];
}
- (BOOL) isToday
{
	return [self isEqualToDateIgnoringTime:[NSDate date]];
}
- (BOOL) isYesterday
{
	return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}
- (BOOL) isEarlierThanDate: (NSDate *) aDate{
    return ([self earlierDate:aDate] == self);
}
- (BOOL) isMoreBefore
{
	return [self isEarlierThanDate:[NSDate dateWithDaysBeforeNow:2]];
}
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
	NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
	return (([components1 year] == [components2 year]) &&
			([components1 month] == [components2 month]) &&
			([components1 day] == [components2 day]));
}

@end


@implementation NSString (utils)
+(NSString*)GUIDString {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    
    return [[(NSString *)string autorelease] stringByReplacingOccurrencesOfString:@"-" withString:@"" ] ;
}
- (NSString *)stringByDecodingXMLEntities {
    NSUInteger myLength = [self length];
    NSUInteger ampIndex = [self rangeOfString:@"&" options:NSLiteralSearch].location;
    
    // Short-circuit if there are no ampersands.
    if (ampIndex == NSNotFound) {
        return self;
    }
    // Make result string with some extra capacity.
    NSMutableString *result = [NSMutableString stringWithCapacity:(myLength * 1.25)];
    
    // First iteration doesn't need to scan to & since we did that already, but for code simplicity's sake we'll do it again with the scanner.
    NSScanner *scanner = [NSScanner scannerWithString:self];
    
    [scanner setCharactersToBeSkipped:nil];
    
    NSCharacterSet *boundaryCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@" \t\n\r;"];
    
    do {
        // Scan up to the next entity or the end of the string.
        NSString *nonEntityString;
        if ([scanner scanUpToString:@"&" intoString:&nonEntityString]) {
            [result appendString:nonEntityString];
        }
        if ([scanner isAtEnd]) {
            goto finish;
        }
        // Scan either a HTML or numeric character entity reference.
        if ([scanner scanString:@"&amp;" intoString:NULL])
            [result appendString:@"&"];
        else if ([scanner scanString:@"&apos;" intoString:NULL])
            [result appendString:@"'"];
        else if ([scanner scanString:@"&quot;" intoString:NULL])
            [result appendString:@"\""];
        else if ([scanner scanString:@"&lt;" intoString:NULL])
            [result appendString:@"<"];
        else if ([scanner scanString:@"&gt;" intoString:NULL])
            [result appendString:@">"];
        else if ([scanner scanString:@"&#" intoString:NULL]) {
            BOOL gotNumber;
            unsigned charCode;
            NSString *xForHex = @"";
            
            // Is it hex or decimal?
            if ([scanner scanString:@"x" intoString:&xForHex]) {
                gotNumber = [scanner scanHexInt:&charCode];
            }
            else {
                gotNumber = [scanner scanInt:(int*)&charCode];
            }
            
            if (gotNumber) {
                [result appendFormat:@"%C", (unichar)charCode];
                
                [scanner scanString:@";" intoString:NULL];
            }
            else {
                NSString *unknownEntity = @"";
                
                [scanner scanUpToCharactersFromSet:boundaryCharacterSet intoString:&unknownEntity];
                
                
                [result appendFormat:@"&#%@%@", xForHex, unknownEntity];
                
                //[scanner scanUpToString:@";" intoString:&unknownEntity];
                //[result appendFormat:@"&#%@%@;", xForHex, unknownEntity];
                NSLog(@"Expected numeric character entity but got &#%@%@;", xForHex, unknownEntity);
                
            }
            
        }
        else {
            NSString *amp;
            
            [scanner scanString:@"&" intoString:&amp];  //an isolated & symbol
            [result appendString:amp];
            
            /*
             NSString *unknownEntity = @"";
             [scanner scanUpToString:@";" intoString:&unknownEntity];
             NSString *semicolon = @"";
             [scanner scanString:@";" intoString:&semicolon];
             [result appendFormat:@"%@%@", unknownEntity, semicolon];
             NSLog(@"Unsupported XML character entity %@%@", unknownEntity, semicolon);
             */
        }
        
    }
    while (![scanner isAtEnd]);
    
finish:
    return result;
}
@end




@implementation NSObject (logProperties)




- (void) logProperties {
    
    NSLog(@"---------------------BEGIN---------------------- Properties for object %@", self);
    
    @autoreleasepool {
        unsigned int numberOfProperties = 0;
        objc_property_t *propertyArray = class_copyPropertyList([self class], &numberOfProperties);
        for (NSUInteger i = 0; i < numberOfProperties; i++) {
            objc_property_t property = propertyArray[i];
            NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)] ;           NSLog(@"\n%@:%@ \n", name, [self valueForKey:name]);
            
        }
        
        free(propertyArray);
    }
    NSLog(@"----------------------END-------------------- Properties for object %@", self);
}
@end