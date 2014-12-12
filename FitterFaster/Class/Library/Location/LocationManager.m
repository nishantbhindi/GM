//
//  LocationManager.m
//  iOSCodeStructure
//
//  Created by Nishant on 15/01/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import "LocationManager.h"

static LocationManager* sharedLocationManager = nil;

@implementation LocationManager

@synthesize locationManager;
@synthesize locationDefined,locationDenied;
@synthesize currentLatitude,currentLongitude;
@synthesize strName,strThoroughFare, strLocality, strAdministrativeArea, strPostCode, strCountry, strCountryCode;

#pragma mark -
#pragma mark Singleton Methods
+ (LocationManager *)sharedInstance {
    @synchronized(self) {
        if(sharedLocationManager == nil)
            sharedLocationManager = [[super allocWithZone:NULL] init];
    }
    return sharedLocationManager;
}
+ (id)allocWithZone:(NSZone *)zone {
    return [[self sharedInstance] retain];
}
- (id)copyWithZone:(NSZone *)zone
{
    return self;
}
- (id)retain
{
    return self;
}
- (unsigned)retainCount
{
    return UINT_MAX;  // denotes an object that cannot be released
}
- (oneway void)release {
    // never release
}
- (id)autorelease
{
    return self;
}
- (id)init
{
    //if ((self = [super init])) {
 	self = [super init];
	if (self != nil)
	{
		appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
		
		self.locationDefined = NO;
		self.locationDenied = NO;
        
		self.locationManager = [[[CLLocationManager alloc] init] autorelease];
		self.locationManager.delegate = self;
		//self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.distanceFilter = 100.0;       //1000.0
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
		
        if(g_IS_iOS8){
            NSLog(@"Location in iOS 8");
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager requestAlwaysAuthorization];
            
            
            /*
            if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
            }*/
        }
        
		if([FunctionManager isSimulator])
		{
			self.currentLatitude = g_Default_Latitude;
			self.currentLongitude = g_Default_Longitude;
            
            [locationManager startMonitoringSignificantLocationChanges];
		}
		else{
			//[locationManager startUpdatingLocation];
            [locationManager startMonitoringSignificantLocationChanges];
        }
	}
	return self;
}
- (void)dealloc
{
    [self.strName release];
	[self.strThoroughFare release];
	[self.strLocality release];
	[self.strAdministrativeArea release];
	[self.strPostCode release];
	[self.strCountry release];
	[self.strCountryCode release];
	
	[super dealloc];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager*)manager	didUpdateToLocation:(CLLocation*)newLocation fromLocation:(CLLocation*)oldLocation
{
	self.locationDefined = YES;
	self.locationDenied = NO;
	self.currentLatitude = newLocation.coordinate.latitude;
	self.currentLongitude = newLocation.coordinate.longitude;
    //self.currentLatitude = g_Default_Latitude;
	//self.currentLongitude = g_Default_Longitude;
    
    NSLog(@"%f=%f", self.currentLatitude, self.currentLongitude);
    
	appDelegate.isGPSLocationActive =TRUE;
	
    appDelegate.douCurrentLatitude =self.currentLatitude;
    appDelegate.douCurrentLongitude =self.currentLongitude;
    
    CLGeocoder *geoCoder = [[[CLGeocoder alloc] init] autorelease];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:self.currentLatitude longitude:self.currentLongitude];
    
    [geoCoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        if(!error){
            for (CLPlacemark *placemark in placemarks) {
                self.strLocality = [placemark locality];
                //self.displayedCity.stadtCoord   = placemark.region.center;
                
                self.strName = placemark.name;                                                          //Road No 19        //35-39 Bridge Street
                self.strThoroughFare = placemark.thoroughfare;  //subThoroughfare                       //Road No 19        //Bridge Street
                //self.strLocality = placemark.locality;    //subLocality                               //Mumbai            //Sydney
                self.strAdministrativeArea = placemark.administrativeArea;  //subAdministrativeArea     //Maharashtra       //NSW
                self.strPostCode = placemark.postalCode;                                                //(null)            //2000
                self.strCountry = placemark.country;                                                    //India             //Australia
                self.strCountryCode = placemark.ISOcountryCode;                                         //IN                //AU
            }
            
            //NSLog(@"%@-%@-%@-%@-%@-%@-%@", self.strName, self.strThoroughFare, self.strLocality, self.strAdministrativeArea, self.strPostCode, self.strCountry, self.strCountryCode);
            
            //Bind Current Address//
            NSString *strCurrAddress = @"";
            if(![self.strName isEmptyString] && !(self.strName==nil))
            {
                if([strCurrAddress isEmptyString])
                    strCurrAddress = self.strName;
                else
                    strCurrAddress = [NSString stringWithFormat:@"%@,%@", strCurrAddress, self.strName];
            }
            if(![self.strThoroughFare isEmptyString] && !(self.strThoroughFare==nil))
            {
                if([strCurrAddress isEmptyString])
                    strCurrAddress = self.strThoroughFare;
                else
                    strCurrAddress = [NSString stringWithFormat:@"%@,%@", strCurrAddress, self.strThoroughFare];
            }
            if(![self.strLocality isEmptyString] && !(self.strLocality==nil))
            {
                if([strCurrAddress isEmptyString])
                    strCurrAddress = self.strLocality;
                else
                    strCurrAddress = [NSString stringWithFormat:@"%@,%@", strCurrAddress, self.strLocality];
            }
            if(![self.strAdministrativeArea isEmptyString] && !(self.strAdministrativeArea==nil))
            {
                if([strCurrAddress isEmptyString])
                    strCurrAddress = self.strAdministrativeArea;
                else
                    strCurrAddress = [NSString stringWithFormat:@"%@,%@", strCurrAddress, self.strAdministrativeArea];
            }
            if(![self.strCountryCode isEmptyString] && !(self.strCountryCode==nil))
            {
                if([strCurrAddress isEmptyString])
                    strCurrAddress = self.strCountryCode;
                else
                    strCurrAddress = [NSString stringWithFormat:@"%@,%@", strCurrAddress, self.strCountryCode];
            }
            //Bind Current Address End//
            
            appDelegate.strCurrentAddress = strCurrAddress;
            NSLog(@"%@", strCurrAddress);
            
            /*
            if(appDelegate.objUser.intUserID>0)
                [self updateUserLocation];
             */
        }
        else{
            
            self.strName = @"";
            self.strThoroughFare = @"";
            self.strLocality = @"";
            self.strAdministrativeArea = @"";
            self.strPostCode = @"";
            self.strCountry = @"";
            self.strCountryCode = @"";
            
            NSLog(@"failed getting location: %@", [error description]);
        }
        
    }];
    
    /*
	// this creates a MKReverseGeocoder to find a placemark using the found coordinates
    MKReverseGeocoder *geoCoder = [[[MKReverseGeocoder alloc] initWithCoordinate:newLocation.coordinate] autorelease];
        geoCoder.delegate = self;
    [geoCoder start];
     */
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.locationDefined = YES;
    self.locationDenied = NO;
    self.currentLatitude = [[locations objectAtIndex:([locations count]-1)] coordinate].latitude;
    self.currentLongitude = [[locations objectAtIndex:([locations count]-1)] coordinate].longitude;

    //self.currentLatitude = g_Default_Latitude;
    //self.currentLongitude = g_Default_Longitude;
    
    NSLog(@"%f=%f", self.currentLatitude, self.currentLongitude);
    
    appDelegate.isGPSLocationActive =TRUE;
    
    appDelegate.douCurrentLatitude =self.currentLatitude;
    appDelegate.douCurrentLongitude =self.currentLongitude;
    
    CLGeocoder *geoCoder = [[[CLGeocoder alloc] init] autorelease];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:self.currentLatitude longitude:self.currentLongitude];
    
    [geoCoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        if(!error){
            for (CLPlacemark *placemark in placemarks) {
                self.strLocality = [placemark locality];
                //self.displayedCity.stadtCoord   = placemark.region.center;
                
                self.strName = placemark.name;                                                          //Road No 19        //35-39 Bridge Street
                self.strThoroughFare = placemark.thoroughfare;  //subThoroughfare                       //Road No 19        //Bridge Street
                //self.strLocality = placemark.locality;    //subLocality                               //Mumbai            //Sydney
                self.strAdministrativeArea = placemark.administrativeArea;  //subAdministrativeArea     //Maharashtra       //NSW
                self.strPostCode = placemark.postalCode;                                                //(null)            //2000
                self.strCountry = placemark.country;                                                    //India             //Australia
                self.strCountryCode = placemark.ISOcountryCode;                                         //IN                //AU
            }
            
            //NSLog(@"%@-%@-%@-%@-%@-%@-%@", self.strName, self.strThoroughFare, self.strLocality, self.strAdministrativeArea, self.strPostCode, self.strCountry, self.strCountryCode);
            
            //Bind Current Address//
            NSString *strCurrAddress = @"";
            if(![self.strName isEmptyString] && !(self.strName==nil))
            {
                if([strCurrAddress isEmptyString])
                    strCurrAddress = self.strName;
                else
                    strCurrAddress = [NSString stringWithFormat:@"%@,%@", strCurrAddress, self.strName];
            }
            if(![self.strThoroughFare isEmptyString] && !(self.strThoroughFare==nil))
            {
                if([strCurrAddress isEmptyString])
                    strCurrAddress = self.strThoroughFare;
                else
                    strCurrAddress = [NSString stringWithFormat:@"%@,%@", strCurrAddress, self.strThoroughFare];
            }
            if(![self.strLocality isEmptyString] && !(self.strLocality==nil))
            {
                if([strCurrAddress isEmptyString])
                    strCurrAddress = self.strLocality;
                else
                    strCurrAddress = [NSString stringWithFormat:@"%@,%@", strCurrAddress, self.strLocality];
            }
            if(![self.strAdministrativeArea isEmptyString] && !(self.strAdministrativeArea==nil))
            {
                if([strCurrAddress isEmptyString])
                    strCurrAddress = self.strAdministrativeArea;
                else
                    strCurrAddress = [NSString stringWithFormat:@"%@,%@", strCurrAddress, self.strAdministrativeArea];
            }
            if(![self.strCountryCode isEmptyString] && !(self.strCountryCode==nil))
            {
                if([strCurrAddress isEmptyString])
                    strCurrAddress = self.strCountryCode;
                else
                    strCurrAddress = [NSString stringWithFormat:@"%@,%@", strCurrAddress, self.strCountryCode];
            }
            //Bind Current Address End//
            
            appDelegate.strCurrentAddress = strCurrAddress;
            NSLog(@"%@", strCurrAddress);
            
            /*
             if(appDelegate.objUser.intUserID>0)
             [self updateUserLocation];
             */
        }
        else{
            
            self.strName = @"";
            self.strThoroughFare = @"";
            self.strLocality = @"";
            self.strAdministrativeArea = @"";
            self.strPostCode = @"";
            self.strCountry = @"";
            self.strCountryCode = @"";
            
            NSLog(@"failed getting location: %@", [error description]);
        }
        
    }];
}
- (void)locationManager:(CLLocationManager*)manager didFailWithError:(NSError*)error
{
	if([error code]== kCLErrorDenied)
		self.locationDenied = YES;
	
	switch ([error code]) {
            // "Don't Allow" on two successive app launches is the same as saying "never allow". The user
            // can reset this for all apps by going to Settings > General > Reset > Reset Location Warnings.
        case kCLErrorDenied:
            //[appDelegate showAllowGPSLocationView];
        default:
            break;
    }
	
	self.locationDefined = NO;
	
    self.strName = @"";
	self.strThoroughFare = @"";
	self.strLocality = @"";
	self.strAdministrativeArea = @"";
	self.strPostCode = @"";
	self.strCountry = @"";
	self.strCountryCode = @"";
}

#pragma mark Update User Location
/*
-(void)updateUserLocation{
    NSURL *baseURL = [NSURL URLWithString:g_WebserviceUrl];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"action"] = @"update_user_location";
    
    //parameters[@"device_id"] = appDelegate.strDeviceIdentifierForVendor;
    parameters[@"device_id"] = appDelegate.strDeviceToken;
    parameters[@"user_id"] = [NSString stringWithFormat:@"%d", appDelegate.objUser.intUserID];
    parameters[@"latitude"] = [NSString stringWithFormat:@"%f", appDelegate.douCurrentLatitude];
    parameters[@"longitude"] = [NSString stringWithFormat:@"%f", appDelegate.douCurrentLongitude];
    parameters[@"address"] = appDelegate.strCurrentAddress;
    
    //iOS6 & Above = AFHTTPRequestOperationManager
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:g_Pagename_Api parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[FunctionManager showMessage:@"" withMessage:[error localizedDescription] withDelegage:nil];
        NSLog(@"ERROR: %@", [error localizedDescription]);
    }];
}*/

/*
// this delegate is called when the reverseGeocoder finds a placemark
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
    self.strName = placemark.name;
	self.strThoroughFare = placemark.thoroughfare;
	self.strLocality = placemark.locality;
	self.strAdministrativeArea = placemark.administrativeArea;
	self.strPostCode = placemark.postalCode;
	self.strCountry = placemark.country;
	self.strCountryCode = placemark.countryCode;
	
	NSLog(@"%@-%@-%@-%@-%@-%@-%@", self.strName, self.strThoroughFare, self.strLocality, self.strAdministrativeArea, self.strPostCode, self.strCountry, self.strCountryCode);
    
    appDelegate.strCurrentAddress = [NSString stringWithFormat:@"%@-%@-%@-%@-%@-%@-%@", self.strName, self.strThoroughFare, self.strLocality, self.strAdministrativeArea, self.strPostCode, self.strCountry, self.strCountryCode];
}
// this delegate is called when the reversegeocoder fails to find a placemark
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
    //NSLog(@"reverseGeocoder:%@ didFailWithError:%@", geocoder, error);
	
    self.strName = @"";
	self.strThoroughFare = @"";
	self.strLocality = @"";
	self.strAdministrativeArea = @"";
	self.strPostCode = @"";
	self.strCountry = @"";
	self.strCountryCode = @"";
}
*/

@end
