//
//  NSDate+Extras.h
//  iOSCodeStructure
//
//  Created by Nishant on 31/12/12.
//  Copyright (c) 2012 Nishant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extras)

// Duration
- (NSUInteger)daysAgo;
- (NSUInteger)daysAgoAgainstMidnight;
- (NSString *)stringDaysAgo;
- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag;
- (NSUInteger)weekday;

// Conversion
+ (NSDate *)dateFromString:(NSString *)pstrDate;
+ (NSDate *)dateFromString:(NSString *)pstrDate withFormat:(NSString *)pstrFormat;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)pstrFormat;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed alwaysDisplayTime:(BOOL)displayTime;

// Get Day
- (NSDate *)beginningOfWeek;
- (NSDate *)beginningOfDay;
- (NSDate *)endOfWeek;

// Format
- (NSString *)string;
- (NSString *)stringWithFormat:(NSString *)pstrFormat;
- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

// Format
+ (NSString *)dateFormatString;
+ (NSString *)timeFormatString;
+ (NSString *)timestampFormatString;
+ (NSString *)dbFormatString;

@end
