//
//  OrderDeliverViewController.h
//  GW Whiteboard
//
//  Created by WebInfoways on 27/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThankYouViewController.h"

@class AppDelegate;

@interface OrderDeliverViewController : UIViewController
{
    AppDelegate *appDelegate;
}
@property (nonatomic,retain) NSString *strDeliveryMessage;
@property (nonatomic,retain) NSString *strOrderID;

@property (nonatomic,retain) IBOutlet UILabel *lblDeliveryMessage;
@property (nonatomic,retain) IBOutlet UITextField *txtVerificationCode;

-(void)setInitialParameter;

-(void)resetData;
-(void)resignResponder;
-(BOOL)checkEnteredData;
-(IBAction)btnTappedDelivered:(id)sender;
-(void)openThankYouPage;

-(IBAction)btnTappedBack:(id)sender;

@end
