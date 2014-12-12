//
//  CategoryViewController.m
//  GW Whiteboard
//
//  Created by WebInfoways on 02/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

@synthesize arrCategory;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setInitialParameter];
}

#pragma mark - Initialize Page Data
-(void)setInitialParameter{
    [self resetData];
}
- (void)viewWillAppear:(BOOL)animated
{
    if(!self.bolIsDataFetched)
        [self fetchCategory];
}
- (void)viewDidDisappear:(BOOL)animated
{
}

#pragma mark - Reset
-(void)resetData{
}

#pragma mark - Fetch Products
-(void)fetchCategory{
    if(self.arrCategory.count>0)
        [self.arrCategory removeAllObjects];
    
    [FunctionManager displayLoadingView:self.view withMessage:msgLoadingGeneral appDelegate:appDelegate viewController:self];
    
    NSURL *baseURL = [NSURL URLWithString:g_WebserviceUrl];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"method"] = @"getCategoryList";
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:g_Pagename_Api parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        
        //NSLog(@"JSON: %@", responseObject);
        [self checkCategoryResponse:(NSArray *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [FunctionManager hideLoadingView:self.view appDelegate:appDelegate viewController:self];
        [FunctionManager showMessage:@"" withMessage:[error localizedDescription] withDelegage:nil];
        //NSLog(@"ERROR: %@", [error localizedDescription]);
    }];
}
-(void)checkCategoryResponse:(NSArray *)parrResponse{
    self.bolIsDataFetched = TRUE;
    self.arrCategory = [NSMutableArray arrayWithArray:parrResponse];
    [_tblCategory reloadData];
}

#pragma mark - UITableView Delegete
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrCategory.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CategoryCell";
    CategoryCell *cell = (CategoryCell *)[_tblCategory dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)	{
        NSArray* nib;
        if((g_IS_IPHONE_5_SCREEN) || (g_IS_IPHONE_4_SCREEN))
            nib = [[NSBundle mainBundle] loadNibNamed:@"CategoryCell" owner:self options:nil];
        else
            nib = [[NSBundle mainBundle] loadNibNamed:@"CategoryCell_iPad" owner:self options:nil];
        
        for (id oneObject in nib) if ([oneObject isKindOfClass:[CategoryCell class]])
            cell = (CategoryCell *)oneObject;
        
        //cell = [nib objectAtIndex:0];
        cell.showsReorderControl = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor clearColor];   //darkGrayColor
    }
    /*
     [cell.btnCell.layer setCornerRadius:3.0];
     [cell.btnCell.layer setBorderColor:[UIColor lightGrayColor].CGColor];
     [cell.btnCell.layer setBorderWidth: 2.0];
     cell.btnCell.clipsToBounds = YES;
     */
    
    NSDictionary *dicCategory = [self.arrCategory objectAtIndex:indexPath.row];
    
    cell.lblName.text = [dicCategory objectForKey:@"name"];
    
    dispatch_queue_t imageQ = dispatch_queue_create("imageQ", NULL);
    dispatch_async(imageQ, ^{
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[dicCategory objectForKey:@"image"]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(imageData){
                //objProductTmp2.imgPhoto = [UIImage imageWithData:imageData];
                UIImage *imgTmp = [UIImage imageWithData:imageData];
                
                //UIImage *imgTemp = [FunctionManager imageScaleAndCropWithFixWidth:imgTmp withWidth:cell.imgPhoto2.frame.size.width*2];
                UIImage *imgTemp = [FunctionManager imageScaleAndCropWithFixWidth:imgTmp withWidth:cell.imgPhoto.frame.size.width];
                cell.imgPhoto.image = imgTemp;
                
                //[_tblCategory reloadData];
                //[_tblCategory reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        });
    });
    dispatch_release(imageQ);
    
    [cell.btnCell setTag:indexPath.row];
    [cell.btnCell addTarget:self action:@selector(btnTappedCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (IBAction)btnTappedCategory:(id)sender{
    //NSDictionary *dicCategory = [self.arrCategory objectAtIndex:[sender tag]];
    
    HomeViewController *objHomeViewController;
    objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil] autorelease];
    
    
    //    if(g_IS_IPHONE_6PLUS_SCREEN)
    //        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController6P" bundle:nil] autorelease];
    //    else if(g_IS_IPHONE_6_SCREEN)
    //        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController6" bundle:nil] autorelease];
    //    else if(g_IS_IPHONE_5_SCREEN)
    //        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil] autorelease];
    //    else if(g_IS_IPHONE_4_SCREEN)
    //        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController4" bundle:nil] autorelease];
    //    //else if(g_IS_IPAD)
    //        //objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewControlleriPad" bundle:nil] autorelease];
    //    else
    //        objHomeViewController = [[[HomeViewController alloc] initWithNibName:@"HomeViewController4" bundle:nil] autorelease];
    
    
    objHomeViewController.arrCategory = self.arrCategory;
    objHomeViewController.intSelectedCatIndex = [sender tag];
    objHomeViewController.bolIsDataFetched = FALSE;
    
    [self.navigationController pushViewController:objHomeViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Tapped Previous Order
-(IBAction)btnTappedPreviousOrder:(id)sender{
    PreviousOrderViewController *objPreviousOrderViewController;
    objPreviousOrderViewController = [[[PreviousOrderViewController alloc] initWithNibName:@"PreviousOrderViewController" bundle:nil] autorelease];
    
    
    //    if(g_IS_IPHONE_6PLUS_SCREEN)
    //        objPreviousOrderViewController = [[[PreviousOrderViewController alloc] initWithNibName:@"PreviousOrderViewController6P" bundle:nil] autorelease];
    //    else if(g_IS_IPHONE_6_SCREEN)
    //        objPreviousOrderViewController = [[[PreviousOrderViewController alloc] initWithNibName:@"PreviousOrderViewController6" bundle:nil] autorelease];
    //    else if(g_IS_IPHONE_5_SCREEN)
    //        objPreviousOrderViewController = [[[PreviousOrderViewController alloc] initWithNibName:@"PreviousOrderViewController" bundle:nil] autorelease];
    //    else if(g_IS_IPHONE_4_SCREEN)
    //        objPreviousOrderViewController = [[[PreviousOrderViewController alloc] initWithNibName:@"PreviousOrderViewController4" bundle:nil] autorelease];
    //    //else if(g_IS_IPAD)
    //        //objPreviousOrderViewController = [[[PreviousOrderViewController alloc] initWithNibName:@"PreviousOrderViewControlleriPad" bundle:nil] autorelease];
    //    else
    //        objPreviousOrderViewController = [[[PreviousOrderViewController alloc] initWithNibName:@"PreviousOrderViewController4" bundle:nil] autorelease];
    
    
    [self.navigationController pushViewController:objPreviousOrderViewController animated:YES];
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
    if(self.arrCategory.count>0)
        [self.arrCategory removeAllObjects];
    [self.arrCategory release];
    
    [_tblCategory release];
    
    [super dealloc];
}

@end
