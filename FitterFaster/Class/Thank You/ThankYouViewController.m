//
//  ThankYouViewController.m
//  GW Whiteboard
//
//  Created by WebInfoways on 05/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "ThankYouViewController.h"

@interface ThankYouViewController ()

@end

@implementation ThankYouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setInitialParameter];
}
- (void)viewWillAppear:(BOOL)animated
{
}

#pragma mark - Initialize Page Data
-(void)setInitialParameter
{
    //_lblDeliveryMessage.text = self.strDeliveryMessage;
}

#pragma mark - Button Tapped Verification
#pragma mark App Store
-(IBAction)btnTappedRateAppStore:(id)sender{
    [FunctionManager rateApplication:g_AppId];
}
#pragma mark Play Store
-(IBAction)btnTappedRatePlayStore:(id)sender{
    [FunctionManager openUrlinSafari:g_AppUrlAndroid];
}

#pragma mark - Button Tapped Back
-(IBAction)btnTappedBack:(id)sender{
    //[FunctionManager gotoBack:self];
    [FunctionManager gotoBackWithIndex:self withIndexNo:4];
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
    [self.strDeliveryMessage release];
    [_lblDeliveryMessage release];
    
    [super dealloc];
}

@end
