//
//  MenuView.h
//  
//
//  Created by WebInfoways on 11/03/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebPageViewController.h"

@class AppDelegate;

@interface MenuView : UIView
{
    id _parent;
    AppDelegate *_appDelegate;
    UIViewController *_parentController;
}
@property(nonatomic,retain) IBOutlet UIButton *btnAbout;
@property(nonatomic,retain) IBOutlet UIButton *btnTerms;
@property(nonatomic,retain) IBOutlet UIButton *btnContact;
@property(nonatomic,retain) IBOutlet UIButton *btnEditProfile;

-(void)setParent:(id)pID appDelegate:(AppDelegate*)pAppDelegate viewController:(UIViewController*)pViewController;

-(IBAction)btnTappedMenu:(id)sender;

@end
