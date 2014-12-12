//
//  ForgotPasswordViewController.h
//  
//
//  Created by WebInfoways on 05/06/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface ForgotPasswordViewController : UIViewController
{
    AppDelegate *appDelegate;
}
@property(nonatomic,retain) IBOutlet UITextField *txtEmail;

-(void)initializePageData;

-(void)resetData;
-(void)resignResponder;
-(BOOL)checkEnteredData;
-(IBAction)btnTappedSubmit:(id)sender;

-(IBAction)btnTappedBack:(id)sender;
-(IBAction)btnTappedClose:(id)sender;

@end
