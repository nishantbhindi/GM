//
//  QRCode.m
//  CodeSafe
//
//  Created by WebInfoways on 10/09/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import "QRCode.h"

@implementation QRCode

@synthesize intQRCodeID;
@synthesize strContent,strFormat,strType,strTime,strMetadata,strImage,strDisplayText;
@synthesize intIsFavourite;

-(void)dealloc{
	[self.strContent release];
	[self.strFormat release];
    [self.strType release];
    [self.strTime release];
    [self.strMetadata release];
	[self.strImage release];
    [self.strDisplayText release];
    
	[super dealloc];
}

@end
