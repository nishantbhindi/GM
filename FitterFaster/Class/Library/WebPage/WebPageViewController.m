//
//  WebPageViewController.m
//  TrueLocation
//
//  Created by WebInfoways on 16/06/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "WebPageViewController.h"

@interface WebPageViewController ()

@end

@implementation WebPageViewController

@synthesize strPageTitle,strPageUrl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self initializePageData];
    //[self setPageData:self withTitle:g_WebPageTitle_Shop withURL:g_WebPageUrl_Shop];
}
-(void)viewWillAppear:(BOOL)animated {
    [self openWebPage];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_webviewPage stopLoading];
    //[FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
}

#pragma mark - Initialize Page Data
-(void)initializePageData{
    [FunctionManager stopWebViewBounce:_webviewPage];
    //[_webviewPage setOpaque:YES];
}

#pragma mark - Open Web Page
-(void)openWebPage{
    //_lblTitle.text = [self.strPageTitle uppercaseString];
    _lblTitle.text = self.strPageTitle;
    [FunctionManager openUrlinApp:_webviewPage withStringUrl:self.strPageUrl];
}

#pragma mark - webView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [FunctionManager displayLoadingView:self.view withMessage:msgLoadingGeneral appDelegate:appDelegate viewController:self];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	return YES;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [FunctionManager webviewFailToLoad:_webviewPage withError:error];
    [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
}

#pragma mark - Button Tapped Back
-(IBAction)btnTappedBack:(id)sender{
    [FunctionManager gotoBack:self];
}
#pragma mark - Click On Menu Items
-(IBAction)displayLeftMenu:(id)sender
{
    //[self.slidingViewController anchorTopViewTo:ECRight];
}

#pragma mark - Orientations
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self.strPageTitle release];
    [self.strPageUrl release];
    
	[_lblTitle release];
	[_webviewPage release];
    
    [super dealloc];
}

@end
