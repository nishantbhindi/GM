//
//  CartViewController.m
//  GW Whiteboard
//
//  Created by WebInfoways on 27/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "CartViewController.h"

//PayPal Payment

/*
/// Production (default): Normal, live environment. Real money gets moved.
/// This environment MUST be used for App Store submissions.
extern NSString *const PayPalEnvironmentProduction;
/// Sandbox: Uses the PayPal sandbox for transactions. Useful for development.
extern NSString *const PayPalEnvironmentSandbox;
/// NoNetwork: Mock mode. Does not submit transactions to PayPal. Fakes successful responses. Useful for unit tests.
extern NSString *const PayPalEnvironmentNoNetwork;
*/
#define kPayPalEnvironment PayPalEnvironmentSandbox

@interface CartViewController ()

//PayPal Payment
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;

@end

@implementation CartViewController

@synthesize bolIsDataFetched;
@synthesize arrCart;
@synthesize intRemoveItemIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setInitialParameter];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self setPayPalEnvironment:self.environment];
    
    if(!self.bolIsDataFetched)
        [self fetchCart];
}

#pragma mark - Initialize Page Data
-(void)setInitialParameter{
    [self setPayPalConfiguration];
    
    [self resetData];
    [self bindDefaultData];
    
    self.arrCart = [[NSMutableArray alloc] init];
    
    /*
    NSMutableDictionary *dicAnsOptions=[[NSMutableDictionary alloc] initWithCapacity:3];
    [dicAnsOptions setValue:[NSString stringWithFormat:@"%d", 1] forKey:@"ID"];
    [dicAnsOptions setValue:@"Erdinger 1" forKey:@"Product"];
    [dicAnsOptions setValue:@"10" forKey:@"Price"];
    [dicAnsOptions setValue:@"5" forKey:@"Qty"];
    [self.arrCart addObject:dicAnsOptions];
    
    NSMutableDictionary *dicAnsOptions2=[[NSMutableDictionary alloc] initWithCapacity:3];
    [dicAnsOptions2 setValue:[NSString stringWithFormat:@"%d", 2] forKey:@"ID"];
    [dicAnsOptions2 setValue:@"Erdinger 2" forKey:@"Product"];
    [dicAnsOptions2 setValue:@"12" forKey:@"Price"];
    [dicAnsOptions2 setValue:@"7" forKey:@"Qty"];
    [self.arrCart addObject:dicAnsOptions2];
    
    NSMutableDictionary *dicAnsOptions3=[[NSMutableDictionary alloc] initWithCapacity:3];
    [dicAnsOptions3 setValue:[NSString stringWithFormat:@"%d", 3] forKey:@"ID"];
    [dicAnsOptions3 setValue:@"Erdinger 3" forKey:@"Product"];
    [dicAnsOptions3 setValue:@"14" forKey:@"Price"];
    [dicAnsOptions3 setValue:@"8" forKey:@"Qty"];
    [self.arrCart addObject:dicAnsOptions3];
    
    NSMutableDictionary *dicAnsOptions4=[[NSMutableDictionary alloc] initWithCapacity:3];
    [dicAnsOptions4 setValue:[NSString stringWithFormat:@"%d", 4] forKey:@"ID"];
    [dicAnsOptions4 setValue:@"Erdinger 4" forKey:@"Product"];
    [dicAnsOptions4 setValue:@"16" forKey:@"Price"];
    [dicAnsOptions4 setValue:@"10" forKey:@"Qty"];
    [self.arrCart addObject:dicAnsOptions4];
    
    [_tblCart reloadData];
     */
}
-(void)bindDefaultData{
    _txtDeliveryAddress.text = [NSString stringWithFormat:@"%@,%@,%@", appDelegate.objUser.strDeliveryAddress, appDelegate.objUser.strDeliveryCity, appDelegate.objUser.strDeliveryPostcode];
    _lblMobileNo.text = appDelegate.objUser.strMobile;
}
#pragma mark - Reset
-(void)resetData{
    [_btnPayPal setEnabled:FALSE];
    
    _txtDeliveryAddress.text = @"-";
    _lblMobileNo.text = @"-";
    
    _lblMessage.text = @"";
    
    _lblTotalTitle.text = @"-";
    _lblDeliveryChargeTitle.text = @"-";
    _lblGrandTotalTitle.text = @"-";
    _lblTotal.text = @"-";
    _lblDeliveryCharge.text = @"-";
    _lblGrandTotal.text = @"-";
}

#pragma mark - Fetch Cart
-(void)fetchCart{
    if(self.arrCart.count>0)
        [self.arrCart removeAllObjects];
    
    [FunctionManager displayLoadingView:self.view withMessage:msgLoadingGeneral appDelegate:appDelegate viewController:self];
    
    NSURL *baseURL = [NSURL URLWithString:g_WebserviceUrl];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"method"] = @"getCart";
    
    parameters[@"userid"] = [NSString stringWithFormat:@"%d", appDelegate.objUser.intUserID];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:g_Pagename_Api parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        
        //NSLog(@"JSON: %@", responseObject);
        [self checkCartResponse:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        [FunctionManager showMessage:@"" withMessage:[error localizedDescription] withDelegage:nil];
        //NSLog(@"ERROR: %@", [error localizedDescription]);
    }];
}
-(void)checkCartResponse:(NSDictionary *)pdicResponse{
    if([pdicResponse isKindOfClass:[NSDictionary class]])
    {
        int success = [[pdicResponse objectForKey:@"status"] intValue];
        
        if(success){
            NSString *strCurr = (NSString*)[pdicResponse objectForKey:@"currency_symbol"];
            
            NSDictionary *dicCartInfo = (NSDictionary*)[pdicResponse objectForKey:@"cart_info"];
            //NSDictionary *dicShippingInfo = (NSDictionary*)[dicCartInfo objectForKey:@"shipping_address"];  //street, city, postcode, telephone
            //Difference between "shipping_address" and "billing_address"
            
            NSArray *arrProducts = (NSArray*)[dicCartInfo objectForKey:@"items"];
            for(int i=0;i<arrProducts.count;i++){
                NSDictionary *dicProduct = [arrProducts objectAtIndex:i];
                
                Product *objProduct = [[Product alloc] init];
                objProduct.intProductID = [[dicProduct objectForKey:@"product_id"] intValue];
                objProduct.strTitle = [dicProduct objectForKey:@"name"];
                objProduct.strPrice = [dicProduct objectForKey:@"price"];
                
                objProduct.strCurrency = strCurr;
                objProduct.intCartQty = [[dicProduct objectForKey:@"qty"] intValue];
                objProduct.strRowTotal = [dicProduct objectForKey:@"row_total"];
                
                objProduct.strVolume = [dicProduct objectForKey:@"alcohol_by_volume"];
                objProduct.strServing = [dicProduct objectForKey:@"units_per_serving"];
                objProduct.strSize = [dicProduct objectForKey:@"size"];
                objProduct.strPhotoUrl = [dicProduct objectForKey:@"image_url"];
                [self.arrCart addObject:objProduct];
            }
            
            
            NSArray *arrTotal = (NSArray*)[pdicResponse objectForKey:@"cart_totals"];
            NSDictionary *dicTotal = [arrTotal objectAtIndex:0];
            NSDictionary *dicDelivery = [arrTotal objectAtIndex:1];
            NSDictionary *dicGrandTotal = [arrTotal objectAtIndex:2];
            
            _lblTotalTitle.text = [dicTotal objectForKey:@"title"];
            //_lblTotal.text = [dicTotal objectForKey:@"amount"];
            _lblTotal.text = [NSString stringWithFormat:@"%@%.2f", strCurr, [[dicTotal objectForKey:@"amount"] floatValue]];
            
            _lblDeliveryChargeTitle.text = [dicDelivery objectForKey:@"title"];
            //_lblDeliveryCharge.text = [dicDelivery objectForKey:@"amount"];
            _lblDeliveryCharge.text = [NSString stringWithFormat:@"%@%.2f", strCurr, [[dicDelivery objectForKey:@"amount"] floatValue]];
            
            _lblGrandTotalTitle.text = [dicGrandTotal objectForKey:@"title"];
            //_lblGrandTotal.text = [dicGrandTotal objectForKey:@"amount"];
            _lblGrandTotal.text = [NSString stringWithFormat:@"%@%.2f", strCurr, [[dicGrandTotal objectForKey:@"amount"] floatValue]];
            
            
            if(arrProducts.count>0)
                [_btnPayPal setEnabled:TRUE];
            else
                [_btnPayPal setEnabled:FALSE];
        }
        
        else{
            [FunctionManager showMessage:@"" withMessage:[pdicResponse objectForKey:@"message"] withDelegage:nil];
        }
    }
    else
        [_btnPayPal setEnabled:FALSE];
    
    [_tblCart reloadData];
}

#pragma mark - UITableView Delegete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrCart.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CartCell";
    CartCell *cell = (CartCell *)[_tblCart dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)	{
        NSArray* nib;
        if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN))
            nib = [[NSBundle mainBundle] loadNibNamed:@"CartCell" owner:self options:nil];
        else
            nib = [[NSBundle mainBundle] loadNibNamed:@"CartCell_iPad" owner:self options:nil];
        
        for (id oneObject in nib) if ([oneObject isKindOfClass:[CartCell class]])
            cell = (CartCell *)oneObject;
        
        //cell = [nib objectAtIndex:0];
        cell.showsReorderControl = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];   //darkGrayColor
    }
    /*
    [cell.btnRemove.layer setCornerRadius:3.0];
    [cell.btnRemove.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [cell.btnRemove.layer setBorderWidth: 2.0];
    cell.btnRemove.clipsToBounds = YES;
     */
    
    Product *objProductTmp = [self.arrCart objectAtIndex:indexPath.row];
    
    cell.lblProduct.text = objProductTmp.strTitle;
    cell.lblPrice.text = [NSString stringWithFormat:@"%@%.2f", objProductTmp.strCurrency, [objProductTmp.strPrice floatValue]];
    cell.lblQty.text = [NSString stringWithFormat:@"%d", objProductTmp.intCartQty];
    cell.lblSubTotal.text = [NSString stringWithFormat:@"%@%.2f", objProductTmp.strCurrency, [objProductTmp.strRowTotal floatValue]];
    
    /*
    cell.txtQty.text = [NSString stringWithFormat:@"%d", objProductTmp.intCartQty];
    cell.txtQty.delegate = self;
    [cell.txtQty setTag:indexPath.row];
    [cell.txtQty addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    */
    
    [cell.btnRemove setTag:indexPath.row];
    [cell.btnRemove addTarget:self action:@selector(btnTappedRemoveProduct:) forControlEvents:UIControlEventTouchUpInside];
    
    /*
    [cell.btnRemove setTitle:[dicAns objectForKey:@"Answer"] forState:UIControlStateNormal];
    
    if([[dicAns objectForKey:@"IsSelected"] integerValue]==1){
        [cell.btnAnswer setBackgroundColor:[UIColor colorWithRed:64.0/255.0 green:197.0/255.0 blue:192.0/255.0 alpha:1.0]];
        [cell.btnAnswer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else{
        [cell.btnAnswer setBackgroundColor:[UIColor clearColor]];
        [cell.btnAnswer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }*/
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark Remove From Cart
- (IBAction)btnTappedRemoveProduct:(id)sender{
    self.intRemoveItemIndex = [sender tag];
    [FunctionManager showMessageWithConfirm:@"" withMessage:msgRecordDeleteConfirm withTag:self.intRemoveItemIndex withDelegage:self];
}
#pragma mark Confirm Action
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0)
    {
        [self removeItemFromCart:alertView.tag];
    }
}
-(void)removeItemFromCart:(NSInteger)pintItemIndex{
    Product *objProductTmp = [self.arrCart objectAtIndex:pintItemIndex];
    //Product *objProductTmp = [self.arrCart objectAtIndex:[sender tag]];
    //NSLog(@"Product Name: %@", objProductTmp.strTitle);
    
    
    [FunctionManager displayLoadingView:self.view withMessage:msgLoadingGeneral appDelegate:appDelegate viewController:self];
    
    NSURL *baseURL = [NSURL URLWithString:g_WebserviceUrl];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"method"] = @"cartRemove";
    
    parameters[@"userid"] = [NSString stringWithFormat:@"%d", appDelegate.objUser.intUserID];
    parameters[@"product_id"] = [NSString stringWithFormat:@"%d", objProductTmp.intProductID];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:g_Pagename_Api parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        
        //NSLog(@"JSON: %@", responseObject);
        [self checkRemoveFromCartResponse:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        [FunctionManager showMessage:@"" withMessage:[error localizedDescription] withDelegage:nil];
        //NSLog(@"ERROR: %@", [error localizedDescription]);
    }];
}
-(void)checkRemoveFromCartResponse:(NSDictionary *)pdicResponse{
    //int success = [[pdicResponse objectForKey:@"status"] intValue];
    [FunctionManager showMessage:@"" withMessage:[pdicResponse objectForKey:@"message"] withDelegage:nil];
    //[_tblCart reloadData];
    
    [self fetchCart];
}

/*
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        NSLog(@"1 = Load New Records");
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (([scrollView contentOffset].y + scrollView.frame.size.height) >= [scrollView contentSize].height){
        NSLog(@"2 = Load New Records");
        
        //self.intPageNo = self.intPageNo + 1;
        //[self fetchBlogList];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (([scrollView contentOffset].y + scrollView.frame.size.height) >= [scrollView contentSize].height){
//        // Get new record from here
//        DLog(@"OffSet Y = %f", [scrollView contentOffset].y);
//        DLog(@"Scroll Frame Height = %f", scrollView.frame.size.height);
//        DLog(@"Scroll Content Height = %f", [scrollView contentSize].height);
//     
//        DLog(@"Load New Records");
//     
//        self.intPageNo = self.intPageNo + 1;
//        [self fetchBlogList];
//    }
}
*/

/*
#pragma mark TextField Delegate Methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSLog(@"ID = %ld", (long)[textField tag]);
    NSLog(@"Qty Changed: %@", textField.text);
    
    NSDictionary *dicProduct = [self.arrCart objectAtIndex:[textField tag]];
    [dicProduct setValue:textField.text forKey:@"Qty"];
    [_tblCart reloadData];
    
    
//    [self.tblCart beginUpdates];
//    [self.tblCart reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:[theTextField tag] inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
//    [self.tblCart endUpdates];
    
    
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *unacceptedInput = nil;
    unacceptedInput = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
    
    if([[string componentsSeparatedByCharactersInSet:unacceptedInput] count] <= 1)
        return YES;
    else
        return NO;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    if([textField.text isEmptyString]){
//        textField.text = @"0";
//    }
    return YES;
}
-(void)textFieldDidChange :(UITextField *)theTextField{
    if([theTextField.text isEmptyString]){
        theTextField.text = @"0";
    }
    
    
//    NSLog(@"Qty Changed: %@", theTextField.text);
//    
//    NSDictionary *dicProduct = [self.arrCart objectAtIndex:[theTextField tag]];
//    [dicProduct setValue:theTextField.text forKey:@"Qty"];
//    //[_tblCart reloadData];
//    
//    
//    [self.tblCart beginUpdates];
//    [self.tblCart reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:[theTextField tag] inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
//    [self.tblCart endUpdates];
//    
//    //UITableViewCell *cell = (UITableViewCell *) [theTextField superview];
//    //NSIndexPath *indexPath = [_tblCart indexPathForCell:cell];
//    //[_tblCart reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}
*/

#pragma mark - Button Tapped Deliver Order to Me
-(IBAction)btnTappedDeliverOrder:(id)sender{
    //Make Future Payment//
    [self getUserAuthorizationForFuturePayments];
}
-(void)openOrderDeliveryPage:(NSString *)pstrDeliveryMessage withOrderID:(NSString *)pstrOrderID{
    OrderDeliverViewController *objOrderDeliverViewController;
    objOrderDeliverViewController = [[[OrderDeliverViewController alloc] initWithNibName:@"OrderDeliverViewController" bundle:nil] autorelease];
    
    /*
     if(g_IS_IPHONE_6PLUS_SCREEN)
        objOrderDeliverViewController = [[[OrderDeliverViewController alloc] initWithNibName:@"OrderDeliverViewController6P" bundle:nil] autorelease];
     else if(g_IS_IPHONE_6_SCREEN)
        objOrderDeliverViewController = [[[OrderDeliverViewController alloc] initWithNibName:@"OrderDeliverViewController6" bundle:nil] autorelease];
     else if(g_IS_IPHONE_5_SCREEN)
        objOrderDeliverViewController = [[[OrderDeliverViewController alloc] initWithNibName:@"OrderDeliverViewController" bundle:nil] autorelease];
     else if(g_IS_IPHONE_4_SCREEN)
        objOrderDeliverViewController = [[[OrderDeliverViewController alloc] initWithNibName:@"OrderDeliverViewController4" bundle:nil] autorelease];
     //else if(g_IS_IPAD)
        //objOrderDeliverViewController = [[[OrderDeliverViewController alloc] initWithNibName:@"OrderDeliverViewControlleriPad" bundle:nil] autorelease];
     else
        objOrderDeliverViewController = [[[OrderDeliverViewController alloc] initWithNibName:@"OrderDeliverViewController4" bundle:nil] autorelease];
     */
    
    //objOrderDeliverViewController.strDeliveryMessage = @"Retailer Name & Number";
    objOrderDeliverViewController.strDeliveryMessage = pstrDeliveryMessage;
    objOrderDeliverViewController.strOrderID = pstrOrderID;
    
    [self.navigationController pushViewController:objOrderDeliverViewController animated:YES];
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

#pragma mark - PayPal Payment
#pragma mark Set PayPal Configuration
-(void)setPayPalConfiguration{
    // Set up payPalConfig
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;
    _payPalConfig.merchantName = g_PayPalMerchantName;
    //_payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    //_payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:g_PayPalMerchantPolicyUrl];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:g_PayPalMerchantAgreeUrl];
    
    
    // Setting the languageOrLocale property is optional.
    //
    // If you do not set languageOrLocale, then the PayPalPaymentViewController will present
    // its user interface according to the device's current language setting.
    //
    // Setting languageOrLocale to a particular language (e.g., @"es" for Spanish) or
    // locale (e.g., @"es_MX" for Mexican Spanish) forces the PayPalPaymentViewController
    // to use that language/locale.
    //
    // For full details, including a list of available languages and locales, see PayPalPaymentViewController.h.
    
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    
    // Setting the payPalShippingAddressOption property is optional.
    //
    // See PayPalConfiguration.h for details.
    _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
    
    // Do any additional setup after loading the view, typically from a nib.
    
    // use default environment, should be Production in real life
    self.environment = kPayPalEnvironment;
    
    NSLog(@"PayPal iOS SDK version: %@", [PayPalMobile libraryVersion]);
}
- (void)setPayPalEnvironment:(NSString *)environment {
    self.environment = environment;
    [PayPalMobile preconnectWithEnvironment:environment];
}
#pragma mark Authorize Future Payments
//- (IBAction)getUserAuthorizationForFuturePayments:(id)sender {
-(void)getUserAuthorizationForFuturePayments{
    self.bolIsDataFetched = TRUE;
    
    PayPalFuturePaymentViewController *futurePaymentViewController = [[PayPalFuturePaymentViewController alloc] initWithConfiguration:self.payPalConfig delegate:self];
    [self presentViewController:futurePaymentViewController animated:YES completion:nil];
}
#pragma mark PayPalFuturePaymentDelegate methods
- (void)payPalFuturePaymentViewController:(PayPalFuturePaymentViewController *)futurePaymentViewController
                didAuthorizeFuturePayment:(NSDictionary *)futurePaymentAuthorization {
    
    NSLog(@"PayPal Future Payment Authorization Success!");
    self.resultText = [futurePaymentAuthorization description];
    
    [self sendFuturePaymentAuthorizationToServer:futurePaymentAuthorization];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)payPalFuturePaymentDidCancel:(PayPalFuturePaymentViewController *)futurePaymentViewController {
    NSLog(@"PayPal Future Payment Authorization Canceled");
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)sendFuturePaymentAuthorizationToServer:(NSDictionary *)authorization {
    NSLog(@"Here is your authorization:\n\n%@\n\nSend this to your server to complete future payment setup.", authorization);
    NSLog(@"Authorization Code = %@", [[authorization objectForKey:@"response"] objectForKey:@"code"]);
    NSString *strAuthorizationID = [[authorization objectForKey:@"response"] objectForKey:@"code"];
    
    // Display activity indicator...
    [FunctionManager displayLoadingView:self.view withMessage:msgLoadingGeneral appDelegate:appDelegate viewController:self];
    NSString *metadataID = [PayPalMobile clientMetadataID];
    NSLog(@"Metadata ID = %@", metadataID);
    [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
    // Send metadataID and transaction details to your server for processing with PayPal...
    
    
    [self sendAuthorizationCode:strAuthorizationID withMetadataID:metadataID];
}

#pragma mark Send Authorization Code
-(void)sendAuthorizationCode:(NSString *)pstrAuthoCode withMetadataID:(NSString *)pstrMetadataID{
    //[self openOrderDeliveryPage:@"Retailer Name & Number" withOrderID:@"0001000"];
    
    
    [FunctionManager displayLoadingView:self.view withMessage:msgLoadingGeneral appDelegate:appDelegate viewController:self];
     
    NSURL *baseURL = [NSURL URLWithString:g_WebserviceUrl];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"method"] = @"cartOrder";
    
    parameters[@"userid"] = [NSString stringWithFormat:@"%d", appDelegate.objUser.intUserID];
    
    parameters[@"authorization_code"] = pstrAuthoCode;
    parameters[@"metadata_ID"] = pstrMetadataID;
    
    parameters[@"address_type"] = appDelegate.objUser.strAddressType;
    
    //iOS6 & About = AFHTTPRequestOperationManager
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
     
    [manager POST:g_Pagename_Api parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
     
        //NSLog(@"JSON: %@", responseObject);
        [self checkAuthorizationCodeResponse:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        [FunctionManager showMessage:@"" withMessage:[error localizedDescription] withDelegage:nil];
    }];
    
}
-(void)checkAuthorizationCodeResponse:(NSDictionary *)pdicResponse{
    int success = [[pdicResponse objectForKey:@"status"] intValue];
     
    if(success)
    {
        NSString *strMessage = [pdicResponse objectForKey:@"message"];
        
        NSArray *arrOrd = (NSArray*)[pdicResponse objectForKey:@"data"];
        NSDictionary *dicOrder = (NSDictionary*)[arrOrd objectAtIndex:0];
        NSString *strOrderID = (NSString*)[dicOrder objectForKey:@"OrderId"];
        
        [self openOrderDeliveryPage:strMessage withOrderID:strOrderID];
    }
    else
        [FunctionManager showMessage:@"" withMessage:[pdicResponse objectForKey:@"message"] withDelegage:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Orientations
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [_txtDeliveryAddress release];
    [_lblMobileNo release];
    
    [_lblMessage release];
    
    [_lblTotalTitle release];
    [_lblDeliveryChargeTitle release];
    [_lblGrandTotalTitle release];
    [_lblTotal release];
    [_lblDeliveryCharge release];
    [_lblGrandTotal release];
    
    if(self.arrCart.count>0)
        [self.arrCart removeAllObjects];
    [self.arrCart release];
    
    [_tblCart release];
    
    [super dealloc];
}

@end
