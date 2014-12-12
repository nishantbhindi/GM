//
//  ForgotPasswordViewController.m
//  
//
//  Created by WebInfoways on 05/06/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

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
    [_txtEmail becomeFirstResponder];
}

#pragma mark - Initialize Page Data
-(void)initializePageData{
    [self resetData];
}

#pragma mark - Submit Forgot Password
#pragma mark Reset Data
-(void)resetData{
    _txtEmail.text=@"";
    [self resignResponder];
}
-(void)resignResponder{
	[_txtEmail resignFirstResponder];
}
#pragma mark Validate Entered Data
-(BOOL)checkEnteredData{
	if([_txtEmail.text isEmptyString]){
		[FunctionManager showMessage:@"" withMessage:msgEnterEmail withDelegage:nil];
		return FALSE;
	}
    else if(![_txtEmail.text isEmptyString] && ![_txtEmail.text isValidEmail]){
        [FunctionManager showMessage:nil withMessage:msgEnterValidEmail withDelegage:nil];
        return FALSE;
    }
	else {
	}
	return TRUE;
}
#pragma mark Submit
-(IBAction)btnTappedSubmit:(id)sender{
    if([self checkEnteredData]){
        [self resignResponder];
        
        [self checkForgotPassword];
    }
}
#pragma mark Check for Forgot Password
-(void)checkForgotPassword{
    [FunctionManager displayLoadingView:self.view withMessage:msgLoadingGeneral appDelegate:appDelegate viewController:self];
    
    NSURL *baseURL = [NSURL URLWithString:g_WebserviceUrl];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"method"] = @"forgotPassword";
    parameters[@"email"] = _txtEmail.text;
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:g_Pagename_Api parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        
        //NSLog(@"JSON: %@", responseObject);
        [self checkForgotPwdResponse:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        [FunctionManager showMessage:@"" withMessage:[error localizedDescription] withDelegage:nil];
    }];
}
-(void)checkForgotPwdResponse:(NSDictionary *)pdicResponse{
    int success = [[pdicResponse objectForKey:@"status"] intValue];
    [FunctionManager showMessage:@"" withMessage:[pdicResponse objectForKey:@"message"] withDelegage:nil];
    
    if(success)
        [self btnTappedBack:nil];
}

#pragma mark - UITextField delegate
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
#pragma mark - Close
-(IBAction)btnTappedClose:(id)sender{
    //[FunctionManager gotoBack:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Orientations
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
    [_txtEmail release];
    
    [super dealloc];
}

@end
