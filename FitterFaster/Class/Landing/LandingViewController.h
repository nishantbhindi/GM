//
//  LandingViewController.h
//  GW Whiteboard
//
//  Created by WebInfoways on 13/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LandingViewController : UIViewController <UIScrollViewDelegate> {
    NSTimer *autoTimer;
    BOOL bolPageControlUsed;
}
@property (nonatomic, retain) NSArray *arrPages;
@property (nonatomic, retain) IBOutlet UIScrollView *scrPage;
@property (nonatomic, retain) IBOutlet UIPageControl *pgControl;

-(void)setInitialParameter;

-(void)initializeScroll;
-(IBAction)changePageControl:(id)sender;

-(IBAction)btnTappedSurvey:(id)sender;

@end
