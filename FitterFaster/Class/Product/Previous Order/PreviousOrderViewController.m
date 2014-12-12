//
//  PreviousOrderViewController.m
//  GW Whiteboard
//
//  Created by WebInfoways on 06/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "PreviousOrderViewController.h"

@interface PreviousOrderViewController ()

@end

@implementation PreviousOrderViewController

@synthesize bolIsDataFetched,intPageNo,arrProduct;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setInitialParameter];
}

#pragma mark - Initialize Page Data
-(void)setInitialParameter{
    [self resetData];
    
    self.arrProduct = [[NSMutableArray alloc] init];
    //[_tblProduct reloadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    if(!self.bolIsDataFetched)
        [self fetchPreviousOrder];
}
- (void)viewDidDisappear:(BOOL)animated
{
}

#pragma mark - Reset
-(void)resetData{
    self.intPageNo = 1;
}

#pragma mark - Fetch Products
-(void)fetchPreviousOrder{
    if(self.arrProduct.count>0)
        [self.arrProduct removeAllObjects];
    
    [FunctionManager displayLoadingView:self.view withMessage:msgLoadingGeneral appDelegate:appDelegate viewController:self];
    
    NSURL *baseURL = [NSURL URLWithString:g_WebserviceUrl];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"method"] = @"getPreviousOrderProductList";
    
    parameters[@"userid"] = [NSString stringWithFormat:@"%d", appDelegate.objUser.intUserID];
    //parameters[@"userid"] = [NSString stringWithFormat:@"%d", 3];
    
    parameters[@"address_type"] = appDelegate.objUser.strAddressType;
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:g_Pagename_Api parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        
        //NSLog(@"JSON: %@", responseObject);
        [self checkProductResponse:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        [FunctionManager showMessage:@"" withMessage:[error localizedDescription] withDelegage:nil];
        //NSLog(@"ERROR: %@", [error localizedDescription]);
    }];
}
-(void)checkProductResponse:(NSDictionary *)pdicResponse{
    if([pdicResponse isKindOfClass:[NSDictionary class]])
    {
        self.bolIsDataFetched = TRUE;
        NSString *strCurr = (NSString*)[pdicResponse objectForKey:@"currency_symbol"];
        
        NSArray *arrProducts = (NSArray*)[pdicResponse objectForKey:@"product_list"];
        for(int i=0;i<arrProducts.count;i++){
            NSDictionary *dicProduct = [arrProducts objectAtIndex:i];
            
            Product *objProduct = [[Product alloc] init];
            objProduct.intProductID = [[dicProduct objectForKey:@"product_id"] intValue];
            objProduct.strTitle = [dicProduct objectForKey:@"name"];
            objProduct.strPrice = [dicProduct objectForKey:@"price"];
            
            objProduct.strCurrency = strCurr;
            objProduct.intCartQty = 0;
            
            objProduct.strIsPrevOrder = [dicProduct objectForKey:@"previous_order"];
            objProduct.strDesc = [dicProduct objectForKey:@"short_description"];
            
            objProduct.strVolume = [dicProduct objectForKey:@"alcohol_by_volume"];
            objProduct.strServing = [dicProduct objectForKey:@"units_per_serving"];
            objProduct.strSize = [dicProduct objectForKey:@"size"];
            objProduct.strPhotoUrl = [dicProduct objectForKey:@"image_url"];
            [self.arrProduct addObject:objProduct];
        }
    }
    
    [_tblProduct reloadData];
}

#pragma mark - UITableView Delegete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 270.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger intTotalRow = ([self.arrProduct count]%2==0) ? [self.arrProduct count]/2 : ([self.arrProduct count]/2)+1;
    return intTotalRow;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
    ProductCell *cell = (ProductCell *)[tableView dequeueReusableCellWithIdentifier: CustomCellIdentifier];
    
    if(cell==nil || ![cell isKindOfClass:[ProductCell class]])
    {
        NSArray* nib;
        if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN))
            nib = [[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:self options:nil];
        else
            nib = [[NSBundle mainBundle] loadNibNamed:@"ProductCell_iPad" owner:self options:nil];
        
        for (id oneObject in nib) if ([oneObject isKindOfClass:[ProductCell class]])
            cell = (ProductCell *)oneObject;
        
        //cell = [nib objectAtIndex:0];
        cell.showsReorderControl = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];   //darkGrayColor
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    
    int objNo = indexPath.row*2;
    
    if(objNo < [self.arrProduct count])
    {
        Product *objProductTmp = [self.arrProduct objectAtIndex:objNo];
        
        if(objProductTmp.imgPhoto)
            cell.imgPhoto1.image = objProductTmp.imgPhoto;
        else
        {
            //cell.imgPhoto1.image = [UIImage imageNamed:@"img_no_image.png"];
            
            dispatch_queue_t imageQ = dispatch_queue_create("imageQ", NULL);
            dispatch_async(imageQ, ^{
                NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:objProductTmp.strPhotoUrl]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(imageData){
                        //objProductTmp.imgPhoto = [UIImage imageWithData:imageData];
                        UIImage *imgTmp = [UIImage imageWithData:imageData];
                        
                        //UIImage *imgTemp = [FunctionManager imageScaleAndCropWithFixWidth:imgTmp withWidth:cell.imgPhoto1.frame.size.width*2];
                        UIImage *imgTemp = [FunctionManager imageScaleAndCropWithFixWidth:imgTmp withWidth:cell.imgPhoto1.frame.size.width];
                        objProductTmp.imgPhoto = imgTemp;
                        
                        [_tblProduct reloadData];
                        //[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }
                });
            });
            dispatch_release(imageQ);
        }
        
        cell.lblName1.text = objProductTmp.strTitle;
        cell.lblPrice1.text = [NSString stringWithFormat:@"%@%.2f", objProductTmp.strCurrency, [objProductTmp.strPrice floatValue]];
        //cell.lblPrice1.text = objProductTmp.strPrice;
        
        cell.lblVolume1.text = objProductTmp.strVolume;
        cell.lblServing1.text = objProductTmp.strServing;
        cell.lblSize1.text = objProductTmp.strSize;
        cell.lblDesc1.text = objProductTmp.strDesc;
        
        if([objProductTmp.strIsPrevOrder isEqualToString:@"P"] || [objProductTmp.strIsPrevOrder isEqualToString:@"p"])
            cell.imgPrevOrder1.hidden = FALSE;
        else
            cell.imgPrevOrder1.hidden = TRUE;
        
        cell.txtQty1.text = [NSString stringWithFormat:@"%d", objProductTmp.intCartQty];
        cell.txtQty1.delegate = self;
        [cell.txtQty1 setTag:objNo];
        [cell.txtQty1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        cell.txtQty1.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        
        [cell.btnAddToCart1 setTag:objNo];
        [cell.btnAddToCart1 addTarget:self action:@selector(btnTappedAddToCart:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if((objNo+1) < [self.arrProduct count])
    {
        Product *objProductTmp2 = [self.arrProduct objectAtIndex:objNo+1];
        
        if(objProductTmp2.imgPhoto)
            cell.imgPhoto2.image = objProductTmp2.imgPhoto;
        else
        {
            //cell.imgPhoto2.image = [UIImage imageNamed:@"img_no_image.png"];
            
            dispatch_queue_t imageQ = dispatch_queue_create("imageQ", NULL);
            dispatch_async(imageQ, ^{
                NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:objProductTmp2.strPhotoUrl]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(imageData){
                        //objProductTmp2.imgPhoto = [UIImage imageWithData:imageData];
                        UIImage *imgTmp = [UIImage imageWithData:imageData];
                        
                        //UIImage *imgTemp = [FunctionManager imageScaleAndCropWithFixWidth:imgTmp withWidth:cell.imgPhoto2.frame.size.width*2];
                        UIImage *imgTemp = [FunctionManager imageScaleAndCropWithFixWidth:imgTmp withWidth:cell.imgPhoto2.frame.size.width];
                        objProductTmp2.imgPhoto = imgTemp;
                        
                        [_tblProduct reloadData];
                        //[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }
                });
            });
            dispatch_release(imageQ);
        }
        
        cell.lblName2.text = objProductTmp2.strTitle;
        cell.lblPrice2.text = [NSString stringWithFormat:@"%@%.2f", objProductTmp2.strCurrency, [objProductTmp2.strPrice floatValue]];
        //cell.lblPrice2.text = objProductTmp2.strPrice;
        
        cell.lblVolume2.text = objProductTmp2.strVolume;
        cell.lblServing2.text = objProductTmp2.strServing;
        cell.lblSize2.text = objProductTmp2.strSize;
        cell.lblDesc2.text = objProductTmp2.strDesc;
        
        if([objProductTmp2.strIsPrevOrder isEqualToString:@"P"] || [objProductTmp2.strIsPrevOrder isEqualToString:@"p"])
            cell.imgPrevOrder2.hidden = FALSE;
        else
            cell.imgPrevOrder2.hidden = TRUE;
        
        cell.txtQty2.text = [NSString stringWithFormat:@"%d", objProductTmp2.intCartQty];
        cell.txtQty2.delegate = self;
        [cell.txtQty2 setTag:objNo+1];
        [cell.txtQty2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        cell.txtQty2.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        
        [cell.btnAddToCart2 setTag:objNo+1];
        [cell.btnAddToCart2 addTarget:self action:@selector(btnTappedAddToCart:) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        [cell.view2 setHidden:TRUE];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark Add To Cart
- (IBAction)btnTappedAddToCart:(id)sender{
    Product *objProductTmp = [self.arrProduct objectAtIndex:[sender tag]];
    //NSLog(@"Cart Qty: %d", objProductTmp.intCartQty);
    
    
    [FunctionManager displayLoadingView:self.view withMessage:msgLoadingGeneral appDelegate:appDelegate viewController:self];
    
    NSURL *baseURL = [NSURL URLWithString:g_WebserviceUrl];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"method"] = @"cartCreate";
    
    parameters[@"userid"] = [NSString stringWithFormat:@"%d", appDelegate.objUser.intUserID];
    parameters[@"product_id"] = [NSString stringWithFormat:@"%d", objProductTmp.intProductID];
    parameters[@"qty"] = [NSString stringWithFormat:@"%d", objProductTmp.intCartQty];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:g_Pagename_Api parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        
        //NSLog(@"JSON: %@", responseObject);
        [self checkAddToCartResponse:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        [FunctionManager showMessage:@"" withMessage:[error localizedDescription] withDelegage:nil];
        //NSLog(@"ERROR: %@", [error localizedDescription]);
    }];
}
-(void)checkAddToCartResponse:(NSDictionary *)pdicResponse{
    //int success = [[pdicResponse objectForKey:@"status"] intValue];
    [FunctionManager showMessage:@"" withMessage:[pdicResponse objectForKey:@"message"] withDelegage:nil];
    [_tblProduct reloadData];
}

/*
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        NSLog(@"1 = Load New Records");
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (([scrollView contentOffset].y + scrollView.frame.size.height) >= [scrollView contentSize].height){
        NSLog(@"2 = Load New Records");
 
        //self.intPageNo = self.intPageNo + 1;
        //[self fetchBlogList];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
 //    if (([scrollView contentOffset].y + scrollView.frame.size.height) >= [scrollView contentSize].height){
 //        // Get new record from here
 //        DLog(@"OffSet Y = %f", [scrollView contentOffset].y);
 //        DLog(@"Scroll Frame Height = %f", scrollView.frame.size.height);
 //        DLog(@"Scroll Content Height = %f", [scrollView contentSize].height);
 //
 //        DLog(@"Load New Records");
 //
 //        self.intPageNo = self.intPageNo + 1;
 //        [self fetchBlogList];
 //    }
}
*/


#pragma mark TextField Delegate Methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    /*
     NSLog(@"Index = %ld", (long)[textField tag]);
     NSLog(@"Qty Changed: %@", textField.text);
     
     Product *objProductTmp = [self.arrProduct objectAtIndex:[textField tag]];
     objProductTmp.intCartQty = [textField.text intValue];
     [_tblProduct reloadData];
    */
    [_tblProduct reloadData];
    
    /*
     [self.tblCart beginUpdates];
     [self.tblCart reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:[theTextField tag] inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
     [self.tblCart endUpdates];
     */
    
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *unacceptedInput = nil;
    unacceptedInput = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
    
    if([[string componentsSeparatedByCharactersInSet:unacceptedInput] count] <= 1)
        return YES;
    else
        return NO;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    /*if([textField.text isEmptyString]){
        textField.text = @"0";
     }*/
    return YES;
}
-(void)textFieldDidChange :(UITextField *)theTextField{
    if([theTextField.text isEmptyString]){
        theTextField.text = @"0";
    }
    
    //NSLog(@"Index = %ld", (long)[theTextField tag]);
    //NSLog(@"Qty Changed: %@", theTextField.text);
    
    Product *objProductTmp = [self.arrProduct objectAtIndex:[theTextField tag]];
    objProductTmp.intCartQty = [theTextField.text intValue];
    //[_tblProduct reloadData];
}

#pragma mark - Button Tapped Confirm Order
-(IBAction)btnTappedConfirmOrder:(id)sender{
    CartViewController *objCartViewController;
    objCartViewController = [[[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil] autorelease];
    
    /*
     if(g_IS_IPHONE_6PLUS_SCREEN)
        objCartViewController = [[[CartViewController alloc] initWithNibName:@"CartViewController6P" bundle:nil] autorelease];
     else if(g_IS_IPHONE_6_SCREEN)
        objCartViewController = [[[CartViewController alloc] initWithNibName:@"CartViewController6" bundle:nil] autorelease];
     else if(g_IS_IPHONE_5_SCREEN)
        objCartViewController = [[[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil] autorelease];
     else if(g_IS_IPHONE_4_SCREEN)
        objCartViewController = [[[CartViewController alloc] initWithNibName:@"CartViewController4" bundle:nil] autorelease];
     //else if(g_IS_IPAD)
        //objCartViewController = [[[CartViewController alloc] initWithNibName:@"CartViewControlleriPad" bundle:nil] autorelease];
     else
        objCartViewController = [[[CartViewController alloc] initWithNibName:@"CartViewController4" bundle:nil] autorelease];
     */
    
    //objCartViewController.imgPhotoPreview = imgPhotoToShare;
    [self.navigationController pushViewController:objCartViewController animated:YES];
}

#pragma mark - Button Tapped Back
-(IBAction)btnTappedBack:(id)sender{
    [FunctionManager gotoBack:self];
}

#pragma mark - Button Tapped Menu
#pragma mark Set Menu
-(void)setMenu{
    _viewMenu = [[[NSBundle mainBundle] loadNibNamed:@"MenuView" owner:self options:nil]objectAtIndex:0];
    
    [_viewMenu setFrame:CGRectMake(self.view.frame.size.width-(_viewMenu.frame.size.width+10.0), 50.0, _viewMenu.frame.size.width, _viewMenu.frame.size.height)];
    [_viewMenu setParent:self appDelegate:appDelegate viewController:self];
    _viewMenu.layer.borderColor = [UIColor clearColor].CGColor;
    _viewMenu.layer.borderWidth = 3.0f;
    [self.view addSubview:_viewMenu];
    [_viewMenu setHidden:TRUE];
}
#pragma mark Open/Close Menu
-(IBAction)btnTappedMenu:(id)sender{
    //    if(_viewMenu)
    //        [_viewMenu release];
    [self setMenu];
    
    [KGModal sharedInstance].showCloseButton = FALSE;
    _viewMenu.hidden = NO;
    [[KGModal sharedInstance] showWithContentView:_viewMenu andAnimated:YES];
}
-(void)closeMenu{
    [[KGModal sharedInstance] closeAction:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Orientations
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    if(self.arrProduct.count>0)
        [self.arrProduct removeAllObjects];
    [self.arrProduct release];
    
    [_tblProduct release];
    
    [super dealloc];
}

@end
