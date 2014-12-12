//
//  RegistrationViewController.m
//  TrueLocation
//
//  Created by WebInfoways on 28/05/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "SignUpViewController.h"

#define kOFFSET_FOR_KEYBOARD            166.0       //256.0   //216.0
//#define kSCROLL_DISPLAY_Y               ((g_IS_IPHONE_5_SCREEN) ? ((g_IS_iOS7) ? 64.0 : 64.0) : ((g_IS_iOS7) ? 64.0 : 64.0))
#define kSCROLL_DISPLAY_Y               ((g_IS_IPHONE_5_SCREEN) ? ((g_IS_iOS7) ? 100.0 : 100.0) : ((g_IS_iOS7) ? 100.0 : 100.0))
#define kSCROLL_HEIGHT_DISPLAY          ((g_IS_IPHONE_5_SCREEN) ? ((g_IS_iOS7) ? 504.0 : 504.0) : ((g_IS_iOS7) ? 504.0 : 504.0))
#define kSCROLL_HEIGHT_DEFAULT          ((g_IS_IPHONE_5_SCREEN) ? ((g_IS_iOS7) ? 504.0 : 504.0) : ((g_IS_iOS7) ? 504.0 : 504.0))

#define kTag_Title              1
#define kTag_FirstName          2
#define kTag_LastName           3
#define kTag_Postcode           4
#define kTag_City               5
#define kTag_Address            6
#define kTag_Mobile             7
#define kTag_Username           8
#define kTag_Birthday           9

#define kPosition_Title             ((g_IS_IPHONE_5_SCREEN) ? 0.0 : 0.0)
#define kPosition_FirstName         ((g_IS_IPHONE_5_SCREEN) ? 0.0 : 0.0)
#define kPosition_LastName          ((g_IS_IPHONE_5_SCREEN) ? 0.0 : 0.0)
#define kPosition_Postcode          ((g_IS_IPHONE_5_SCREEN) ? 0.0 : 0.0)
#define kPosition_City              ((g_IS_IPHONE_5_SCREEN) ? 0.0 : 0.0)
#define kPosition_Address           ((g_IS_IPHONE_5_SCREEN) ? 0.0 : 0.0)
#define kPosition_Mobile            ((g_IS_IPHONE_5_SCREEN) ? 35.0 : 35.0)
#define kPosition_Username          ((g_IS_IPHONE_5_SCREEN) ? 75.0 : 75.0)
#define kPosition_Birthday          ((g_IS_IPHONE_5_SCREEN) ? 115.0 : 115.0)

#define kPosition_Bottom            ((g_IS_IPHONE_5_SCREEN) ? 0.0 : 0.0)		//kSCROLL_HEIGHT_DEFAULT - kSCROLL_HEIGHT_DISPLAY

#define kPlaceholder_Title          @"Title"
#define kPlaceholder_Address        @"Address"
#define kPlaceholder_BirthDate      @"Select Date of Birth"

/*
#define kPosition_Title             ((g_IS_IPHONE_5_SCREEN) ? 0.0 : 0.0)
#define kPosition_FirstName         ((g_IS_IPHONE_5_SCREEN) ? 0.0 : 30.0)
#define kPosition_LastName          ((g_IS_IPHONE_5_SCREEN) ? 0.0 : 65.0)
#define kPosition_Address           ((g_IS_IPHONE_5_SCREEN) ? 190.0 : 275.0)
#define kPosition_City              ((g_IS_IPHONE_5_SCREEN) ? 225.0 : 310.0)
#define kPosition_Postcode          ((g_IS_IPHONE_5_SCREEN) ? 330.0 : 415.0)
#define kPosition_Username          ((g_IS_IPHONE_5_SCREEN) ? 15.0 : 100.0)
#define kPosition_Birthday          ((g_IS_IPHONE_5_SCREEN) ? 50.0 : 135.0)

#define kPosition_Bottom            ((g_IS_IPHONE_5_SCREEN) ? 0.0 : 0.0)		//kSCROLL_HEIGHT_DEFAULT - kSCROLL_HEIGHT_DISPLAY
*/

@interface SignUpViewController ()

@end

@implementation SignUpViewController

@synthesize intRecordAddedId;
@synthesize objUser;
@synthesize arrTitle;
@synthesize strBirthDate;
@synthesize viewAddresses;

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
    [self setInitialParameter];
}
- (void)viewWillAppear:(BOOL)animated{
	[self addObserver];
}
- (void)viewWillDisappear:(BOOL)animated{
    [self resetTimer];
}
- (void)viewDidDisappear:(BOOL)animated{
	[self removeAddedObserver];
}

#pragma mark - Initial Parameter
-(void)setInitialParameter
{
    [FunctionManager setDefaultTableViewStyle:_tblAddress delegate:self];
    _tblAddress.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self setAddressView];
    
    [self bindDefaultData];
    
    [_txtTitle addTarget:self action:@selector(textFieldDidChangeCountry) forControlEvents:UIControlEventEditingChanged];
    
	_txtFirstName.inputAccessoryView = _viewInput;
	_txtLastName.inputAccessoryView = _viewInput;
    _txtPostcode.inputAccessoryView = _viewInput;
    _txtCity.inputAccessoryView = _viewInput;
    _txtAddress.inputAccessoryView = _viewInput;
    _txtMobile.inputAccessoryView = _viewInput;
    _txtUsername.inputAccessoryView = _viewInput;
	
    _txtAddress.font=[UIFont fontWithName:g_Font_Name_Default_Control size:g_Font_Size_Default_Control];
    [_txtAddress setPlaceholderColor:[UIColor lightGrayColor]];
    
    _txtAddress.text = @"";
    _txtAddress.placeholderText = kPlaceholder_Address;
    
    
	_scrollViewMain.scrollEnabled=YES;
    [_scrollViewMain setFrame:CGRectMake(0.0, kSCROLL_DISPLAY_Y, _scrollViewMain.frame.size.width, kSCROLL_HEIGHT_DISPLAY)];
	[_scrollViewMain setContentSize:CGSizeMake(_scrollViewMain.frame.size.width, kSCROLL_HEIGHT_DEFAULT)];
	//[_scrollViewMain setContentOffset:CGPointMake(0.0, kPosition_Quantity)];
    [_scrollViewMain setContentOffset:CGPointMake(0.0, 0.0)];
	
	[self.view addSubview:_scrollViewMain];
    
    [self resetData:nil];
}
#pragma mark Bind Default Data
-(void)bindDefaultData
{
    self.arrTitle = [[NSMutableArray alloc] init];
    
    [self.arrTitle addObject:kPlaceholder_Title];
    [self.arrTitle addObject:@"Mr"];
    [self.arrTitle addObject:@"Mrs"];
    [self.arrTitle addObject:@"Miss"];
}
#pragma mark Set Default Country Data
-(void)textFieldDidChangeCountry
{
    if ([_txtTitle.text isEmptyString])
        _txtTitle.text = @"Mr";
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
	[_scrollViewMain setContentOffset:CGPointMake(0.0, kPosition_Title)];
}

#pragma mark - Terms & Conditions
-(IBAction)btnTappedReviewTermsCondition:(id)sender{
    TermsViewController *objTermsViewController;
    objTermsViewController = [[[TermsViewController alloc] initWithNibName:@"TermsViewController" bundle:nil] autorelease];
    
    /*
    if(g_IS_IPHONE_6PLUS_SCREEN)
        objTermsViewController = [[[TermsViewController alloc] initWithNibName:@"TermsViewController6P" bundle:nil] autorelease];
    else if(g_IS_IPHONE_6_SCREEN)
        objTermsViewController = [[[TermsViewController alloc] initWithNibName:@"TermsViewController6" bundle:nil] autorelease];
    else if(g_IS_IPHONE_5_SCREEN)
        objTermsViewController = [[[TermsViewController alloc] initWithNibName:@"TermsViewController" bundle:nil] autorelease];
    else if(g_IS_IPHONE_4_SCREEN)
        objTermsViewController = [[[TermsViewController alloc] initWithNibName:@"TermsViewController4" bundle:nil] autorelease];
    //else if(g_IS_IPAD)
        //objTermsViewController = [[[TermsViewController alloc] initWithNibName:@"TermsViewControlleriPad" bundle:nil] autorelease];
    else
        objTermsViewController = [[[TermsViewController alloc] initWithNibName:@"TermsViewController4" bundle:nil] autorelease];
    */
    
    objTermsViewController.strPageTitle = g_Content_TermsTitle;
    objTermsViewController.strPageUrl = g_Content_TermsUrl;
    
    [self.navigationController pushViewController:objTermsViewController animated:YES];
    
    
    /*
    TextContentViewController *objTextContentViewController;
    objTextContentViewController = [[[TextContentViewController alloc] initWithNibName:@"TextContentViewController" bundle:nil] autorelease];
    
    
//    if(g_IS_IPHONE_6PLUS_SCREEN)
//        objTextContentViewController = [[[TextContentViewController alloc] initWithNibName:@"TextContentViewController6P" bundle:nil] autorelease];
//    else if(g_IS_IPHONE_6_SCREEN)
//        objTextContentViewController = [[[TextContentViewController alloc] initWithNibName:@"TextContentViewController6" bundle:nil] autorelease];
//    else if(g_IS_IPHONE_5_SCREEN)
//        objTextContentViewController = [[[TextContentViewController alloc] initWithNibName:@"TextContentViewController" bundle:nil] autorelease];
//    else if(g_IS_IPHONE_4_SCREEN)
//        objTextContentViewController = [[[TextContentViewController alloc] initWithNibName:@"TextContentViewController4" bundle:nil] autorelease];
//    //else if(g_IS_IPAD)
//        //objTextContentViewController = [[[TextContentViewController alloc] initWithNibName:@"TextContentViewControlleriPad" bundle:nil] autorelease];
//    else
//        objTextContentViewController = [[[TextContentViewController alloc] initWithNibName:@"TextContentViewController4" bundle:nil] autorelease];
    
    
    objTextContentViewController.strPageTitle = g_Content_TermsTitle;
    objTextContentViewController.strPageUrl = g_Content_TermsUrl;
    
    [self.navigationController pushViewController:objTextContentViewController animated:YES];
     */
}
-(IBAction)btnTappedCheckTermsCondition:(id)sender{
    if ([_chkTermsCondition.imageView.image isEqual:[UIImage imageNamed:@"chkOn.png"]]) {
        [_chkTermsCondition setImage:[UIImage imageNamed:@"chkOff.png"] forState:UIControlStateNormal];
    }
    else {
        [_chkTermsCondition setImage:[UIImage imageNamed:@"chkOn.png"] forState:UIControlStateNormal];
    }
}

#pragma mark - Select Options
-(IBAction)btnTappedOption:(id)sender
{
	[self resignOtherControl];
	
	intCurrentInputID = [sender tag];
    
    PickerVC *objPickerController;
    switch ([sender tag]) {
		case kTag_Title:
            fltPageScl = kPosition_Title;
            objPickerController = [[PickerVC alloc] initWithNibNameAndData:self.arrTitle withSelectedID:intTitleIndex withID:self withButtonTag:intCurrentInputID];
			break;
            /*
        case kTag_Postcode:
            fltPageScl = kPosition_Postcode;
            objPickerController = [[PickerVC alloc] initWithNibNameAndData:appDelegate.arrPostCode withSelectedID:intPostCodeIndex withID:self withButtonTag:intCurrentInputID];
            break;*/
		default:
            fltPageScl = kPosition_Title;
            objPickerController = [[PickerVC alloc] initWithNibNameAndData:self.arrTitle withSelectedID:intTitleIndex withID:self withButtonTag:intCurrentInputID];
			break;
	}
    [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
    
    objPickerController.delegate = self;
	[self.view addSubview:objPickerController.view];
    
	objPickerController.view.frame=CGRectMake(objPickerController.view.frame.origin.x, self.view.frame.size.height-objPickerController.view.frame.size.height, objPickerController.view.frame.size.width, objPickerController.view.frame.size.height);
    //[objPickerController release];
}
-(void)onChange:(int)pintIndexNo withValue:(NSString *)pstrValue withInputTagId:(int)pintTag
{
    //NSLog(@"IndexNo= %d, Value= %@", pintIndexNo, pstrValue);
    
    if(pintTag==kTag_Title)
	{
		intTitleIndex = pintIndexNo;
        _txtTitle.text = pstrValue;
        _lblTitle.text = pstrValue;
        [_btnTitle setTitle:pstrValue forState:UIControlStateNormal];
	}
    /*
    else if(pintTag==kTag_Postcode)
    {
        intPostCodeIndex = pintIndexNo;
        [_btnPostCode setTitle:pstrValue forState:UIControlStateNormal];
        
        if (![pstrValue isEqualToString:kPlaceholder_PostCode] && ![_btnPostCode.titleLabel.text isEmptyString]){
            [self fetchAddressFromPostCode:pstrValue];
        }
    }*/
}
#pragma mark - Address from PostCode
-(void)fetchAddressFromPostCode:(NSString *)pstrPostCode{
    [self resignOtherControl];
    
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
    self.arrAddress = [NSMutableArray arrayWithArray:parrResponse];
    if(self.arrAddress.count > 0)
    {
        [_tblAddress reloadData];
        [self displayAllAddresses];
    }
    else{
        _txtAddress.text = @"";
        _txtCity.text = @"";
        _txtPostcode.text = @"";
        [FunctionManager showMessage:@"" withMessage:msgNoAddressFound withDelegage:nil];
    }
    
    /*
    if(parrResponse.count > 0)
    {
        NSDictionary *dicAddr = (NSDictionary*)[parrResponse objectAtIndex:0];
        _txtAddress.text = [NSString stringWithFormat:@"%@, %@", (NSString*)[dicAddr objectForKey:@"summaryline"], (NSString*)[dicAddr objectForKey:@"street"]];
        _txtCity.text = [NSString stringWithFormat:@"%@, %@", (NSString*)[dicAddr objectForKey:@"posttown"], (NSString*)[dicAddr objectForKey:@"county"]];
    }
    else{
        _txtAddress.text = @"";
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
    _txtAddress.text = [NSString stringWithFormat:@"%@", (NSString*)[dicAddr objectForKey:@"summaryline"]];
    _txtCity.text = [NSString stringWithFormat:@"%@, %@", (NSString*)[dicAddr objectForKey:@"posttown"], (NSString*)[dicAddr objectForKey:@"county"]];
    
    [[KGModal sharedInstance] closeAction:nil];
}

#pragma mark - Select BirthDate
-(IBAction)btnTappedBirthday:(UIButton*)sender{
    intCurrentInputID = kTag_Birthday;
    
    if(_scrollViewMain.contentOffset.y>kPosition_Birthday)
        fltPageScl = _scrollViewMain.contentOffset.y;
    else
        fltPageScl = kPosition_Birthday;
    
    [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
    
    
    DatePickerVC *objDatePickerVC;
    objDatePickerVC = [[DatePickerVC alloc] initWithNibNameAndData:self.strBirthDate withDateFormat:g_DateTimeFormatDefault withDateDisplayFormat:g_DateFormatDisplay2 withID:self withPickerOptionID:1 withButtonTag:[sender tag]];
    objDatePickerVC.delegate = self;
    [self.view addSubview:objDatePickerVC.view];
    objDatePickerVC.view.frame=CGRectMake(objDatePickerVC.view.frame.origin.x, self.view.frame.size.height-objDatePickerVC.view.frame.size.height, objDatePickerVC.view.frame.size.width, objDatePickerVC.view.frame.size.height);
    //[objPickerController release];
}
-(void)onSelect:(int)pintPickerOptionId withDate:(NSDate *)pdtSelectedDate
{
    if([self checkAgeVerification:pdtSelectedDate]){
        [self removeDatePicker];
        
        self.strBirthDate = [FunctionManager getFormatedDate:[pdtSelectedDate description] withDateFormat:g_DateTimeFormatDefaultZone withDisplayFormat:g_DateTimeFormatDefault];
        
        NSString *strBirthdateDisplayDt = [FunctionManager getFormatedDate:[pdtSelectedDate description] withDateFormat:g_DateTimeFormatDefaultZone withDisplayFormat:g_DateFormatDisplay2];
        [_btnBirthday setTitle:strBirthdateDisplayDt forState:UIControlStateNormal];
    }
}
#pragma mark Check BirthDate
-(BOOL)checkAgeVerification:(NSDate *)pdtSelectedDate
{
    NSDate *today = [NSDate date];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:pdtSelectedDate
                                       toDate:today
                                       options:0];
    //return ageComponents.year;
    if(ageComponents.year>=18)
        return TRUE;
    else{
        [FunctionManager showMessage:nil withMessage:msgVerifyAge withDelegage:nil];
        return FALSE;
    }
    
    /*
    NSDate *today = [NSDate date];
    NSDate *yesterday = [today dateByAddingTimeInterval: -86400.0];
    
    //if([[NSDate date] compare:pdtSelectedDate] == NSOrderedDescending) // if current date is later in time than passed date
    if([yesterday compare:pdtSelectedDate] == NSOrderedDescending) // if current date is later in time than passed date
    {
        [FunctionManager showMessage:nil withMessage:msgCAAppointmentDateFuture withDelegage:nil];
        return FALSE;
    }
    return TRUE;
     */
}

#pragma mark - Button Tapped SignUp
#pragma mark Reset Data
-(IBAction)resetData:(id)sender
{
    appDelegate.bolIsAcceptTerms = FALSE;
    
    intCurrentInputID = kTag_Title;
    
    intTitleIndex = 0;
    _txtTitle.text = kPlaceholder_Title;
    _lblTitle.text = kPlaceholder_Title;
    [_btnTitle setTitle:kPlaceholder_Title forState:UIControlStateNormal];
    
    //intPostCodeIndex = 0;
    //[_btnPostCode setTitle:kPlaceholder_PostCode forState:UIControlStateNormal];
    
    _txtFirstName.text = @"";
	_txtLastName.text = @"";
    _txtPostcode.text = @"";
    _txtCity.text = @"";
    _txtMobile.text = @"";
    _txtUsername.text = @"";
    
    _txtAddress.text = @"";
    _txtAddress.placeholderText = kPlaceholder_Address;
    
    self.strBirthDate = @"";
    [_btnBirthday setTitle:kPlaceholder_BirthDate forState:UIControlStateNormal];
    
    [_chkTermsCondition setImage:[UIImage imageNamed:@"chkOn.png"] forState:UIControlStateNormal];
    
    //_txtPostcode.text = appDelegate.objLocationManager.strPostCode;
}
#pragma mark Resign Responder
-(void)resignOtherControl{
	[_txtFirstName resignFirstResponder];
    [_txtLastName resignFirstResponder];
    [_txtPostcode resignFirstResponder];
    [_txtCity resignFirstResponder];
    [_txtAddress resignFirstResponder];
    [_txtMobile resignFirstResponder];
    [_txtUsername resignFirstResponder];
    
    [self removeOptionPicker];
    [self removeDatePicker];
}
-(void)removeOptionPicker{
    /*if([self.view.subviews containsObject:appDelegate.objPickerView])
        [appDelegate.objPickerView removeFromSuperview];*/
    
    /*
    for(int i=0;i<[self.view.subviews count];i++){
        //DLog(@"%@", [self.view.subviews objectAtIndex:i]);
        
        if ([[self.view.subviews objectAtIndex:i] isKindOfClass:[PickerView class]])
            [appDelegate.objPickerView removeFromSuperview];
    }*/
    
    for(int i=0;i<[self.view.subviews count];i++){
        //DLog(@"%@", [self.view.subviews objectAtIndex:i]);
        id nextResponder = [[self.view.subviews objectAtIndex:i] nextResponder];
        if ([nextResponder isKindOfClass:[PickerVC class]]) {
            [[self.view.subviews objectAtIndex:i] removeFromSuperview];
        }
    }
}
-(void)removeDatePicker{
    /*if([self.view.subviews containsObject:appDelegate.objPickerView])
        [appDelegate.objPickerView removeFromSuperview];*/
    
    /*
     for(int i=0;i<[self.view.subviews count];i++){
        //DLog(@"%@", [self.view.subviews objectAtIndex:i]);
     
        if ([[self.view.subviews objectAtIndex:i] isKindOfClass:[PickerView class]])
        [appDelegate.objPickerView removeFromSuperview];
     }*/
    for(int i=0;i<[self.view.subviews count];i++){
        //DLog(@"%@", [self.view.subviews objectAtIndex:i]);
        
        id nextResponder = [[self.view.subviews objectAtIndex:i] nextResponder];
        if ([nextResponder isKindOfClass:[DatePickerVC class]]) {
            [[self.view.subviews objectAtIndex:i] removeFromSuperview];
        }
    }
}

#pragma mark Check Entered Data
-(BOOL)checkEnteredData{
    if ([_btnTitle.titleLabel.text isEqualToString:kPlaceholder_Title] || [_btnTitle.titleLabel.text isEmptyString]){
        [FunctionManager showMessage:@"" withMessage:msgSelectTitle withDelegage:nil];
        return FALSE;
    }
    else if ([_txtFirstName.text isEmptyString]) {
		[FunctionManager showMessage:@"" withMessage:msgEnterFirstName withDelegage:nil];
		return FALSE;
	}
    else if ([_txtLastName.text isEmptyString]) {
		[FunctionManager showMessage:@"" withMessage:msgEnterLastName withDelegage:nil];
		return FALSE;
	}
    else if ([_txtPostcode.text isEmptyString]) {
        [FunctionManager showMessage:@"" withMessage:msgEnterPostcode withDelegage:nil];
        return FALSE;
    }
    /*
    else if ([_btnPostCode.titleLabel.text isEqualToString:kPlaceholder_PostCode] || [_btnPostCode.titleLabel.text isEmptyString]){
        [FunctionManager showMessage:@"" withMessage:msgSelectPostcode withDelegage:nil];
        return FALSE;
    }*/
    else if ([_txtCity.text isEmptyString]) {
        [FunctionManager showMessage:@"" withMessage:msgEnterCity withDelegage:nil];
        return FALSE;
    }
    else if ([_txtAddress.text isEmptyString]) {
        [FunctionManager showMessage:@"" withMessage:msgEnterAddress withDelegage:nil];
        return FALSE;
    }
    else if ([_txtMobile.text isEmptyString]) {
        [FunctionManager showMessage:@"" withMessage:msgEnterContact withDelegage:nil];
        return FALSE;
    }
    else if ([_txtUsername.text isEmptyString]) {
        [FunctionManager showMessage:@"" withMessage:msgEnterEmail withDelegage:nil];   //msgEnterUsername
        return FALSE;
    }
    else if(![_txtUsername.text isEmptyString] && ![_txtUsername.text isValidEmail]){
        [FunctionManager showMessage:nil withMessage:msgEnterValidEmail withDelegage:nil];
        return FALSE;
    }
    else if([self.strBirthDate isEmptyString]){
        [FunctionManager showMessage:nil withMessage:msgSelectBirthdate withDelegage:nil];
        return FALSE;
    }
    else if(!appDelegate.bolIsAcceptTerms){
        [FunctionManager showMessage:nil withMessage:msgAcceptTermsCondition withDelegage:nil];
        return FALSE;
    }
	else {
	}
	return TRUE;
}
#pragma mark SignUp
-(IBAction)btnTappedSignUp:(id)sender
{
    if([self checkEnteredData]) {
        [self resignOtherControl];
        [self signUpUser];
        //[self openAddressSelection];
	}
}
#pragma mark Register User
-(void)signUpUser{
    [FunctionManager displayLoadingView:self.view withMessage:msgLoadingGeneral appDelegate:appDelegate viewController:self];
    
    NSURL *baseURL = [NSURL URLWithString:g_WebserviceUrl];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"method"] = @"signup";
    
    NSString *strPostDOB = [FunctionManager getFormatedDate:self.strBirthDate withDateFormat:g_DateTimeFormatDefaultZone withDisplayFormat:g_DateFormatDefault];
    
    if ([_btnTitle.titleLabel.text isEqualToString:kPlaceholder_Title])
        parameters[@"title"] = @"";
    else
        parameters[@"title"] = _btnTitle.titleLabel.text;
    
    /*
    if ([_btnPostCode.titleLabel.text isEqualToString:kPlaceholder_PostCode])
        parameters[@"postcode"] = @"";
    else
        parameters[@"postcode"] = _btnPostCode.titleLabel.text;*/
    
    //parameters[@"title"] = @"";
    parameters[@"firstname"] = _txtFirstName.text;
    parameters[@"lastname"] = _txtLastName.text;
    parameters[@"postcode"] = _txtPostcode.text;
    parameters[@"city"] = _txtCity.text;
    parameters[@"address"] = _txtAddress.text;
    parameters[@"mobile"] = _txtMobile.text;
    parameters[@"email"] = _txtUsername.text;
    //parameters[@"password"] = @"123456";
    
    //parameters[@"dob"] = self.strBirthDate;
    parameters[@"dob"] = strPostDOB;
    
    //parameters[@"mobile_type"] = @"0";        //0=iOS, 1=Android
    
    //iOS6 & Above = AFHTTPRequestOperationManager
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:g_Pagename_Api parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        
        //NSLog(@"JSON: %@", responseObject);
        [self checkSignUpResponse:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        [FunctionManager showMessage:@"" withMessage:[error localizedDescription] withDelegage:nil];
    }];
}
-(void)checkSignUpResponse:(NSDictionary *)pdicResponse{
    //int success = [[pdicResponse objectForKey:@"status"] intValue];
    [FunctionManager showMessage:@"" withMessage:[pdicResponse objectForKey:@"message"] withDelegage:nil];
    [self btnTappedBack:nil];
    
    
    /*
    if(success)
    {
        //NSDictionary *data = (NSDictionary*)[pdicResponse objectForKey:@"data"];
        //NSString *strId = (NSString*)[data objectForKey:@"CustomerId"];
        //NSLog(@"%@", strId);
        
        NSArray *data = (NSArray*)[pdicResponse objectForKey:@"data"];
        NSDictionary *dicData = (NSDictionary*)[data objectAtIndex:0];
        NSString *strId = (NSString*)[dicData objectForKey:@"CustomerId"];
        //NSLog(@"%@", strId);
        
        
        //if ([_btnTitle.titleLabel.text isEqualToString:kPlaceholder_Title])
            //appDelegate.objUser.strTitle = @"";
        //else
            //appDelegate.objUser.strTitle = _btnTitle.titleLabel.text;
        
        
        appDelegate.objUser.intUserID = [strId intValue];
        appDelegate.objUser.strTitle = _btnTitle.titleLabel.text;
        appDelegate.objUser.strFirstname = _txtFirstName.text;
        appDelegate.objUser.strLastname = _txtLastName.text;
        appDelegate.objUser.strMobile = _txtMobile.text;
        
        appDelegate.objUser.strUsername = _txtUsername.text;
        appDelegate.objUser.strPassword = @"";
        
        appDelegate.objUser.strAddressType = @"home";
        appDelegate.objUser.intAddressId = 0;
        appDelegate.objUser.strAddress = _txtAddress.text;
        appDelegate.objUser.strCity = _txtCity.text;
        appDelegate.objUser.strPostcode = _txtPostcode.text;
        //appDelegate.objUser.strPostcode = _btnPostCode.titleLabel.text;
        
        appDelegate.objUser.strBirthdate = self.strBirthDate;
        
        appDelegate.objUser.strDeliveryAddress = _txtAddress.text;
        appDelegate.objUser.strDeliveryCity = _txtCity.text;
        appDelegate.objUser.strDeliveryPostcode = _txtPostcode.text;
        
        //[FunctionManager addUserToNSUserDefaults:appDelegate.objUser forKey:@"User"];
        
        [self openAddressSelection];
    }
    else
        [FunctionManager showMessage:@"" withMessage:[pdicResponse objectForKey:@"message"] withDelegage:nil];
    */
}
-(void)openAddressSelection{
    AddressViewController *objAddressViewController;
    objAddressViewController = [[[AddressViewController alloc] initWithNibName:@"AddressViewController" bundle:nil] autorelease];
    
    /*
    if(g_IS_IPHONE_6PLUS_SCREEN)
        objAddressViewController = [[[AddressViewController alloc] initWithNibName:@"AddressViewController6P" bundle:nil] autorelease];
    else if(g_IS_IPHONE_6_SCREEN)
        objAddressViewController = [[[AddressViewController alloc] initWithNibName:@"AddressViewController6" bundle:nil] autorelease];
    else if(g_IS_IPHONE_5_SCREEN)
        objAddressViewController = [[[AddressViewController alloc] initWithNibName:@"AddressViewController" bundle:nil] autorelease];
    else if(g_IS_IPHONE_4_SCREEN)
        objAddressViewController = [[[AddressViewController alloc] initWithNibName:@"AddressViewController4" bundle:nil] autorelease];
    //else if(g_IS_IPAD)
        //objAddressViewController = [[[AddressViewController alloc] initWithNibName:@"AddressViewControlleriPad" bundle:nil] autorelease];
    else
        objAddressViewController = [[[AddressViewController alloc] initWithNibName:@"AddressViewController4" bundle:nil] autorelease];
     */
    
    //objAddressViewController.imgPhotoPreview = imgPhotoToShare;
    [self.navigationController pushViewController:objAddressViewController animated:YES];
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
    
    if(textField==_txtFirstName)
	{
		intCurrentInputID = kTag_FirstName;
		
        if(_scrollViewMain.contentOffset.y>kPosition_FirstName)
			fltPageScl = _scrollViewMain.contentOffset.y;
		else
			fltPageScl = kPosition_FirstName;
        
		//fltPageScl = 0.0;
		//fltPageScl = _scrollViewMain.contentOffset.y;
        [_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
	}
	else if(textField==_txtLastName)
	{
		intCurrentInputID = kTag_LastName;
		
		if(_scrollViewMain.contentOffset.y>kPosition_LastName)
			fltPageScl = _scrollViewMain.contentOffset.y;
		else
			fltPageScl = kPosition_LastName;
		
		[_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
	}
    else if(textField==_txtPostcode)
    {
        intCurrentInputID = kTag_Postcode;
        
        if(_scrollViewMain.contentOffset.y>kPosition_Postcode)
            fltPageScl = _scrollViewMain.contentOffset.y;
        else
            fltPageScl = kPosition_Postcode;
        
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
	else if(textField==_txtMobile)
	{
		intCurrentInputID = kTag_Mobile;
		
		if(_scrollViewMain.contentOffset.y>kPosition_Mobile)
			fltPageScl = _scrollViewMain.contentOffset.y;
		else
			fltPageScl = kPosition_Mobile;
		
		[_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
	}
    else if(textField==_txtUsername)
    {
        intCurrentInputID = kTag_Username;
        
        if(_scrollViewMain.contentOffset.y>kPosition_Username)
            fltPageScl = _scrollViewMain.contentOffset.y;
        else
            fltPageScl = kPosition_Username;
        
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
    [_txtAddress textChanged:nil];
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
    [self removeOptionPicker];
    [self removeDatePicker];
    
	fltPageScl = 0.0;
	[_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
}
-(IBAction)btnTappedNext:(id)sender
{
	if(intCurrentInputID==kTag_Birthday)
	{
		[self resignOtherControl];
		fltPageScl = kPosition_Bottom;
		[_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
	}
	else {
		intCurrentInputID = intCurrentInputID+1;
		[self checkCurrentInputIDandPerformAction];
	}
}
-(IBAction)btnTappedPrev:(id)sender
{
	if(intCurrentInputID==kTag_Title)
	{
		[self resignOtherControl];
		fltPageScl = kPosition_Title;
		[_scrollViewMain setContentOffset:CGPointMake(0.0, fltPageScl)];
	}
	else {
		intCurrentInputID = intCurrentInputID-1;
		[self checkCurrentInputIDandPerformAction];
	}
}
#pragma mark - Check Current Input ID and Perform Action
-(void)checkCurrentInputIDandPerformAction
{
	[self resignOtherControl];
	
	UIButton *btn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	[btn setTag:intCurrentInputID];
    
	switch (intCurrentInputID) {
		case 1: //Title
            [self btnTappedOption:btn];
			break;
		case 2: //First Name
			[_txtFirstName becomeFirstResponder];
			break;
		case 3: //Last Name
			[_txtLastName becomeFirstResponder];
			break;
        case 4: //Postcode
            //[self btnTappedOption:btn];
            [_txtPostcode becomeFirstResponder];
            break;
        case 5: //City
            [_txtCity becomeFirstResponder];
            break;
		case 6: //Address
			[_txtAddress becomeFirstResponder];
			break;
        case 7: //Mobile
            [_txtMobile becomeFirstResponder];
            break;
        case 8: //Username
			[_txtUsername becomeFirstResponder];
			break;
        case 9: //Birthday
            [self btnTappedBirthday:btn];
			break;
	}
}

#pragma mark - Button Tapped Back
-(IBAction)btnTappedBack:(id)sender{
    [FunctionManager gotoBack:self];
}

#pragma mark - Orientations
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.strBirthDate release];
    
    if(self.arrTitle.count>0)
        [self.arrTitle removeAllObjects];
    [self.arrTitle release];
        
    [_txtTitle release];
    [_lblTitle release];
    [_btnTitle release];
    
    [_txtFirstName release];
    [_txtLastName release];
    [_txtPostcode release];
    [_txtCity release];
    [_txtAddress release];
    [_txtMobile release];
    [_txtUsername release];
    [_btnBirthday release];
    
    //[_btnPostCode release];
    
    [_chkTermsCondition release];
    
    [self.viewAddresses release];
    [_tblAddress release];
    
    [_viewInput release];
    [_scrollViewMain release];
    
    [super dealloc];
}

@end
