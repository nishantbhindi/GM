//
//  TermsViewController.m
//  GW Whiteboard
//
//  Created by WebInfoways on 05/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "TermsViewController.h"

@interface TermsViewController ()

@end

@implementation TermsViewController

@synthesize strPageTitle,strPageUrl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self initializePageData];
    //[self setPageData:self withTitle:g_WebPageTitle_Shop withURL:g_WebPageUrl_Shop];
}
-(void)viewWillAppear:(BOOL)animated {
    [self displayContent];
}
- (void)viewWillDisappear:(BOOL)animated
{
}

#pragma mark - Initialize Page Data
-(void)initializePageData{
}

#pragma mark - Display Content
-(void)displayContent{
    _lblTitle.text = self.strPageTitle;
    //_lblTitle.text = [self.strPageTitle uppercaseString];
    //_txtContent.text = @"";
}

#pragma mark - Button Tapped Accept/Reject
-(IBAction)btnTappedAccept:(id)sender{
    appDelegate.bolIsAcceptTerms = TRUE;
    [self btnTappedBack:nil];
}
-(IBAction)btnTappedReject:(id)sender{
    appDelegate.bolIsAcceptTerms = FALSE;
    [self btnTappedBack:nil];
}

#pragma mark - Button Tapped Back
-(IBAction)btnTappedBack:(id)sender{
    [FunctionManager gotoBack:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Orientations
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [self.strPageTitle release];
    [self.strPageUrl release];
    
    [_lblTitle release];
    [_txtContent release];
    
    [super dealloc];
}

@end
