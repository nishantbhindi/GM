//
//  HomeViewController.h
//  GW Whiteboard
//
//  Created by WebInfoways on 13/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartViewController.h"
#import "PreviousOrderViewController.h"
#import "MenuView.h"

#import "Product.h"
#import "ProductCell.h"

@class AppDelegate;

@interface HomeViewController : UIViewController <UITextFieldDelegate>
{
    AppDelegate *appDelegate;
}
@property (nonatomic,retain) NSMutableArray *arrCategory;
@property (nonatomic) int intSelectedCatIndex;
@property (nonatomic,retain) IBOutlet UIScrollView *scrCategory;

@property (nonatomic) BOOL bolIsDataFetched;
@property (nonatomic) int intPageNo;
@property (nonatomic,retain) NSMutableArray *arrProduct;
@property (nonatomic,retain) IBOutlet UITableView *tblProduct;

@property (nonatomic, retain) MenuView *viewMenu;

-(void)setInitialParameter;
-(void)resetData;

-(void)bindCategory;
-(void)fetchProducts;

-(IBAction)btnTappedConfirmOrder:(id)sender;

-(IBAction)btnTappedPreviousOrder:(id)sender;

-(IBAction)btnTappedBack:(id)sender;

-(IBAction)btnTappedMenu:(id)sender;
-(void)closeMenu;

@end
