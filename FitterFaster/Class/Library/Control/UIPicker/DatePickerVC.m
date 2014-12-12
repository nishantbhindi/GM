//
//  DatePickerVC.m
//  Donna Bella
//
//  Created by WebInfoways on 18/02/14.
//  Copyright (c) 2014 Nishant. All rights reserved.
//

#import "DatePickerVC.h"

@interface DatePickerVC ()

@end

@implementation DatePickerVC

@synthesize strDate, strDateFormat, strDateDisplayFormat;
@synthesize intInputTagId, intPickerOptionId;
@synthesize datePicker, delegate;
@synthesize btnDone, btnClose, btnNext, btnPrev;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithNibNameAndData:(NSString *)pstrDate withDateFormat:(NSString *)pstrDateFormat withDateDisplayFormat:(NSString *)pstrDateDisplayFormat withID:(id)pId withPickerOptionID:(id)pPickerOptionId withButtonTag:(int)pintTag
{
	self.strDate = pstrDate;
    self.strDateFormat = pstrDateFormat;
    self.strDateDisplayFormat = pstrDateDisplayFormat;
    
    self.intInputTagId = pintTag;
    self.intPickerOptionId = pPickerOptionId;
    parent=pId;
    
    if(self.intPickerOptionId==1){
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.date = [NSDate date];
    }
    else{
        datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        datePicker.date = [NSDate date];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.btnDone setTag:self.intInputTagId];
    [self.btnClose setTag:self.intInputTagId];
	[self.btnNext setTag:self.intInputTagId];
	[self.btnPrev setTag:self.intInputTagId];
    
    [self.btnDone addTarget:parent action:@selector(btnTappedDone:) forControlEvents:UIControlEventTouchUpInside];
	[self.btnClose addTarget:parent action:@selector(btnTappedClose:) forControlEvents:UIControlEventTouchUpInside];
	[self.btnNext addTarget:parent action:@selector(btnTappedNext:) forControlEvents:UIControlEventTouchUpInside];
	[self.btnPrev addTarget:parent action:@selector(btnTappedPrev:) forControlEvents:UIControlEventTouchUpInside];
    
    //[picOption reloadAllComponents];
    //[picOption selectRow:self.intSelectedIndexNo inComponent:0 animated:NO];
}
- (void)viewWillAppear:(BOOL)animated
{
    if(![self.strDate isEmptyString])
        [datePicker setDate:[FunctionManager getDateFromString:self.strDate withFormat:self.strDateFormat] animated:YES];
}

-(IBAction)btnTappedDone:(id)sender
{
    //[self.delegate onSelect:self.intPickerOptionId withDate:[datePicker date]];
    //NSString *strDtTmp = [FunctionManager getStringFromDate:[datePicker date] withFormat:g_DateTimeFormatDefault];
    
    //NSString *strDt = [FunctionManager getFormatedDate:[[datePicker date] description] withDateFormat:g_DateTimeFormatDefaultZone withDisplayFormat:g_DateFormatDisplay2];
    //[self.delegate onSelect:self.intPickerOptionId withDate:strDt];
    
    [self.delegate onSelect:self.intPickerOptionId withDate:[datePicker date]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Orientations
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc
{
    [self.strDate release];
    [self.strDateFormat release];
    [self.strDateDisplayFormat release];
    
	[btnDone release];
	[btnClose release];
	[btnNext release];
	[btnPrev release];
    
    [datePicker release];
    
    [super dealloc];
}

@end
