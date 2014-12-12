//
//  MenuView.m
//  
//
//  Created by WebInfoways on 11/03/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "MenuView.h"
#import "AddressViewController.h"

@implementation MenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - Set Parent
-(void)setParent:(id)pID appDelegate:(AppDelegate*)pAppDelegate viewController:(UIViewController*)pViewController
{
    _parent = pID;
    _appDelegate = pAppDelegate;
    _parentController = pViewController;
}

#pragma mark - Button Tapped Menu
-(IBAction)btnTappedMenu:(id)sender
{
    [_parent closeMenu];
    
    
    WebPageViewController *objWebPageViewController;
    objWebPageViewController = [[[WebPageViewController alloc] initWithNibName:@"WebPageViewController" bundle:nil] autorelease];
    
    /*
     if(g_IS_IPHONE_6PLUS_SCREEN)
        objWebPageViewController = [[[WebPageViewController alloc] initWithNibName:@"WebPageViewController6P" bundle:nil] autorelease];
     else if(g_IS_IPHONE_6_SCREEN)
        objWebPageViewController = [[[WebPageViewController alloc] initWithNibName:@"WebPageViewController6" bundle:nil] autorelease];
     else if(g_IS_IPHONE_5_SCREEN)
        objWebPageViewController = [[[WebPageViewController alloc] initWithNibName:@"WebPageViewController" bundle:nil] autorelease];
     else if(g_IS_IPHONE_4_SCREEN)
        objWebPageViewController = [[[WebPageViewController alloc] initWithNibName:@"WebPageViewController4" bundle:nil] autorelease];
     //else if(g_IS_IPAD)
        //objWebPageViewController = [[[WebPageViewController alloc] initWithNibName:@"WebPageViewControlleriPad" bundle:nil] autorelease];
     else
        objWebPageViewController = [[[WebPageViewController alloc] initWithNibName:@"WebPageViewController4" bundle:nil] autorelease];
     */
    
    switch ([sender tag]) {
        case 1: //About
            objWebPageViewController.strPageTitle = g_AboutUsTitle;
            objWebPageViewController.strPageUrl = g_AboutUsUrl;
            break;
        case 2: //Terms
            objWebPageViewController.strPageTitle = g_TermsOfUseTitle;
            objWebPageViewController.strPageUrl = g_TermsOfUseUrl;
            break;
        case 3: //Contact
            objWebPageViewController.strPageTitle = g_ContactTitle;
            objWebPageViewController.strPageUrl = g_ContactUrl;
            break;
        case 4: //EditProfile
            objWebPageViewController.strPageTitle = g_EditProfileTitle;
            objWebPageViewController.strPageUrl = g_EditProfileUrl;
            break;
        default:
            objWebPageViewController.strPageTitle = g_AboutAppTitle;
            objWebPageViewController.strPageUrl = g_AboutAppUrl;
            break;
    }
    
    [_parentController.navigationController pushViewController:objWebPageViewController animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

/*
- (void)dealloc {
    [_btnAbout release];
    [_btnTerms release];
    [_btnContact release];
    [_btnEditProfile release];
    
    [super dealloc];
}*/

@end
