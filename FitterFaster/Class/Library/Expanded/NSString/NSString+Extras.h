//
//  NSString+Extras.h
//  iOSCodeStructure
//
//  Created by Nishant on 02/01/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extras)

-(NSString *)stringWithSubstitute:(NSString *)subs forCharactersFromSet:(NSCharacterSet *)set;
-(NSString *)trimWhiteSpace;
-(NSString *)stripHTML;
-(NSString *)ellipsizeAfterNWords: (int) n;

// Validation for empty/email/url
-(BOOL)isEmptyString;
-(BOOL)isValidEmail;
-(BOOL)isValidURL;
-(BOOL)isValidPassword;

// Common custom encryption/decryption for all platform
-(NSString *)encryptCommonPassword;
-(NSString *)decryptCommonPassword;
-(int)getRandomNumber:(int)from to:(int)to;
-(NSString *)implodeArray:(NSMutableArray *)pArr withGlueString:(NSString *)pStrGlueString;

// Convert String to URL
-(NSURL*)toURL;
-(NSURL *)toWebURL;

// starts/ends-with compare/escaping/count substring
-(BOOL)startsWithString:(NSString*)otherString;
-(BOOL)endsWithString:(NSString*)otherString;
-(NSComparisonResult)compareCaseInsensitive:(NSString*)other;
-(NSString*)stringByPercentEscapingCharacters:(NSString*)characters;
-(NSString*)stringByEscapingURL;
-(NSString*)stringByUnescapingURL;
-(int)countSubstring:(NSString *)aString ignoringCase:(BOOL)flag;
-(NSString *)getSubstringOfLength:(NSInteger)pIntLength;

// Check String Exists
-(BOOL)containsString:(NSString *)aString;
-(BOOL)containsString:(NSString *)aString ignoringCase:(BOOL)flag;
-(BOOL)containString:(NSString*)pstrStringArray separationBy:(NSString*)pstrSeparation;

// Get Size/Height based on String
-(CGSize)getDynamicHeight:(int)pIntFixWidth andHeight:(int)pIntFixHeight withFontName:(NSString *)pstrFontName andFontSize:(CGFloat)pFontSize;
-(CGSize)getDynemicHeight:(int)pintFixWidth;
-(CGSize)getTheStringSizeForCell;
-(CGFloat)getTheStringHeightForCell;

// Date Compare
-(BOOL)isGreaterToDate:(NSString *)pStrToDate;
-(CGFloat)getHoursFromDate:(NSString *)pStrDateTime;
-(int)getDateDifferenceInDays:(NSString *)pstrDate;

// Date Format Conversion
-(NSString *)convertToDateFormat:(NSString *)pFromDateFormat ToDateFormat:(NSString *)pToDateFormat;

// Trimming
-(NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet;
-(NSString *)stringByTrimmingLeadingWhitespaceAndNewlineCharacters;
-(NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet;
-(NSString *)stringByTrimmingTrailingWhitespaceAndNewlineCharacters;

// MD5
-(NSString *)stringFromMD5;

@end
