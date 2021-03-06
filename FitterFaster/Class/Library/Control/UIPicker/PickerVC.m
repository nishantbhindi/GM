//
//  PickerVC.m
//  My Project
//
//  Created by WebInfoways on 04/04/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import "PickerVC.h"

@interface PickerVC ()

@end

@implementation PickerVC

@synthesize arrPickerData, intSelectedIndexNo, strSelectedIndexValue, intInputTagId;
@synthesize picOption;
@synthesize btnDone, btnClose, btnNext, btnPrev;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithNibNameAndData:(NSMutableArray *)parrData withSelectedID:(int)pintSelectedId withID:(id)pId withButtonTag:(int)pintTag
{
	self.arrPickerData=parrData;
    self.intSelectedIndexNo=pintSelectedId;
    self.intInputTagId = pintTag;
    parent=pId;
    
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
    
    [picOption reloadAllComponents];
    [picOption selectRow:self.intSelectedIndexNo inComponent:0 animated:NO];
}

#pragma mark - Picker delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.intSelectedIndexNo = row;
    self.strSelectedIndexValue = [self.arrPickerData objectAtIndex:row];
    
    /*if([self.delegate respondsToSelector:@selector(onChange:withValue:)])
     {
        //[self.delegate onChange:[NSString stringWithFormat:@"Selected row %d", row]];
        [self.delegate onChange:self.intSelectedIndexNo withValue:self.strSelectedIndexValue];
     }*/
    
    [self.delegate onChange:self.intSelectedIndexNo withValue:self.strSelectedIndexValue withInputTagId:self.intInputTagId];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [self.arrPickerData count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [self.arrPickerData objectAtIndex:row];
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

- (void)dealloc
{
	[btnDone release];
	[btnClose release];
	[btnNext release];
	[btnPrev release];
	
    [arrPickerData release];
    [strSelectedIndexValue release];
    
    [picOption release];
    
    [super dealloc];
}

@end
