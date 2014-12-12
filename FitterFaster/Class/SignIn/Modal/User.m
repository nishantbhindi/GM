//
//  User.m
//  
//
//  Created by WebInfoways on 09/05/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize intUserID;
@synthesize strTitle,strFirstname,strLastname,strMobile;
@synthesize strUsername,strPassword;
@synthesize strAddressType;
@synthesize intAddressId,strAddress,strCity,strPostcode;
@synthesize intAddressIdCurr,strAddressCurr,strCityCurr,strPostcodeCurr;
@synthesize intAddressIdCustom,strAddressCustom,strCityCustom,strPostcodeCustom;
@synthesize strBirthdate;
@synthesize strDeliveryAddress,strDeliveryCity,strDeliveryPostcode;

-(void)dealloc{
    [self.strTitle release];
	[self.strFirstname release];
    [self.strLastname release];
    [self.strMobile release];
    
    [self.strUsername release];
    [self.strPassword release];
    
    [self.strAddressType release];
    
    [self.strAddress release];
    [self.strCity release];
    [self.strPostcode release];
    
    [self.strAddressCurr release];
    [self.strCityCurr release];
    [self.strPostcodeCurr release];
    
    [self.strAddressCustom release];
    [self.strCityCustom release];
    [self.strPostcodeCustom release];
        
    [self.strBirthdate release];
    
    [self.strDeliveryAddress release];
    [self.strDeliveryCity release];
    [self.strDeliveryPostcode release];
    
	[super dealloc];
}

@end
