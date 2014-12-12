//
//  AddressViewController.m
//  GW Whiteboard
//
//  Created by WebInfoways on 27/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "AddressViewController.h"

#define kOFFSET_FOR_KEYBOARD            186.0       //256.0    //216.0
#define kSCROLL_DISPLAY_Y               ((g_IS_IPHONE_5_SCREEN) ? ((g_IS_iOS7) ? 64.0 : 64.0) : ((g_IS_iOS7) ? 64.0 : 64.0))
#define kSCROLL_HEIGHT_DISPLAY          ((g_IS_IPHONE_5_SCREEN) ? ((g_IS_iOS7) ? 490.0 : 490.0) : ((g_IS_iOS7) ? 490.0 : 490.0))
#define kSCROLL_HEIGHT_DEFAULT          ((g_IS_IPHONE_5_SCREEN) ? ((g_IS_iOS7) ? 490.0 : 490.0) : ((g_IS_iOS7) ? 490.0 : 490.0))

#define kTag_PostCode           1
#define kTag_City               2
#define kTag_Address            3

#define kPosition_PostCode      ((g_IS_IPHONE_5_SCREEN) ? 140.0 : 140.0)
#define kPosition_City          ((g_IS_IPHONE_5_SCREEN) ? 140.0 : 140.0)
#define kPosition_Address       ((g_IS_IPHONE_5_SCREEN) ? 160.0 : 160.0)

#define kPosition_Bottom        ((g_IS_IPHONE_5_SCREEN) ? 0.0 : 0.0)		//kSCROLL_HEIGHT_DEFAULT - kSCROLL_HEIGHT_DISPLAY

#define kPlaceholder_Address    @"Address"

@interface AddressViewController ()

@end

@implementation AddressViewController

@synthesize viewAddresses;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setInitialParameter];
}
- (void)viewWillAppear:(BOOL)animated{
    [self addObserver];
    
    //[self setMenu];
    
    [self bindDefaultData];
}
- (void)viewWillDisappear:(BOOL)animated{
    [self resetTimer];
}
- (void)viewDidDisappear:(BOOL)animated{
    [self removeAddedObserver];
    
    //[_viewMenu release];
}

#pragma mark - Initial Parameter
-(void)setInitialParameter
{
    [FunctionManager setDefaultTableViewStyle:_tblAddress delegate:self];
    _tblAddress.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self setAddressView];
    
    //[self setMenu];
    
    //_lblTitle.text = [NSString stringWithFormat:@"Hi %@ %@", appDelegate.objUser.strTitle, appDelegate.objUser.strFirstname];
    _lblTitle.text = [NSString stringWithFormat:@"Hi %@", appDelegate.objUser.strFirstname];
    
    
    _txtPostcode.inputAccessoryView = _viewInput;
    _txtCity.inputAccessoryView = _viewInput;
    _txtNewAddress.inputAccessoryView = _viewInput;
    
    _txtNewAddress.font=[UIFont fontWithName:g_Font_Name_Default_Control size:g_Font_Size_Default_Control];
    [_txtNewAddress setPlaceholderColor:[UIColor lightGrayColor]];
    
    
    _scrollViewMain.scrollEnabled=YES;
    [_scrollViewMain setFrame:CGRectMake(0.0, kSCROLL_DISPLAY_Y, _scrollViewMain.frame.size.width, kSCROLL_HEIGHT_DISPLAY)];
    [_scrollViewMain setContentSize:CGSizeMake(_scrollViewMain.frame.size.width, kSCROLL_HEIGHT_DEFAULT)];
    //[_scrollViewMain setContentOffset:CGPointMake(0.0, kPosition_Quantity)];
    [_scrollViewMain setContentOffset:CGPointMake(0.0, 0.0)];
    
    [self.view addSubview:_scrollViewMain];
    
    [self resetData:nil];
    
    //[self bindDefaultData];
}
#pragma mark Bind Default Data
-(void)bindDefaultData
{
    //_txtCurrAddress.text = appDelegate.strCurrentAddress;
    _txtCurrAddress.text = [NSString stringWithFormat:@"%@, %@", appDelegate.strCurrentAddress, appDelegate.objLocationManager.strPostCode];
    [self addMarker];
    
    
    _txtPostcode.text = appDelegate.objUser.strPostcodeCustom;
    _txtCity.text = appDelegate.objUser.strCityCustom;
    _txtNewAddress.text = appDelegate.objUser.strAddressCustom;
}

#pragma mark - Add Marker to Map
-(void)addMarker
{
    [self.objLocationMap removeAnnotations:self.objLocationMap.annotations];
    
    double douLatitude = appDelegate.objLocationManager.currentLatitude;
    double douLongitude = appDelegate.objLocationManager.currentLongitude;
    
    MKCoordinateRegion region ;  // = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = douLatitude;
    region.center.longitude = douLongitude;
    
    region.span.longitudeDelta = 0.05f;
    region.span.latitudeDelta = 0.05f;
    
    [self.objLocationMap setRegion:region animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = region.center;;
    point.title = [NSString stringWithFormat:@"%@, %@",  appDelegate.objLocationManager.strName, appDelegate.objLocationManager.strThoroughFare];
    //point.subtitle = [NSString stringWithFormat:@"%@, %@",  appDelegate.objLocationManager.strLocality, appDelegate.objLocationManager.strAdministrativeArea];
    point.subtitle = [NSString stringWithFormat:@"%@, %@, %@",  appDelegate.objLocationManager.strLocality, appDelegate.objLocationManager.strAdministrativeArea, appDelegate.objLocationManager.strPostCode];
    
    [self.objLocationMap addAnnotation:point];
    [self.objLocationMap selectAnnotation:point animated:NO];
    
    [point release];
}

#pragma mark - Observer
-(void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.view.window];
}
-(void)removeAddedObserver
{
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"applicationDidBecomeActive" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:self.view.window];
}
#pragma mark keyboard Show/Hide Methods
- (void)keyboardWillShow:(NSNotification *)notif
{
    [_scrollViewMain setFrame:CGRectMake(_scrollViewMain.frame.origin.x, _scrollViewMain.frame.origin.y, _scrollViewMain.frame.size.width, kSCROLL_HEIGHT_DISPLAY-kOFFSET_FOR_KEYBOARD)];
    [_scrollViewMain setContentSize:CGSizeMake(_scrollViewMain.frame.size.width, kSCROLL_HEIGHT_DEFAULT)];
    [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
}
- (void)keyboardWillHide:(NSNotification *)notif
{
    [_scrollViewMain setFrame:CGRectMake(_scrollViewMain.frame.origin.x, _scrollViewMain.frame.origin.y, _scrollViewMain.frame.size.width, kSCROLL_HEIGHT_DISPLAY)];
    _scrollViewMain.contentSize=CGSizeMake(_scrollViewMain.frame.size.width, kSCROLL_HEIGHT_DEFAULT);
    [_scrollViewMain setContentOffset:CGPointMake(0.0, 0.0)];
}

#pragma mark - Validate Current GPS PostCode
-(void)validateCurrentGPSPostCode{
    NSString *pstrPostCode = appDelegate.objLocationManager.strPostCode;
    //pstrPostCode = @"EC1A 1BB";
    
    if(![pstrPostCode isEmptyString])
    {
        [FunctionManager displayLoadingView:self.view withMessage:msgLoadingGeneral appDelegate:appDelegate viewController:self];
        
        NSString *strPostCodeUrl = g_WebserviceUrlPostCodeValidate;
        strPostCodeUrl = [NSString stringWithFormat:strPostCodeUrl,g_PostCode_ApiKey,pstrPostCode];
        strPostCodeUrl = [strPostCodeUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *baseURL = [NSURL URLWithString:strPostCodeUrl];
        
        //iOS6 & Above = AFHTTPRequestOperationManager
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
        //manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
                
        [manager GET:g_Pagename_Api parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
            
            //NSLog(@"JSON: %@", responseObject);
            NSLog(@"%@", operation.responseString);
            if([[operation.responseString uppercaseString] isEqualToString:@"TRUE"])
                [self addUserAddress:2];
            else
                [FunctionManager showMessage:@"" withMessage:msgNoAddressFound withDelegage:nil];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
            
            NSLog(@"%@", operation.responseString);
            if([[operation.responseString uppercaseString] isEqualToString:@"TRUE"])
                [self addUserAddress:2];
            else
                [FunctionManager showMessage:@"" withMessage:msgNoAddressFound withDelegage:nil];
                
            //[FunctionManager showMessage:@"" withMessage:[error localizedDescription] withDelegage:nil];
        }];
    }
    else
        [FunctionManager showMessage:@"" withMessage:msgPostcodeNotFound withDelegage:nil];
}

#pragma mark - Address from PostCode
-(void)fetchAddressFromPostCode:(NSString *)pstrPostCode{
    pstrPostCode = _txtPostcode.text;
    
    if(![pstrPostCode isEmptyString])
    {
        [FunctionManager displayLoadingView:self.view withMessage:msgLoadingGeneral appDelegate:appDelegate viewController:self];
        
        NSString *strPostCodeUrl = g_WebserviceUrlPostCode;
        strPostCodeUrl = [NSString stringWithFormat:strPostCodeUrl,g_PostCode_ApiKey,pstrPostCode];
        strPostCodeUrl = [strPostCodeUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *baseURL = [NSURL URLWithString:strPostCodeUrl];
        
        //NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        //parameters[@"method"] = @"signup";
        
        //iOS6 & Above = AFHTTPRequestOperationManager
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        
        [manager GET:g_Pagename_Api parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
            
            //NSLog(@"JSON: %@", responseObject);
            [self checkPostCodeResponse:(NSArray *)responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
            [FunctionManager showMessage:@"" withMessage:[error localizedDescription] withDelegage:nil];
        }];
        
        /*
         [manager POST:g_Pagename_Api parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
         
            //NSLog(@"JSON: %@", responseObject);
            [self checkPostCodeResponse:(NSArray *)responseObject];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
            [FunctionManager showMessage:@"" withMessage:[error localizedDescription] withDelegage:nil];
         }];
         */
    }
}
-(void)checkPostCodeResponse:(NSArray *)parrResponse{
    [self resignOtherControl];
    
    self.arrAddress = [NSMutableArray arrayWithArray:parrResponse];
    if(self.arrAddress.count > 0)
    {
        [_tblAddress reloadData];
        [self displayAllAddresses];
    }
    else{
        _txtNewAddress.text = @"";
        _txtCity.text = @"";
        _txtPostcode.text = @"";
        [FunctionManager showMessage:@"" withMessage:msgNoAddressFound withDelegage:nil];
    }
    
    
    /*
    if(parrResponse.count > 0)
    {
        NSDictionary *dicAddr = (NSDictionary*)[parrResponse objectAtIndex:0];
        _txtNewAddress.text = [NSString stringWithFormat:@"%@", (NSString*)[dicAddr objectForKey:@"summaryline"]];
        _txtCity.text = [NSString stringWithFormat:@"%@, %@", (NSString*)[dicAddr objectForKey:@"posttown"], (NSString*)[dicAddr objectForKey:@"county"]];
        
        //_txtNewAddress.text = [NSString stringWithFormat:@"%@, %@", (NSString*)[dicAddr objectForKey:@"summaryline"], (NSString*)[dicAddr objectForKey:@"street"]];
        //_txtCity.text = [NSString stringWithFormat:@"%@, %@", (NSString*)[dicAddr objectForKey:@"posttown"], (NSString*)[dicAddr objectForKey:@"county"]];
    }
    else{
        _txtNewAddress.text = @"";
        _txtCity.text = @"";
        _txtPostcode.text = @"";
        [FunctionManager showMessage:@"" withMessage:msgNoAddressFound withDelegage:nil];
    }*/
}
#pragma mark Display All Addresses
-(void)setAddressView{
    //self.viewAddresses.layer.borderColor = [UIColor colorWithRed:99.0/255.0 green:95.0/255.0 blue:103.0/255.0 alpha:1.0].CGColor;
    self.viewAddresses.layer.borderColor = [UIColor colorWithRed:147.0/255.0 green:88.0/255.0 blue:67.0/255.0 alpha:1.0].CGColor;
    self.viewAddresses.layer.borderWidth = 3.0f;
    [self.view addSubview:self.viewAddresses];
    [self.viewAddresses setHidden:TRUE];
    
    //[self displayAllAddresses];
}
-(void)displayAllAddresses{
    [KGModal sharedInstance].showCloseButton = TRUE;    
    self.viewAddresses.hidden = NO;
    [[KGModal sharedInstance] showWithContentView:self.viewAddresses andAnimated:YES];
}

#pragma mark UITableView Delegete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrAddress.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }    
    NSDictionary *dicAddr = (NSDictionary*)[self.arrAddress objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", (NSString*)[dicAddr objectForKey:@"summaryline"]];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12.0];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dicAddr = (NSDictionary*)[self.arrAddress objectAtIndex:indexPath.row];
    _txtNewAddress.text = [NSString stringWithFormat:@"%@", (NSString*)[dicAddr objectForKey:@"summaryline"]];
    _txtCity.text = [NSString stringWithFormat:@"%@, %@", (NSString*)[dicAddr objectForKey:@"posttown"], (NSString*)[dicAddr objectForKey:@"county"]];
    
    [[KGModal sharedInstance] closeAction:nil];
}

#pragma mark - Button Tapped Add Address
#pragma mark Reset Data
-(IBAction)resetData:(id)sender
{
    _txtPostcode.text = @"";
    _txtCity.text = @"";
    _txtNewAddress.text = @"";
    _txtNewAddress.placeholderText = kPlaceholder_Address;
}
#pragma mark Resign Responder
-(void)resignOtherControl{
    [_txtPostcode resignFirstResponder];
    [_txtCity resignFirstResponder];
    [_txtNewAddress resignFirstResponder];
}

#pragma mark Check Entered Data
-(BOOL)checkEnteredData{
    if ([_txtPostcode.text isEmptyString]) {
        [FunctionManager showMessage:@"" withMessage:msgEnterPostcode withDelegage:nil];
        return FALSE;
    }
    else if ([_txtCity.text isEmptyString]) {
        [FunctionManager showMessage:@"" withMessage:msgEnterCity withDelegage:nil];
        return FALSE;
    }
    else if ([_txtNewAddress.text isEmptyString]) {
        [FunctionManager showMessage:@"" withMessage:msgEnterAddress withDelegage:nil];
        return FALSE;
    }
    else {
    }
    return TRUE;
}
#pragma mark Add Address
-(IBAction)btnTappedAddAddress:(id)sender
{
    switch ([sender tag]) {
        case 1: //My Home
        {
            [self resignOtherControl];
            [self addUserAddress:[sender tag]];
        }
            break;
        case 2: //Current
        {
            if ([appDelegate.objLocationManager.strPostCode isEmptyString]) {
                [FunctionManager showMessage:@"" withMessage:msgPostcodeNotFound withDelegage:nil];
            }
            else{
                [self resignOtherControl];
                [self validateCurrentGPSPostCode];
                //[self addUserAddress:[sender tag]];
            }
        }
            break;
        case 3: //Custom
        {
            if([self checkEnteredData]) {
                [self resignOtherControl];
                [self addUserAddress:[sender tag]];
            }
        }
            break;
        default:
        {
            [self resignOtherControl];
            [self addUserAddress:[sender tag]];
        }
            break;
    }
}
#pragma mark Add Address
-(void)addUserAddress:(NSInteger)pintAddressType{
    [FunctionManager displayLoadingView:self.view withMessage:msgLoadingGeneral appDelegate:appDelegate viewController:self];
     
    NSURL *baseURL = [NSURL URLWithString:g_WebserviceUrl];
     
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"method"] = @"getAddress";
     
    parameters[@"userid"] = [NSString stringWithFormat:@"%d", appDelegate.objUser.intUserID];
    //parameters[@"address_id"] = @"0";
    
    parameters[@"mobile"] = appDelegate.objUser.strMobile;
    
    switch (pintAddressType) {
        case 1: //My Home
        {
            parameters[@"address_type"] = @"home";
            parameters[@"address_id"] = [NSString stringWithFormat:@"%d", appDelegate.objUser.intAddressId];
            parameters[@"address"] = appDelegate.objUser.strAddress;
            parameters[@"city"] = appDelegate.objUser.strCity;
            parameters[@"postcode"] = appDelegate.objUser.strPostcode;
        }
            break;
        case 2: //Current
        {
            parameters[@"address_type"] = @"current";
            parameters[@"address_id"] = [NSString stringWithFormat:@"%d", appDelegate.objUser.intAddressIdCurr];
            parameters[@"address"] = appDelegate.strCurrentAddress;
            parameters[@"city"] = appDelegate.objLocationManager.strCountry;
            parameters[@"postcode"] = appDelegate.objLocationManager.strPostCode;
        }
            break;
        case 3: //Custom
        {
            parameters[@"address_type"] = @"custom";
            parameters[@"address_id"] = [NSString stringWithFormat:@"%d", appDelegate.objUser.intAddressIdCustom];
            parameters[@"address"] = _txtNewAddress.text;
            parameters[@"city"] = _txtCity.text;
            parameters[@"postcode"] = _txtPostcode.text;
        }
            break;
        default:
        {
            parameters[@"address_type"] = @"home";
            parameters[@"address_id"] = [NSString stringWithFormat:@"%d", appDelegate.objUser.intAddressId];
            parameters[@"address"] = appDelegate.objUser.strAddress;
            parameters[@"city"] = appDelegate.objUser.strCity;
            parameters[@"postcode"] = appDelegate.objUser.strPostcode;
        }
            break;
    }
    
     
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:g_Pagename_Api parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        
        //NSLog(@"JSON: %@", responseObject);
        //[self checkAddAddressResponse:(NSDictionary *)responseObject];
        [self checkAddAddressResponse:(NSDictionary *)responseObject withAddressType:pintAddressType];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Address Response = %@", operation.responseString);
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        [FunctionManager showMessage:@"" withMessage:[error localizedDescription] withDelegage:nil];
    }];
}
-(void)checkAddAddressResponse:(NSDictionary *)pdicResponse withAddressType:(NSInteger)pintAddressType{
    int success = [[pdicResponse objectForKey:@"status"] intValue];
    
    if(success)
    {
        NSArray *arrAddr = (NSArray*)[pdicResponse objectForKey:@"data"];
        NSDictionary *dicAddr = (NSDictionary*)[arrAddr objectAtIndex:0];
        NSString *strId = (NSString*)[dicAddr objectForKey:@"AddressId"];
        //NSLog(@"%@", strId);
        
        
        switch (pintAddressType) {
            case 1: //My Home
            {
                appDelegate.objUser.strAddressType = @"home";
                appDelegate.objUser.intAddressId = [strId intValue];
                appDelegate.objUser.strAddress = appDelegate.objUser.strAddress;
                appDelegate.objUser.strCity = appDelegate.objUser.strCity;
                appDelegate.objUser.strPostcode = appDelegate.objUser.strPostcode;
                
                appDelegate.objUser.strDeliveryAddress = appDelegate.objUser.strAddress;
                appDelegate.objUser.strDeliveryCity = appDelegate.objUser.strCity;
                appDelegate.objUser.strDeliveryPostcode = appDelegate.objUser.strPostcode;
            }
                break;
            case 2: //Current
            {
                appDelegate.objUser.strAddressType = @"current";
                appDelegate.objUser.intAddressIdCurr = [strId intValue];
                appDelegate.objUser.strAddressCurr = appDelegate.strCurrentAddress;
                appDelegate.objUser.strCityCurr = appDelegate.objLocationManager.strCountry;
                appDelegate.objUser.strPostcodeCurr = appDelegate.objLocationManager.strPostCode;
                
                appDelegate.objUser.strDeliveryAddress = appDelegate.strCurrentAddress;
                appDelegate.objUser.strDeliveryCity = appDelegate.objLocationManager.strCountry;
                appDelegate.objUser.strDeliveryPostcode = appDelegate.objLocationManager.strPostCode;
            }
                break;
            case 3: //Custom
            {
                appDelegate.objUser.strAddressType = @"custom";
                appDelegate.objUser.intAddressIdCustom = [strId intValue];
                appDelegate.objUser.strAddressCustom = _txtNewAddress.text;
                appDelegate.objUser.strCityCustom = _txtCity.text;
                appDelegate.objUser.strPostcodeCustom = _txtPostcode.text;
                
                appDelegate.objUser.strDeliveryAddress = _txtNewAddress.text;
                appDelegate.objUser.strDeliveryCity = _txtCity.text;
                appDelegate.objUser.strDeliveryPostcode = _txtPostcode.text;
            }
                break;
        }
        
        
        [self openCategoryPage];
    }
    else
        [FunctionManager showMessage:@"" withMessage:[pdicResponse objectForKey:@"message"] withDelegage:nil];
}

-(void)openCategoryPage{
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
    
    
    
    /*
    HomeViewController *objHomeViewController;
    objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil] autorelease];
    
    
//    if(g_IS_IPHONE_6PLUS_SCREEN)
//        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController6P" bundle:nil] autorelease];
//    else if(g_IS_IPHONE_6_SCREEN)
//        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController6" bundle:nil] autorelease];
//    else if(g_IS_IPHONE_5_SCREEN)
//        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil] autorelease];
//    else if(g_IS_IPHONE_4_SCREEN)
//        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController4" bundle:nil] autorelease];
//    //else if(g_IS_IPAD)
//        //objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewControlleriPad" bundle:nil] autorelease];
//    else
//        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController4" bundle:nil] autorelease];
    
    
    //objHomeViewController.imgPhotoPreview = imgPhotoToShare;
    [self.navigationController pushViewController:objHomeViewController animated:YES];
    */
}

#pragma mark - Reset Timer
-(void)resetTimer{
    //[autoTimer invalidate];
    //autoTimer = nil;
}
#pragma mark - Control Delegate
#pragma mark TextField Delegate Methods
- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    if(textField==_txtPostcode){
        autoTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                     target:self
                                                   selector:@selector(fetchAddressFromPostCode:)
                                                   userInfo:nil
                                                    repeats:NO];
    }
    
//    if(textField==_txtPostcode)
//        [self fetchAddressFromPostCode:_txtPostcode.text];
    
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //NSLog(@"%f", _scrollViewMain.contentOffset.y);
    /*
    if(textField==_txtPostcode)
    {
        NSCharacterSet *unacceptedInput = nil;
        unacceptedInput = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
        if([[string componentsSeparatedByCharactersInSet:unacceptedInput] count] <= 1)
            return YES;
        else
            return NO;
    }
    else
        return YES;
    */
    
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //[self resignOtherControl];
    
    if(textField==_txtPostcode)
    {
        intCurrentInputID = kTag_PostCode;
        
        if(_scrollViewMain.contentOffset.y>kPosition_PostCode)
            fltPageScl = _scrollViewMain.contentOffset.y;
        else
            fltPageScl = kPosition_PostCode;
        
        [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
    }
    else if(textField==_txtCity)
    {
        intCurrentInputID = kTag_City;
        
        if(_scrollViewMain.contentOffset.y>kPosition_City)
            fltPageScl = _scrollViewMain.contentOffset.y;
        else
            fltPageScl = kPosition_City;
        
        [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
    }
    
    return YES;
}
#pragma mark TextView Delegate Methods
- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    //_txtFeedback.placeholder = kPlaceholder_Message;
    
    /*
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }else{
        return YES;
    }
    */
    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    [_txtNewAddress textChanged:nil];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    intCurrentInputID = kTag_Address;
    
    if(_scrollViewMain.contentOffset.y>kPosition_Address)
        fltPageScl = _scrollViewMain.contentOffset.y;
    else
        fltPageScl = kPosition_Address;
    
    //fltPageScl = 0.0;
    //fltPageScl = _scrollViewMain.contentOffset.y;
    [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
    
    return YES;
}

#pragma mark - Keyboard Toolbox Button Tapped
-(IBAction)btnTappedDone:(id)sender
{
    [self resignOtherControl];
    fltPageScl = kPosition_Bottom;
    [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
}
-(IBAction)btnTappedClose:(id)sender
{
    fltPageScl = 0.0;
    [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
}
-(IBAction)btnTappedNext:(id)sender
{
    if(intCurrentInputID==kTag_Address)
    {
        [self resignOtherControl];
        fltPageScl = kPosition_Bottom;
        [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
    }
    else {
        intCurrentInputID = intCurrentInputID+1;
        //[self checkCurrentInputIDandPerformAction];
    }
}
-(IBAction)btnTappedPrev:(id)sender
{
    if(intCurrentInputID==kPosition_PostCode)
    {
        [self resignOtherControl];
        fltPageScl = kPosition_PostCode;
        [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
    }
    else {
        intCurrentInputID = intCurrentInputID-1;
        //[self checkCurrentInputIDandPerformAction];
    }
}

#pragma mark - Button Tapped Back
-(IBAction)btnTappedBack:(id)sender{
    [FunctionManager gotoBack:self];
}

#pragma mark - Button Tapped Menu
#pragma mark Set Menu
-(void)setMenu{
    _viewMenu = [[[NSBundle mainBundle] loadNibNamed:@"MenuView" owner:self options:nil]objectAtIndex:0];
    
    [_viewMenu setFrame:CGRectMake(self.view.frame.size.width-(_viewMenu.frame.size.width+10.0), 50.0, _viewMenu.frame.size.width, _viewMenu.frame.size.height)];
    [_viewMenu setParent:self appDelegate:appDelegate viewController:self];
    _viewMenu.layer.borderColor = [UIColor clearColor].CGColor;
    _viewMenu.layer.borderWidth = 3.0f;
    [self.view addSubview:_viewMenu];
    [_viewMenu setHidden:TRUE];
}
#pragma mark Open/Close Menu
-(IBAction)btnTappedMenu:(id)sender{
//    if(_viewMenu)
//        [_viewMenu release];
    [self setMenu];
    
    [KGModal sharedInstance].showCloseButton = FALSE;    
    _viewMenu.hidden = NO;
    [[KGModal sharedInstance] showWithContentView:_viewMenu andAnimated:YES];
}
-(void)closeMenu{
    [[KGModal sharedInstance] closeAction:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Orientations
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_txtPostcode release];
    [_txtCity release];
    [_txtNewAddress release];
    [self.viewAddresses release];
    [_tblAddress release];
    
    [self.objLocationMap release];
    [_txtCurrAddress release];
    
    [_viewInput release];
    [_scrollViewMain release];
    
    //[_viewMenu release];
    
    [super dealloc];
}

@end
