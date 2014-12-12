//
//  RegistrationViewController.h
//  TrueLocation
//
//  Created by WebInfoways on 28/05/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextContentViewController.h"
#import "TermsViewController.h"
#import "AddressViewController.h"

#import "PickerVC.h"
#import "DatePickerVC.h"
#import "User.h"

@class AppDelegate;

@interface SignUpViewController : UIViewController <PickerViewChangeDelegate,DatePickerViewChangeDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    AppDelegate *appDelegate;
    
    int intRecordAddedId;
    
    float fltPageScl;
	int intCurrentInputID;
    
    int intTitleIndex;
    NSMutableArray *arrTitle;
    
    //int intPostCodeIndex;
    
    NSTimer *autoTimer;
}
@property(nonatomic) int intRecordAddedId;

@property (nonatomic, retain) User *objUser;

@property(nonatomic,retain) IBOutlet UIView *viewInput;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollViewMain;

@property(nonatomic,retain) NSMutableArray *arrTitle;

@property(nonatomic,retain) IBOutlet UIButton *btnTitle;
@property(nonatomic,retain) IBOutlet UITextField *txtTitle;
@property(nonatomic,retain) IBOutlet UILabel *lblTitle;

@property(nonatomic,retain) IBOutlet UITextField *txtFirstName;
@property(nonatomic,retain) IBOutlet UITextField *txtLastName;
@property(nonatomic,retain) IBOutlet UITextField *txtCity;
@property(nonatomic,retain) IBOutlet UITextField *txtPostcode;
@property(nonatomic,retain) IBOutlet UITextViewPlaceHolder *txtAddress;
@property(nonatomic,retain) IBOutlet UITextField *txtMobile;
@property(nonatomic,retain) IBOutlet UITextField *txtUsername;

@property(nonatomic,retain) IBOutlet UIButton *btnBirthday;
@property(nonatomic,retain) NSString *strBirthDate;

//@property(nonatomic,retain) IBOutlet UIButton *btnPostCode;

@property (nonatomic,retain) IBOutlet UIButton *chkTermsCondition;

//@property(nonatomic,retain) IBOutlet UITextField *txtPassword;
//@property(nonatomic,retain) IBOutlet UITextField *txtConfirmPassword;

@property(nonatomic,retain) IBOutlet UIView *viewAddresses;
@property (nonatomic,retain) IBOutlet UITableView *tblAddress;
@property (nonatomic,retain) NSMutableArray *arrAddress;


-(void)setInitialParameter;
-(void)bindDefaultData;

-(void)addObserver;
-(void)removeAddedObserver;

-(IBAction)btnTappedOption:(id)sender;

-(IBAction)btnTappedReviewTermsCondition:(id)sender;
-(IBAction)btnTappedCheckTermsCondition:(id)sender;

-(IBAction)resetData:(id)sender;
-(void)resignOtherControl;
-(void)removeOptionPicker;
-(BOOL)checkEnteredData;
-(IBAction)btnTappedSignUp:(id)sender;
-(void)signUpUser;

-(IBAction)btnTappedDone:(id)sender;
-(IBAction)btnTappedNext:(id)sender;
-(IBAction)btnTappedPrev:(id)sender;

-(void)checkCurrentInputIDandPerformAction;

-(IBAction)btnTappedBack:(id)sender;

@end
