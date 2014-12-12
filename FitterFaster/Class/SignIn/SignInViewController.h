//
//  SignInViewController.h
//  VideoTest
//
//  Created by WebInfoways on 11/04/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpViewController.h"
#import "AddressViewController.h"
//#import "CategoryViewController.h"
#import "ForgotPasswordViewController.h"
#import "WebPageViewController.h"

@class AppDelegate;

@interface SignInViewController : UIViewController
{
    AppDelegate *appDelegate;
}
@property(nonatomic,retain) IBOutlet UITextField *txtUsername;
@property(nonatomic,retain) IBOutlet UITextField *txtPassword;

-(void)initializePageData;

-(void)bindRememberCredential;
-(void)addCredentialToRememberMe;

-(void)resetData;
-(void)resignResponder;
-(BOOL)checkEnteredData;
-(IBAction)btnTappedSignIn:(id)sender;
-(void)openCategoryPage;

-(IBAction)btnTappedSignUp:(id)sender;
-(IBAction)btnTappedForgotPassword:(id)sender;
-(IBAction)btnTappedRetailPartner:(id)sender;

@end
