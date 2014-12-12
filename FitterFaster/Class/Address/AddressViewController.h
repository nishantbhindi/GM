//
//  AddressViewController.h
//  GW Whiteboard
//
//  Created by WebInfoways on 27/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryViewController.h"
#import "MenuView.h"

@class AppDelegate;

@interface AddressViewController : UIViewController
{
    AppDelegate *appDelegate;
    
    float fltPageScl;
    int intCurrentInputID;
    
    NSTimer *autoTimer;
}
@property(nonatomic,retain) IBOutlet UILabel *lblTitle;

@property(nonatomic,retain) IBOutlet UIView *viewInput;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollViewMain;

@property (nonatomic,retain) IBOutlet MKMapView *objLocationMap;
@property(nonatomic,retain) IBOutlet UITextViewPlaceHolder *txtCurrAddress;

@property(nonatomic,retain) IBOutlet UITextField *txtPostcode;
@property(nonatomic,retain) IBOutlet UITextField *txtCity;
@property(nonatomic,retain) IBOutlet UITextViewPlaceHolder *txtNewAddress;
@property(nonatomic,retain) IBOutlet UIView *viewAddresses;
@property (nonatomic,retain) IBOutlet UITableView *tblAddress;
@property (nonatomic,retain) NSMutableArray *arrAddress;

@property (nonatomic, retain) MenuView *viewMenu;

-(void)setInitialParameter;
-(void)bindDefaultData;

-(void)addObserver;
-(void)removeAddedObserver;

-(void)addMarker;

-(IBAction)resetData:(id)sender;
-(void)resignOtherControl;
-(BOOL)checkEnteredData;
-(IBAction)btnTappedAddAddress:(id)sender;
-(void)addUserAddress:(NSInteger)pintAddressType;

-(IBAction)btnTappedDone:(id)sender;
-(IBAction)btnTappedNext:(id)sender;
-(IBAction)btnTappedPrev:(id)sender;

-(IBAction)btnTappedBack:(id)sender;

-(IBAction)btnTappedMenu:(id)sender;
-(void)closeMenu;

@end
