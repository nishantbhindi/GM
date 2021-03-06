//
//  PickerVC.h
//  My Project
//
//  Created by WebInfoways on 04/04/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerViewChangeDelegate

@optional

-(void)onChange:(int)pintIndexNo withValue:(NSString *)pstrValue withInputTagId:(int)pintTag;

@end

@interface PickerVC : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, PickerViewChangeDelegate>
{
    id parent;
    
    NSMutableArray *arrPickerData;
    int intSelectedIndexNo;
    NSString *strSelectedIndexValue;
    int intInputTagId;
    
	IBOutlet UIPickerView *picOption;
    
	IBOutlet UIButton *btnDone;
	IBOutlet UIButton *btnClose;
	
	IBOutlet UIButton *btnNext;
	IBOutlet UIButton *btnPrev;
}
@property(nonatomic, retain) NSMutableArray *arrPickerData;
@property(nonatomic) int intSelectedIndexNo;
@property(nonatomic, retain) NSString *strSelectedIndexValue;
@property(nonatomic) int intInputTagId;

@property(nonatomic, retain)UIPickerView *picOption;

@property(nonatomic, retain)UIButton *btnDone;
@property(nonatomic, retain)UIButton *btnClose;

@property(nonatomic, retain)UIButton *btnNext;
@property(nonatomic, retain)UIButton *btnPrev;

@property (nonatomic, assign) id <PickerViewChangeDelegate> delegate;


- (id)initWithNibNameAndData:(NSMutableArray *)parrData withSelectedID:(int)pintSelectedId withID:(id)pId withButtonTag:(int)pintTag;

@end
