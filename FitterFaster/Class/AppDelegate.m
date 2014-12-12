//
//  AppDelegate.m
//  GW Whiteboard
//
//  Created by WebInfoways on 03/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "AppDelegate.h"
#import "PayPalMobile.h"
#import "SignInViewController.h"

#define kGPS_Screen_Position_Y          ((g_IS_iOS7) ? 20.0 : 20.0)

@interface AppDelegate ()

@end

@implementation AppDelegate

//Loading
@synthesize viewLoading;
@synthesize lblLoadingMessage;
//Database
@synthesize objDBAdapter;
//GPS Location
@synthesize objLocationManager;
@synthesize viewAllowGPSLocation;
@synthesize lblAllowGPSMessage;
@synthesize isGPSLocationActive;
//Default GPS Data
@synthesize intGPSEnable,strCurrentAddress,douCurrentLatitude,douCurrentLongitude;

//User
@synthesize objUser;
@synthesize strDeviceToken;
@synthesize bolIsAcceptTerms;

@synthesize intSelectedMenuNo;

//@synthesize arrPostCode;

- (void)dealloc
{
    //Loading
    [self.viewLoading release];
    [self.lblLoadingMessage release];
    
    //Internet Checking
    [_viewNoInternet release];
    [_objInternetAvailable release];
    
    /*
    if(self.arrPostCode.count>0)
        [self.arrPostCode removeAllObjects];
    [self.arrPostCode release];*/
    
    //Device Token
    [self.strDeviceToken release];
    
    //Database
    [self.objDBAdapter release];
    
    //GPS Location
    [self.lblAllowGPSMessage release];
    [self.viewAllowGPSLocation release];
    [self.objLocationManager release];
    
    [_objSignInViewController release];
    [_navController release];
    [_window release];
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initializeAppData];           //initialize app data
    [self checkDeviceCompatibility];    //device compatibility
    
    //self.window.rootViewController = self.viewController;
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - Initialize App Data
-(void)initializeAppData{
    [self setPayPalID];
    
    /*
    self.arrPostCode = [[NSMutableArray alloc] init];
    
    [self.arrPostCode addObject:kPlaceholder_PostCode];
    [self.arrPostCode addObject:@"W1N 4DJ"];
    [self.arrPostCode addObject:@"EC1A 1BB"];
    [self.arrPostCode addObject:@"CR03RL"];
    [self.arrPostCode addObject:@"W1A1AX"];*/
    
    
    objUser = [[User alloc] init];
    self.bolIsAcceptTerms = FALSE;
    //Device Token
    self.strDeviceToken = @"";
    
    //Prevent Device from Sleep Mode
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    //Configure AFNetworking
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    //GPS Location
    self.douCurrentLatitude = 0.0;
    self.douCurrentLongitude = 0.0;
    self.strCurrentAddress = @"";
    
    self.objLocationManager = [[LocationManager alloc] init];
    [self.objLocationManager.locationManager startUpdatingLocation];
    
    [self.lblAllowGPSMessage setText:msgGPSLocationAllow];
    [self.viewAllowGPSLocation setFrame:CGRectMake(0.0, kGPS_Screen_Position_Y, self.viewAllowGPSLocation.frame.size.width, self.viewAllowGPSLocation.frame.size.height)];
    
    //Internet Checking
    //_objInternetAvailable = [[ClsInternetChecking alloc] init];
    //[_viewNoInternet setFrame:CGRectMake(0.0, 20.0, _viewNoInternet.frame.size.width, _viewNoInternet.frame.size.height)];
    
    //Database
    //self.objDBAdapter = [[DBAdapter alloc] init];
    
    [self checkForStoredData];
    [self checkForSettingsData];
}
#pragma mark - Set PayPal ID
-(void)setPayPalID{
    /*
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"YOUR_CLIENT_ID_FOR_PRODUCTION",
     PayPalEnvironmentSandbox : @"YOUR_CLIENT_ID_FOR_SANDBOX"}];
     */
    
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"ARnK_xBJH_1q52_67TyDfxA7cK3r3As_mX5Cn3j4_SwnvmRg28JS_vFI9Z17",
                                                           PayPalEnvironmentSandbox : @"ARnK_xBJH_1q52_67TyDfxA7cK3r3As_mX5Cn3j4_SwnvmRg28JS_vFI9Z17"}];
    
    /*[PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"AZkx-taTkFwV7LewbBHRHJmqY6BWAcEJX1.6wpZU0GoV3jSHn0UaUg7N",
     PayPalEnvironmentSandbox : @"AZkx-taTkFwV7LewbBHRHJmqY6BWAcEJX1.6wpZU0GoV3jSHn0UaUg7N"}];/*/
}

#pragma mark - Check Device Compatibility
-(void)checkDeviceCompatibility{
    /*NSLog(@"Device: %@", [[UIDevice currentDevice] model]);
     NSLog(@"Retina Support: %d", [FunctionManager isRetinaSupport]);
     NSLog(@"App Name: %@", g_APP_NAME);*/
    
    _objSignInViewController = [[[SignInViewController alloc] initWithNibName:@"SignInViewController" bundle:nil] autorelease];
    
    /*
    if(g_IS_IPHONE_6PLUS_SCREEN)
    {
        _viewController = [[[MainViewController alloc] initWithNibName:@"MainViewController6P" bundle:nil] autorelease];
    }
    else if(g_IS_IPHONE_6_SCREEN)
    {
        _viewController = [[[MainViewController alloc] initWithNibName:@"MainViewController6" bundle:nil] autorelease];
    }
    else if(g_IS_IPHONE_5_SCREEN)
    {
        _viewController = [[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil] autorelease];
        
        //        if(g_IS_IPHONE)
        //            NSLog(@"Hey, this is an iPhone 5 screen!");
        //        else if(g_IS_IPOD)
        //            NSLog(@"Hey, this is an iPod 5 screen!");
        //        else
        //            NSLog(@"Hey, this is a simulator screen with iPhone 5 screen height!");
    }
    else if(g_IS_IPHONE_4_SCREEN)
    {
        _viewController = [[[MainViewController alloc] initWithNibName:@"MainViewController4" bundle:nil] autorelease];
        
        //        if(g_IS_IPHONE)
        //            NSLog(@"Hey, this is a lower iPhone screen than 5!");
        //        else if(g_IS_IPOD)
        //            NSLog(@"Hey, this is a lower iPod screen than 5!");
        //        else
        //            NSLog(@"Hey, this is a lower simulator screen than 5!");
    }
    //else if(g_IS_IPAD){
        //_viewController = [[[MainViewController alloc] initWithNibName:@"MainViewControlleriPad" bundle:nil] autorelease];
        //NSLog(@"Hey, this is an iPad screen!");
    //}
    else{
        _viewController = [[[MainViewController alloc] initWithNibName:@"MainViewController4" bundle:nil] autorelease];
        //NSLog(@"Hey, this is an ipad simulator screen!");
    }
    */
    
    ////Add Landing Page////
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:_objSignInViewController];    //_viewController
    [nc setNavigationBarHidden:TRUE];
    self.navController = nc;
    [nc release];
    ////Add Landing Page End////
    
    ////OS Version Checked////
    if(g_IS_iOS7)
        NSLog(@"iOS 7");
    else if(g_IS_iOS8)
        NSLog(@"iOS 8");
    else
        NSLog(@"Other OS");
    
    /*
     if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0") && SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        NSLog(@"iOS 6.0.1");
     }
     if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.1.1") && SYSTEM_VERSION_LESS_THAN(@"6.0")) {
        NSLog(@"iOS 5.1.1");
     }
     if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0") && SYSTEM_VERSION_LESS_THAN(@"5.1.1")) {
        NSLog(@"iOS 5.1.1");
     }*/
    ////OS Version Checked////
}

#pragma mark - Check for Stored Data
-(void)checkForStoredData{
    //Check for User Registered or Not
    /*
    if ([FunctionManager fetchUserFromNSUserDefaults:@"User"] == nil) {
        self.objUser.intUserID = 0;
    }
    else{
        self.objUser = [FunctionManager fetchUserFromNSUserDefaults:@"User"];
        self.strDeviceIdentifierForVendor = self.objUser.strDeviceUdidForVendor;
    }*/
    
    //Last Synced Contacts
    /*
    if ([FunctionManager fetchArrayFromNSUserDefaults:@"UpdatedBuddyContacts"] == nil) {
        if(!self.arrUpdatedBuddyContacts)
            self.arrUpdatedBuddyContacts = [[NSMutableArray alloc] init];
    }
    else{
        self.arrUpdatedBuddyContacts = [FunctionManager fetchArrayFromNSUserDefaults:@"UpdatedBuddyContacts"];
    }*/
    
    /*
    //Last Sync Local Contacts Date
    if ([FunctionManager fetchFromNSUserDefaults:@"LastLocalContactsFetch"] == nil) {
     
        NSTimeInterval beforeYear = 20 * 365 * 24 * 60 * 60;
        self.dtLastLocalContactFetch = [[NSDate alloc] initWithTimeIntervalSinceNow:-beforeYear];
        self.dtLastLocalContactFetch = [FunctionManager getDateFromString:[self.dtLastLocalContactFetch description] withFormat:g_DateTimeFormatDefault];
     
        //self.dtLastLocalContactFetch = [NSDate date];
     }
     else{
        self.dtLastLocalContactFetch = [NSDate dateFromString:[NSString stringWithFormat:@"%@",[FunctionManager fetchFromNSUserDefaults:@"LastLocalContactsFetch"]]];
     }
     */
}
#pragma mark - Check for Settings Data
-(void)checkForSettingsData{
    /*
    if ([FunctionManager fetchFromNSUserDefaults:@"DisplayDistance"] == nil || [[FunctionManager fetchFromNSUserDefaults:@"DisplayDistance"] isEqualToString:@""]) {
        self.intDistance = 1;
        [FunctionManager addToNSUserDefaults:@"1" forKey:@"DisplayDistance"];
    }
    else
        self.intDistance = [[FunctionManager fetchFromNSUserDefaults:@"DisplayDistance"] intValue];
    
    
    if ([FunctionManager fetchFromNSUserDefaults:@"APICallIndex"] == nil || [[FunctionManager fetchFromNSUserDefaults:@"APICallIndex"] isEqualToString:@""]) {
        self.intAPICallIndex = 0;
        self.intAPICallDuration = 60;   //g_Default_Duration_APICall
        [FunctionManager addToNSUserDefaults:@"0" forKey:@"APICallIndex"];
    }
    else{
        self.intAPICallIndex = [[FunctionManager fetchFromNSUserDefaults:@"APICallIndex"] intValue];
        switch (self.intAPICallIndex) {
            case 0: //Every Minute
                self.intAPICallDuration = 60;
                break;
            case 1: //Every 5 Minute
                self.intAPICallDuration = 300;
                break;
            case 2: //Every 15 Minute
                self.intAPICallDuration = 900;
                break;
            case 3: //Every 30 Minute
                self.intAPICallDuration = 1800;
                break;
            case 4: //Every 60 Minute
                self.intAPICallDuration = 3600;
                break;
            default:
                self.intAPICallDuration = 60;
                break;
        }
    }
     */
}

#pragma mark - Show/Hide Internet Connection View
-(void)showNoInterntConnection
{
    [self.window addSubview:_viewNoInternet];
    [self.window bringSubviewToFront:_viewNoInternet];
}
-(void)removeNoInternetView
{
    [_viewNoInternet removeFromSuperview];
}

#pragma mark - Show Allow GPS Location
-(void)showAllowGPSLocationView
{
    self.isGPSLocationActive =FALSE;
    [self.window addSubview:self.viewAllowGPSLocation];
    [self.window bringSubviewToFront:self.viewAllowGPSLocation];
}
-(IBAction)closeApp:(id)sender
{
    [self closeAppForceFully];
}
-(void)closeAppForceFully{
    [self.viewAllowGPSLocation removeFromSuperview];
    exit(0);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// YOU NEED TO CAPTURE igAPPID:// schema
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    NSString *urlStr = url.description;
    if ([urlStr hasPrefix:[NSString stringWithFormat:@"ig%@", APP_ID_INSTAGRAM]]) {
        //[self showAlertWithTitle:THIS_METHOD message:url.description];
        return [self.instagram handleOpenURL:url];
    }
    return [self.instagram handleOpenURL:url];
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    NSString *urlStr = url.description;
    if ([urlStr hasPrefix:[NSString stringWithFormat:@"ig%@", APP_ID_INSTAGRAM]]) {
        return [self.instagram handleOpenURL:url];
    }
    else if ([urlStr hasPrefix:[NSString stringWithFormat:@"fb%@", APP_ID_FB]]) {
        return [FBAppCall handleOpenURL:url
                      sourceApplication:sourceApplication
                        fallbackHandler:^(FBAppCall *call) {
                            NSLog(@"In fallback handler");
                        }];
    }
    else if ([[url scheme] isEqualToString:@"myapp"] == YES) {
        NSDictionary *d = [self parametersDictionaryFromQueryString:[url query]];
        
        NSString *token = d[@"oauth_token"];
        NSString *verifier = d[@"oauth_verifier"];
        
//        NSDictionary *dicTwitter = [NSDictionary dictionaryWithObjectsAndKeys:
//                                        @"token", token,
//                                        @"verifier", verifier,
//                                        nil];
        NSDictionary *dicTwitter = [NSDictionary dictionaryWithObjectsAndKeys:
                                    token, @"token",
                                    verifier, @"verifier",
                                    nil];
        
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"TWITTER_AUTH" object:self];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TWITTER_AUTH" object:self userInfo:dicTwitter];
        
        //UIViewController *vc=(UIViewController *)[[self window] rootViewController];
        //[vc setOAuthToken:token oauthVerifier:verifier];
        
        return YES;
    }
    
    return NO;
    
    //return [self.instagram handleOpenURL:url];
}
- (NSDictionary *)parametersDictionaryFromQueryString:(NSString *)queryString {
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    
    NSArray *queryComponents = [queryString componentsSeparatedByString:@"&"];
    
    for(NSString *s in queryComponents) {
        NSArray *pair = [s componentsSeparatedByString:@"="];
        if([pair count] != 2) continue;
        
        NSString *key = pair[0];
        NSString *value = pair[1];
        
        md[key] = value;
    }
    
    return md;
}
*/

@end
