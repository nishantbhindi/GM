//
//  QRCode.h
//  CodeSafe
//
//  Created by WebInfoways on 10/09/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QRCode : NSObject {
	int intQRCodeID;
	
	NSString *strContent;
	NSString *strFormat;
    NSString *strType;
    NSString *strTime;
    NSString *strMetadata;
    NSString *strImage;
    NSString *strDisplayText;
	
	int intIsFavourite;
}

@property(nonatomic) int intQRCodeID;

@property(nonatomic, retain) NSString *strContent;
@property(nonatomic, retain) NSString *strFormat;
@property(nonatomic, retain) NSString *strType;
@property(nonatomic, retain) NSString *strTime;
@property(nonatomic, retain) NSString *strMetadata;
@property(nonatomic, retain) NSString *strImage;
@property(nonatomic, retain) NSString *strDisplayText;

@property(nonatomic) int intIsFavourite;

@end
