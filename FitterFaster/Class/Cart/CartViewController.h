//
//  CartViewController.h
//  GW Whiteboard
//
//  Created by WebInfoways on 27/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"
#import "OrderDeliverViewController.h"
#import "MenuView.h"

#import "Product.h"
#import "CartCell.h"

@class AppDelegate;

@interface CartViewController : UIViewController <PayPalFuturePaymentDelegate, UITextFieldDelegate>    //PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate,
{
    AppDelegate *appDelegate;
}
@property (nonatomic) BOOL bolIsDataFetched;

@property (nonatomic,retain) IBOutlet UITextView *txtDeliveryAddress;
@property (nonatomic,retain) IBOutlet UILabel *lblMobileNo;

@property (nonatomic,retain) IBOutlet UILabel *lblMessage;

@property (nonatomic,retain) NSMutableArray *arrCart;
@property (nonatomic,retain) IBOutlet UITableView *tblCart;

@property (nonatomic,retain) IBOutlet UILabel *lblTotalTitle;
@property (nonatomic,retain) IBOutlet UILabel *lblDeliveryChargeTitle;
@property (nonatomic,retain) IBOutlet UILabel *lblGrandTotalTitle;
@property (nonatomic,retain) IBOutlet UILabel *lblTotal;
@property (nonatomic,retain) IBOutlet UILabel *lblDeliveryCharge;
@property (nonatomic,retain) IBOutlet UILabel *lblGrandTotal;

@property (nonatomic) NSInteger intRemoveItemIndex;

@property (nonatomic, retain) MenuView *viewMenu;

@property (nonatomic,retain) IBOutlet UIButton *btnPayPal;

//PayPal Payment
@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) NSString *resultText;

-(void)setInitialParameter;
-(void)bindDefaultData;
-(void)resetData;

-(void)fetchCart;

-(IBAction)btnTappedDeliverOrder:(id)sender;

-(IBAction)btnTappedBack:(id)sender;

@end