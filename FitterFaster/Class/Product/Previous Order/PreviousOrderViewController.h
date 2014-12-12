//
//  PreviousOrderViewController.h
//  GW Whiteboard
//
//  Created by WebInfoways on 06/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartViewController.h"
#import "MenuView.h"

#import "Product.h"
#import "ProductCell.h"

@class AppDelegate;

@interface PreviousOrderViewController : UIViewController <UITextFieldDelegate>
{
    AppDelegate *appDelegate;
}
@property (nonatomic) BOOL bolIsDataFetched;
@property (nonatomic) int intPageNo;
@property (nonatomic,retain) NSMutableArray *arrProduct;
@property (nonatomic,retain) IBOutlet UITableView *tblProduct;

@property (nonatomic, retain) MenuView *viewMenu;

-(void)setInitialParameter;
-(void)resetData;

-(void)fetchPreviousOrder;

-(IBAction)btnTappedConfirmOrder:(id)sender;

-(IBAction)btnTappedBack:(id)sender;

-(IBAction)btnTappedMenu:(id)sender;
-(void)closeMenu;

@end
