//
//  CategoryViewController.h
//  GW Whiteboard
//
//  Created by WebInfoways on 02/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "PreviousOrderViewController.h"
#import "MenuView.h"

#import "CategoryCell.h"

@class AppDelegate;

@interface CategoryViewController : UIViewController
{
    AppDelegate *appDelegate;
}
@property (nonatomic) BOOL bolIsDataFetched;
@property (nonatomic,retain) NSMutableArray *arrCategory;
@property (nonatomic,retain) IBOutlet UITableView *tblCategory;

@property (nonatomic, retain) MenuView *viewMenu;

-(void)setInitialParameter;
-(void)resetData;

-(void)fetchCategory;

-(IBAction)btnTappedPreviousOrder:(id)sender;

-(IBAction)btnTappedBack:(id)sender;

-(IBAction)btnTappedMenu:(id)sender;
-(void)closeMenu;

@end
