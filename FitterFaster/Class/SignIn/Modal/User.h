//
//  User.h
//  
//
//  Created by WebInfoways on 09/05/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
	int intUserID;
	
    NSString *strTitle;
	NSString *strFirstname;
    NSString *strLastname;
    NSString *strMobile;
    
    NSString *strUsername;  //Refers as Email Address
    NSString *strPassword;
    
    NSString *strAddressType;
    
    int intAddressId;
    NSString *strAddress;
    NSString *strCity;
    NSString *strPostcode;
    
    int intAddressIdCurr;
    NSString *strAddressCurr;
    NSString *strCityCurr;
    NSString *strPostcodeCurr;
    
    int intAddressIdCustom;
    NSString *strAddressCustom;
    NSString *strCityCustom;
    NSString *strPostcodeCustom;
    
    NSString *strBirthdate;
    
    NSString *strDeliveryAddress;
    NSString *strDeliveryCity;
    NSString *strDeliveryPostcode;
}
@property(nonatomic) int intUserID;

@property(nonatomic, retain) NSString *strTitle;
@property(nonatomic, retain) NSString *strFirstname;
@property(nonatomic, retain) NSString *strLastname;
@property(nonatomic, retain) NSString *strMobile;

@property(nonatomic, retain) NSString *strUsername;
@property(nonatomic, retain) NSString *strPassword;

@property(nonatomic, retain) NSString *strAddressType;

@property(nonatomic) int intAddressId;
@property(nonatomic, retain) NSString *strAddress;
@property(nonatomic, retain) NSString *strCity;
@property(nonatomic, retain) NSString *strPostcode;

@property(nonatomic) int intAddressIdCurr;
@property(nonatomic, retain) NSString *strAddressCurr;
@property(nonatomic, retain) NSString *strCityCurr;
@property(nonatomic, retain) NSString *strPostcodeCurr;

@property(nonatomic) int intAddressIdCustom;
@property(nonatomic, retain) NSString *strAddressCustom;
@property(nonatomic, retain) NSString *strCityCustom;
@property(nonatomic, retain) NSString *strPostcodeCustom;

@property(nonatomic, retain) NSString *strBirthdate;

@property(nonatomic, retain) NSString *strDeliveryAddress;
@property(nonatomic, retain) NSString *strDeliveryCity;
@property(nonatomic, retain) NSString *strDeliveryPostcode;

@end
