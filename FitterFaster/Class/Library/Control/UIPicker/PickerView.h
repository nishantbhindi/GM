//
//  PickerView.h
//  iOSCodeStructure
//
//  Created by Nishant on 08/02/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerView : UIView
{
    IBOutlet UIDatePicker *datePicker;
    
	IBOutlet UIButton *btnDone;
	IBOutlet UIButton *btnClose;
	IBOutlet UIButton *btnNext;
	IBOutlet UIButton *btnPrev;
}
@property(nonatomic, retain)UIDatePicker *datePicker;

@property(nonatomic, retain)UIButton *btnDone;
@property(nonatomic, retain)UIButton *btnClose;
@property(nonatomic, retain)UIButton *btnNext;
@property(nonatomic, retain)UIButton *btnPrev;

@end
