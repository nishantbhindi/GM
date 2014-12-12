//
//  PickerView.m
//  iOSCodeStructure
//
//  Created by Nishant on 08/02/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import "PickerView.h"

@implementation PickerView

@synthesize datePicker;
@synthesize btnDone, btnClose, btnNext, btnPrev;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
	[datePicker release];
    
	[btnDone release];
	[btnClose release];
	[btnNext release];
	[btnPrev release];
	
    [super dealloc];
}

@end
