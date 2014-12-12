//
//  SignInViewController.m
//  VideoTest
//
//  Created by WebInfoways on 11/04/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self initializePageData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self bindRememberCredential];
}

#pragma mark - Bind RememberMe
-(void)bindRememberCredential{
    NSString *strUsername = [FunctionManager fetchFromNSUserDefaults:kUSERNAME];
    NSString *strPassword = [FunctionManager fetchFromNSUserDefaults:kPASSWORD];
    
    if(strUsername == nil || strPassword == nil || [strUsername isEqualToString:@""] || [strPassword isEqualToString:@""]){
        _txtUsername.text = @"";
        _txtPassword.text = @"";
    }
    else {
        _txtUsername.text = strUsername;
        //_txtPassword.text = strPassword;
        
        //[self btnTappedSignIn:nil];
    }
}
-(void)addCredentialToRememberMe{
    [FunctionManager addToNSUserDefaults:_txtUsername.text forKey:kUSERNAME];
    [FunctionManager addToNSUserDefaults:_txtPassword.text forKey:kPASSWORD];
}

#pragma mark - Initialize Page Data
-(void)initializePageData{
    [self resetData];
}

#pragma mark - Sign In
#pragma mark Reset Data
-(void)resetData{
    _txtUsername.text=@"";
    _txtPassword.text=@"";
    
    [self resignResponder];
}
-(void)resignResponder{
	[_txtUsername resignFirstResponder];
    [_txtPassword resignFirstResponder];
}
#pragma mark Validate Entered Data
-(BOOL)checkEnteredData{
	if([_txtUsername.text isEmptyString]){
		[FunctionManager showMessage:nil withMessage:msgEnterUsername withDelegage:nil];
		return FALSE;
	}
    /*else if(![_txtUsername.text isEmptyString] && ![_txtUsername.text isValidEmail]){
        [FunctionManager showMessage:nil withMessage:msgEnterValidEmail withDelegage:nil];
		return FALSE;
	}*/
    else if([_txtPassword.text isEmptyString]){
		[FunctionManager showMessage:nil withMessage:msgEnterPassword withDelegage:nil];
		return FALSE;
	}
	else {
	}
	return TRUE;
}
#pragma mark SignIn
-(IBAction)btnTappedSignIn:(id)sender{
    if([self checkEnteredData]){
        [self resignResponder];
        [self checkAuthentication];
        
        //[self openCategoryPage];
    }
}
#pragma mark Check Authentication
-(void)checkAuthentication{
    [FunctionManager displayLoadingView:self.view withMessage:msgLoadingLogin appDelegate:appDelegate viewController:self];
    
    NSURL *baseURL = [NSURL URLWithString:g_WebserviceUrl];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"method"] = @"login";
    parameters[@"username"] = _txtUsername.text;
    parameters[@"password"] = _txtPassword.text;
    
    /*
    if([appDelegate.strDeviceToken isEmptyString])
        parameters[@"device_id"] = @"";
    else
        parameters[@"device_id"] = appDelegate.strDeviceToken;
    parameters[@"mobile_type"] = @"0";        //0=iOS, 1=Android
    */
    
    //iOS6 & About = AFHTTPRequestOperationManager
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:g_Pagename_Api parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        
        //NSLog(@"JSON: %@", responseObject);
        [self checkAuthenticationResponse:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        [FunctionManager showMessage:@"" withMessage:[error localizedDescription] withDelegage:nil];
    }];
    
    
    /*
     //iOS7 & About = AFHTTPSessionManager
     AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
     
     manager.responseSerializer = [AFJSONResponseSerializer serializer];
     //AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
     //[manager setResponseSerializer:responseSerializer];
     
     //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
     
     [manager POST:g_Pagename_Api parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
     
        //NSLog(@"JSON: %@", responseObject);
        [self checkAuthenticationResponse:(NSDictionary *)responseObject];
     
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        [FunctionManager showMessage:@"" withMessage:[error localizedDescription] withDelegage:nil];
     }];
     */
}
-(void)checkAuthenticationResponse:(NSDictionary *)pdicResponse{
    int success = [[pdicResponse objectForKey:@"status"] intValue];
    
    if(success)
    {
        NSDictionary *data = (NSDictionary*)[pdicResponse objectForKey:@"customer_data"];
        //NSString *strId = (NSString*)[data objectForKey:@"entity_id"];
        //NSLog(@"%@", strId);
        
        appDelegate.objUser.intUserID = [[data objectForKey:@"entity_id"] intValue];
        appDelegate.objUser.strTitle = (NSString*)[data objectForKey:@"prefix"];
        appDelegate.objUser.strFirstname = (NSString*)[data objectForKey:@"firstname"];
        appDelegate.objUser.strLastname = (NSString*)[data objectForKey:@"lastname"];
        appDelegate.objUser.strMobile = (NSString*)[data objectForKey:@"telephone"];    //mobile
        
        appDelegate.objUser.strUsername = (NSString*)[data objectForKey:@"email"];
        appDelegate.objUser.strPassword = @"";
                
        appDelegate.objUser.strBirthdate = (NSString*)[data objectForKey:@"dob"];
        
        
        //Parse Address
        NSArray *dataAddress = (NSArray*)[pdicResponse objectForKey:@"customer_address"];
        for(int i=0;i<dataAddress.count;i++){
            NSDictionary *dicAddr = (NSDictionary*)[dataAddress objectAtIndex:i];
            
            NSString *strAddrType = (NSString*)[dicAddr objectForKey:@"address_type"];
            
            if([strAddrType isEqualToString:@"home"]){
                appDelegate.objUser.intAddressId = [[dicAddr objectForKey:@"customer_address_id"] intValue];
                appDelegate.objUser.strAddress = (NSString*)[dicAddr objectForKey:@"street"];
                appDelegate.objUser.strCity = (NSString*)[dicAddr objectForKey:@"city"];
                appDelegate.objUser.strPostcode = (NSString*)[dicAddr objectForKey:@"postcode"];
            }
            else if([strAddrType isEqualToString:@"current"]){
                appDelegate.objUser.intAddressIdCurr = [[dicAddr objectForKey:@"customer_address_id"] intValue];
                appDelegate.objUser.strAddressCurr = (NSString*)[dicAddr objectForKey:@"street"];
                appDelegate.objUser.strCityCurr = (NSString*)[dicAddr objectForKey:@"city"];
                appDelegate.objUser.strPostcodeCurr = (NSString*)[dicAddr objectForKey:@"postcode"];
            }
            else if([strAddrType isEqualToString:@"custom"]){
                appDelegate.objUser.intAddressIdCustom = [[dicAddr objectForKey:@"customer_address_id"] intValue];
                appDelegate.objUser.strAddressCustom = (NSString*)[dicAddr objectForKey:@"street"];
                appDelegate.objUser.strCityCustom = (NSString*)[dicAddr objectForKey:@"city"];
                appDelegate.objUser.strPostcodeCustom = (NSString*)[dicAddr objectForKey:@"postcode"];
            }
        }
        
        appDelegate.objUser.strAddressType = @"home";
        
        appDelegate.objUser.strDeliveryAddress = appDelegate.objUser.strAddress;
        appDelegate.objUser.strDeliveryCity = appDelegate.objUser.strCity;
        appDelegate.objUser.strDeliveryPostcode = appDelegate.objUser.strPostcode;
        
        //appDelegate.objUser.strMobile = (NSString*)[dicAddr objectForKey:@"telephone"];
        
        //[FunctionManager addUserToNSUserDefaults:appDelegate.objUser forKey:@"User"];
        
        [self openCategoryPage];
    }
    else
        [FunctionManager showMessage:@"" withMessage:[pdicResponse objectForKey:@"message"] withDelegage:nil];
}
-(void)openCategoryPage{
    [self addCredentialToRememberMe];
    
    AddressViewController *objAddressViewController;
    objAddressViewController = [[[AddressViewController alloc] initWithNibName:@"AddressViewController" bundle:nil] autorelease];
    [self.navigationController pushViewController:objAddressViewController animated:YES];
    
    
    /*
    CategoryViewController *objCategoryViewController;
    objCategoryViewController = [[[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil] autorelease];
    
    
    //    if(g_IS_IPHONE_6PLUS_SCREEN)
    //        objCategoryViewController = [[[CategoryViewController alloc] initWithNibName:@"CategoryViewController6P" bundle:nil] autorelease];
    //    else if(g_IS_IPHONE_6_SCREEN)
    //        objCategoryViewController = [[[CategoryViewController alloc] initWithNibName:@"CategoryViewController6" bundle:nil] autorelease];
    //    else if(g_IS_IPHONE_5_SCREEN)
    //        objCategoryViewController = [[[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil] autorelease];
    //    else if(g_IS_IPHONE_4_SCREEN)
    //        objCategoryViewController = [[[CategoryViewController alloc] initWithNibName:@"CategoryViewController4" bundle:nil] autorelease];
    //    //else if(g_IS_IPAD)
    //        //objCategoryViewController = [[[CategoryViewController alloc] initWithNibName:@"CategoryViewControlleriPad" bundle:nil] autorelease];
    //    else
    //        objCategoryViewController = [[[CategoryViewController alloc] initWithNibName:@"CategoryViewController4" bundle:nil] autorelease];
    
    
    //objCategoryViewController.imgPhotoPreview = imgPhotoToShare;
    [self.navigationController pushViewController:objCategoryViewController animated:YES];
    */
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Sign Up
-(IBAction)btnTappedSignUp:(id)sender{
    SignUpViewController *objSignUpViewController;
    objSignUpViewController = [[[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil] autorelease];
    
    /*
    if(g_IS_IPHONE_6PLUS_SCREEN)
        objSignUpViewController = [[[SignUpViewController alloc] initWithNibName:@"SignUpViewController6P" bundle:nil] autorelease];
    else if(g_IS_IPHONE_6_SCREEN)
        objSignUpViewController = [[[SignUpViewController alloc] initWithNibName:@"SignUpViewController6" bundle:nil] autorelease];
    else if(g_IS_IPHONE_5_SCREEN)
        objSignUpViewController = [[[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil] autorelease];
    else if(g_IS_IPHONE_4_SCREEN)
        objSignUpViewController = [[[SignUpViewController alloc] initWithNibName:@"SignUpViewController4" bundle:nil] autorelease];
    //else if(g_IS_IPAD)
        //objSignUpViewController = [[[SignUpViewController alloc] initWithNibName:@"SignUpViewControlleriPad" bundle:nil] autorelease];
    else
        objSignUpViewController = [[[SignUpViewController alloc] initWithNibName:@"SignUpViewController4" bundle:nil] autorelease];
    */
    
    //objSignUpViewController.imgPhotoPreview = imgPhotoToShare;
    [self.navigationController pushViewController:objSignUpViewController animated:YES];
}

#pragma mark - Forgot Password
-(IBAction)btnTappedForgotPassword:(id)sender{
    ForgotPasswordViewController *objForgotPasswordViewController;
    objForgotPasswordViewController = [[[ForgotPasswordViewController alloc] initWithNibName:@"ForgotPasswordViewController" bundle:nil] autorelease];
    
    /*
    if(g_IS_IPHONE_6PLUS_SCREEN)
        objForgotPasswordViewController = [[[ForgotPasswordViewController alloc] initWithNibName:@"ForgotPasswordViewController6P" bundle:nil] autorelease];
    else if(g_IS_IPHONE_6_SCREEN)
        objForgotPasswordViewController = [[[ForgotPasswordViewController alloc] initWithNibName:@"ForgotPasswordViewController6" bundle:nil] autorelease];
    else if(g_IS_IPHONE_5_SCREEN)
        objForgotPasswordViewController = [[[ForgotPasswordViewController alloc] initWithNibName:@"ForgotPasswordViewController" bundle:nil] autorelease];
    else if(g_IS_IPHONE_4_SCREEN)
        objForgotPasswordViewController = [[[ForgotPasswordViewController alloc] initWithNibName:@"ForgotPasswordViewController4" bundle:nil] autorelease];
    //else if(g_IS_IPAD)
        //objForgotPasswordViewController = [[[ForgotPasswordViewController alloc] initWithNibName:@"ForgotPasswordViewControlleriPad" bundle:nil] autorelease];
    else
        objForgotPasswordViewController = [[[ForgotPasswordViewController alloc] initWithNibName:@"ForgotPasswordViewController4" bundle:nil] autorelease];
    */
    
    [self.navigationController pushViewController:objForgotPasswordViewController animated:YES];
    //[self.navigationController presentViewController:objForgotPasswordViewController animated:YES completion:nil];
}

#pragma mark - Retail Partner
-(IBAction)btnTappedRetailPartner:(id)sender{
    WebPageViewController *objWebPageViewController;
    objWebPageViewController = [[[WebPageViewController alloc] initWithNibName:@"WebPageViewController" bundle:nil] autorelease];
    
    /*
     if(g_IS_IPHONE_6PLUS_SCREEN)
        objWebPageViewController = [[[WebPageViewController alloc] initWithNibName:@"WebPageViewController6P" bundle:nil] autorelease];
     else if(g_IS_IPHONE_6_SCREEN)
        objWebPageViewController = [[[WebPageViewController alloc] initWithNibName:@"WebPageViewController6" bundle:nil] autorelease];
     else if(g_IS_IPHONE_5_SCREEN)
        objWebPageViewController = [[[WebPageViewController alloc] initWithNibName:@"WebPageViewController" bundle:nil] autorelease];
     else if(g_IS_IPHONE_4_SCREEN)
        objWebPageViewController = [[[WebPageViewController alloc] initWithNibName:@"WebPageViewController4" bundle:nil] autorelease];
     //else if(g_IS_IPAD)
        //objWebPageViewController = [[[WebPageViewController alloc] initWithNibName:@"WebPageViewControlleriPad" bundle:nil] autorelease];
     else
        objWebPageViewController = [[[WebPageViewController alloc] initWithNibName:@"WebPageViewController4" bundle:nil] autorelease];
     */
    
    objWebPageViewController.strPageTitle = g_RetaiPartnerTitle;
    objWebPageViewController.strPageUrl = g_RetaiPartnerUrl;
    [self.navigationController pushViewController:objWebPageViewController animated:YES];
}

#pragma mark - Orientations
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}
/*
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
        return YES;
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
        return YES;
    }
    return NO;
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_txtUsername release];
    [_txtPassword release];
    
    [super dealloc];
}

@end
