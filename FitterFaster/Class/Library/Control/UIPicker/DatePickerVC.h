//
//  DatePickerVC.h
//  Donna Bella
//
//  Created by WebInfoways on 18/02/14.
//  Copyright (c) 2014 Nishant. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewChangeDelegate

@optional

-(void)onSelect:(int)pintPickerOptionId withDate:(NSDate *)pdtSelectedDate;

@end

@interface DatePickerVC : UIViewController <DatePickerViewChangeDelegate>
{
    id parent;
    
	IBOutlet UIButton *btnDone;
	IBOutlet UIButton *btnClose;
	
	IBOutlet UIButton *btnNext;
	IBOutlet UIButton *btnPrev;
}
@property(nonatomic, retain) NSString *strDate;
@property(nonatomic, retain) NSString *strDateFormat;
@property(nonatomic, retain) NSString *strDateDisplayFormat;
@property(nonatomic) int intInputTagId;
@property(nonatomic) int intPickerOptionId;

@property(nonatomic, retain) IBOutlet UIDatePicker *datePicker;

@property(nonatomic, retain) IBOutlet UIButton *btnDone;
@property(nonatomic, retain) IBOutlet UIButton *btnClose;

@property(nonatomic, retain) IBOutlet UIButton *btnNext;
@property(nonatomic, retain) IBOutlet UIButton *btnPrev;

@property (nonatomic, assign) id <DatePickerViewChangeDelegate> delegate;


- (id)initWithNibNameAndData:(NSString *)pstrDate withDateFormat:(NSString *)pstrDateFormat withDateDisplayFormat:(NSString *)pstrDateDisplayFormat withID:(id)pId withPickerOptionID:(id)pPickerOptionId withButtonTag:(int)pintTag;

-(IBAction)btnTappedDone:(id)sender;

@end
