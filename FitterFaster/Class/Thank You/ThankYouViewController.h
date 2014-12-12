//
//  ThankYouViewController.h
//  GW Whiteboard
//
//  Created by WebInfoways on 05/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface ThankYouViewController : UIViewController
{
    AppDelegate *appDelegate;
}
@property (nonatomic,retain) NSString *strDeliveryMessage;
@property (nonatomic,retain) IBOutlet UILabel *lblDeliveryMessage;

-(void)setInitialParameter;

-(IBAction)btnTappedRateAppStore:(id)sender;
-(IBAction)btnTappedRatePlayStore:(id)sender;

-(IBAction)btnTappedBack:(id)sender;

@end
