//
//  OrderDeliverViewController.m
//  GW Whiteboard
//
//  Created by WebInfoways on 27/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "OrderDeliverViewController.h"

@interface OrderDeliverViewController ()

@end

@implementation OrderDeliverViewController

@synthesize strDeliveryMessage,strOrderID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setInitialParameter];
}
- (void)viewWillAppear:(BOOL)animated
{
}

#pragma mark - Initialize Page Data
-(void)setInitialParameter
{
    [self resetData];
    
    _lblDeliveryMessage.text = self.strDeliveryMessage;
}

#pragma mark - Button Tapped Verification
#pragma mark - Verification Code
#pragma mark Reset Data
-(void)resetData{
    _txtVerificationCode.text=@"";
    [self resignResponder];
}
-(void)resignResponder{
    [_txtVerificationCode resignFirstResponder];
}
#pragma mark Validate Entered Data
-(BOOL)checkEnteredData{
    if([_txtVerificationCode.text isEmptyString]){
        [FunctionManager showMessage:nil withMessage:msgEnterVerificationCode withDelegage:nil];
        return FALSE;
    }
    else {
    }
    return TRUE;
}
#pragma mark Verification Code
-(IBAction)btnTappedDelivered:(id)sender{
    if([self checkEnteredData]){
        [self resignResponder];
        [self checkVerificationCode];
        
        //[self openThankYouPage];
    }
}
#pragma mark Check Verification Code
-(void)checkVerificationCode{
    [FunctionManager displayLoadingView:self.view withMessage:msgLoadingGeneral appDelegate:appDelegate viewController:self];
    
    NSURL *baseURL = [NSURL URLWithString:g_WebserviceUrl];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"method"] = @"cartConfirm";
    
    parameters[@"order_id"] = self.strOrderID;
    parameters[@"confirm_code"] = _txtVerificationCode.text;
    
    //iOS6 & About = AFHTTPRequestOperationManager
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:g_Pagename_Api parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        
        //NSLog(@"JSON: %@", responseObject);
        [self checkVerificationResponse:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        [FunctionManager showMessage:@"" withMessage:[error localizedDescription] withDelegage:nil];
    }];
}
-(void)checkVerificationResponse:(NSDictionary *)pdicResponse{
    int success = [[pdicResponse objectForKey:@"status"] intValue];
    
    if(success)
    {
        NSString *strMessage = [pdicResponse objectForKey:@"message"];
        NSLog(@"%@", strMessage);
        
        [self openThankYouPage];
    }
    else
        [FunctionManager showMessage:@"" withMessage:[pdicResponse objectForKey:@"message"] withDelegage:nil];
}
-(void)openThankYouPage{
     ThankYouViewController *objThankYouViewController;
     objThankYouViewController = [[[ThankYouViewController alloc] initWithNibName:@"ThankYouViewController" bundle:nil] autorelease];
     
     
     //    if(g_IS_IPHONE_6PLUS_SCREEN)
     //        objThankYouViewController = [[[ThankYouViewController alloc] initWithNibName:@"ThankYouViewController6P" bundle:nil] autorelease];
     //    else if(g_IS_IPHONE_6_SCREEN)
     //        objThankYouViewController = [[[ThankYouViewController alloc] initWithNibName:@"ThankYouViewController6" bundle:nil] autorelease];
     //    else if(g_IS_IPHONE_5_SCREEN)
     //        objThankYouViewController = [[[ThankYouViewController alloc] initWithNibName:@"ThankYouViewController" bundle:nil] autorelease];
     //    else if(g_IS_IPHONE_4_SCREEN)
     //        objThankYouViewController = [[[ThankYouViewController alloc] initWithNibName:@"ThankYouViewController4" bundle:nil] autorelease];
     //    //else if(g_IS_IPAD)
     //        //objThankYouViewController = [[[ThankYouViewController alloc] initWithNibName:@"ThankYouViewControlleriPad" bundle:nil] autorelease];
     //    else
     //        objThankYouViewController = [[[ThankYouViewController alloc] initWithNibName:@"ThankYouViewController4" bundle:nil] autorelease];
     
    
    //objThankYouViewController.strDeliveryMessage = @"";
    [self.navigationController pushViewController:objThankYouViewController animated:YES];
    
    
    //[self.navigationController presentViewController:objThankYouViewController animated:YES completion:nil];
}

#pragma mark TextField Delegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Button Tapped Back
-(IBAction)btnTappedBack:(id)sender{
    [FunctionManager gotoBack:self];
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
    [self.strDeliveryMessage release];
    [self.strOrderID release];
    
    [_lblDeliveryMessage release];
    [_txtVerificationCode release];
    
    [super dealloc];
}

@end
