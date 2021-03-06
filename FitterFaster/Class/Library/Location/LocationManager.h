//
//  LocationManager.h
//  iOSCodeStructure
//
//  Created by Nishant on 15/01/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate> {   //MKReverseGeocoderDelegate
	AppDelegate *appDelegate;
	
	CLLocationManager* locationManager;
    
	BOOL locationDefined;
	BOOL locationDenied;
    
	double currentLatitude;
	double currentLongitude;
    
	//GPS Location Address
    NSString *strName;//Name
	NSString *strThoroughFare;//Address
	NSString *strLocality;//City
	NSString *strAdministrativeArea;//State
	NSString *strPostCode;//PostCode
	NSString *strCountry;//Country
	NSString *strCountryCode;//CountryCode
}

@property (nonatomic, retain) CLLocationManager* locationManager;

@property (nonatomic, assign) BOOL locationDefined;
@property (nonatomic, assign) BOOL locationDenied;
@property (nonatomic, assign) double currentLatitude;
@property (nonatomic, assign) double currentLongitude;

//GPS Location Address
@property (nonatomic, retain) NSString *strName;
@property (nonatomic, retain) NSString *strThoroughFare;
@property (nonatomic, retain) NSString *strLocality;
@property (nonatomic, retain) NSString *strAdministrativeArea;
@property (nonatomic, retain) NSString *strPostCode;
@property (nonatomic, retain) NSString *strCountry;
@property (nonatomic, retain) NSString *strCountryCode;

+ (LocationManager*)sharedInstance; // Singleton method

@end
