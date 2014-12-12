//
//  TermsViewController.h
//  GW Whiteboard
//
//  Created by WebInfoways on 05/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TermsViewController : UIViewController
{
    AppDelegate *appDelegate;
}
@property(nonatomic,retain) NSString *strPageTitle;
@property(nonatomic,retain) NSString *strPageUrl;

@property(nonatomic,retain) IBOutlet UILabel *lblTitle;
@property(nonatomic,retain) IBOutlet UITextView *txtContent;

-(void)initializePageData;
-(void)displayContent;

-(IBAction)btnTappedAccept:(id)sender;
-(IBAction)btnTappedReject:(id)sender;

-(IBAction)btnTappedBack:(id)sender;

@end
