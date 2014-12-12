//
//  WebPageViewController.h
//  TrueLocation
//
//  Created by WebInfoways on 16/06/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface WebPageViewController : UIViewController <UIWebViewDelegate>
{
    AppDelegate *appDelegate;
}
@property(nonatomic,retain) NSString *strPageTitle;
@property(nonatomic,retain) NSString *strPageUrl;

@property(nonatomic,retain) IBOutlet UILabel *lblTitle;
@property(nonatomic,retain) IBOutlet UIWebView *webviewPage;

-(void)initializePageData;
-(void)openWebPage;

-(IBAction)btnTappedBack:(id)sender;

-(IBAction)displayLeftMenu:(id)sender;

@end
