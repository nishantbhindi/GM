//
//  LandingViewController.m
//  GW Whiteboard
//
//  Created by WebInfoways on 13/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "LandingViewController.h"

//Scroll Timer
#define SplashScrollTimer       3.0

@interface LandingViewController ()

@end

@implementation LandingViewController

@synthesize arrPages;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setInitialParameter];
}
- (void)viewWillAppear:(BOOL)animated{
    //[self initializeScroll];
    [self startTimer];
}
- (void)viewWillDisappear:(BOOL)animated{
    [self resetTimer];
}

#pragma mark - Set Initial Parameter
-(void)setInitialParameter{
    //_scrPage.autoresizingMask=UIViewAutoresizingNone;
    //_pgControl.autoresizingMask=UIViewAutoresizingNone;
    
    [self initializeScroll];
}

#pragma mark - Initialize Scroll
-(void)initializeScroll{
    //_scrPage.frame = CGRectMake(0.0, 0.0, 320.0, 568.0);
    //[_scrPage setBackgroundColor:[UIColor blackColor]];
    
    bolPageControlUsed = NO;
    
    self.arrPages = [NSArray arrayWithObjects:@"Splash-1.PNG", @"Splash-2.PNG", @"Splash-3.PNG", @"Splash-4.PNG", nil];
    
    // add the last image (Splash-4) into the first position
    //[self addImageWithName:@"Splash-4.PNG" atPosition:0];
    
    for (int i = 0; i < [self.arrPages count]; i++) {
        CGRect frame;
        frame.origin.x = _scrPage.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = _scrPage.frame.size;
        
        UIImageView *imgScrollBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self.arrPages objectAtIndex:i]]];
        [imgScrollBg setFrame:frame];
        
        //imgScrollBg.autoresizingMask=UIViewAutoresizingNone;
        
        [imgScrollBg setContentMode:UIViewContentModeScaleToFill];  //UIViewContentModeScaleToFill   //UIViewContentModeScaleAspectFit
        imgScrollBg.contentMode=UIViewContentModeScaleToFill;
        [_scrPage addSubview:imgScrollBg];
        [imgScrollBg release];
    }
    
    // add the first image (Splash-1) into the last position
    //[self addImageWithName:@"Splash-1.PNG" atPosition:arrImage.count];
    
    //_scrPage.contentSize = CGSizeMake(_scrPage.frame.size.width * (arrImage.count+2), _scrPage.frame.size.height);
    //[_scrPage scrollRectToVisible:CGRectMake(_scrPage.frame.size.width * _pgControl.currentPage, 0, _scrPage.frame.size.width, _scrPage.frame.size.height) animated:NO];
    
    _scrPage.contentSize = CGSizeMake(_scrPage.frame.size.width * self.arrPages.count, _scrPage.frame.size.height);
    [_scrPage setContentOffset:CGPointMake(0,0)];
    
    //_pgControl.imageNormal = [UIImage imageNamed:@"landing_paging_ico_deselect.png"];
    //_pgControl.imageCurrent = [UIImage imageNamed:@"landing_paging_ico_select.png"];
    
    _pgControl.currentPage = 0;
    _pgControl.numberOfPages = self.arrPages.count;
    
    
    // Start Timer
    //[self startTimer];
}
-(void)addImageWithName:(NSString*)pstrImgName atPosition:(int)pintPosition
{
    CGRect frame;
    frame.origin.x = _scrPage.frame.size.width * pintPosition;
    frame.origin.y = 0;
    frame.size = _scrPage.frame.size;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:pstrImgName]];
    //imageView.frame = CGRectMake(pintPosition*320, 0, 320, 416);
    [imageView setFrame:frame];
    [_scrPage addSubview:imageView];
    [imageView release];
}

#pragma mark - scroll delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (!bolPageControlUsed) {
        [self resetTimer];
        
        // Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = _scrPage.frame.size.width;
        int page = floor((_scrPage.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        _pgControl.currentPage = page;
        
        [self startTimer];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    bolPageControlUsed = NO;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    bolPageControlUsed = NO;
    
    ////
    /*
    NSLog(@"%f",scrollView.contentOffset.x);
     
    // The key is repositioning without animation
    if (scrollView.contentOffset.x == 0) {
        // user is scrolling to the left from image 1 to image 4
        // reposition offset to show image 4 that is on the right in the scroll view
        [scrollView scrollRectToVisible:CGRectMake(1280.0, 0, _scrPage.frame.size.width, _scrPage.frame.size.height) animated:NO];
    }
    else if (scrollView.contentOffset.x == 1600) {
        // user is scrolling to the right from image 4 to image 1
        // reposition offset to show image 1 that is on the left in the scroll view
        [scrollView scrollRectToVisible:CGRectMake(320.0, 0, _scrPage.frame.size.width, _scrPage.frame.size.height) animated:NO];
    }
    */
    ////
}
#pragma mark - Chagne Page
-(IBAction)changePageControl:(id)sender{
    [self resetTimer];
    [self setCurrentScrollPage:_pgControl.currentPage];
    [self startTimer];
    
    /*
     CGRect frame;
     frame.origin.x = _scrPage.frame.size.width * _pgControl.currentPage;
     frame.origin.y = 0;
     frame.size = _scrPage.frame.size;
     [_scrPage scrollRectToVisible:frame animated:YES];
     
     bolPageControlUsed = YES;
     */
}

#pragma mark - Timer Auto Scroll
-(void)startTimer{
    autoTimer = [NSTimer scheduledTimerWithTimeInterval:SplashScrollTimer
                                                 target:self
                                               selector:@selector(scrollingTimer:)
                                               userInfo:nil
                                                repeats:YES];
}
-(void)resetTimer{
    [autoTimer invalidate];
    autoTimer = nil;
}

#pragma mark - Set Current Scroll Page
- (void)scrollingTimer:(NSTimer*)timer{
    NSInteger nextPage = _pgControl.currentPage + 1;
    
    [self setCurrentScrollPage:nextPage];
}
-(void)setCurrentScrollPage:(NSInteger)pintCurrPage{
    bolPageControlUsed = YES;
    
    if(pintCurrPage!=self.arrPages.count)  {
        CGRect frame;
        frame.origin.x = _scrPage.frame.size.width * pintCurrPage;
        frame.origin.y = 0;
        frame.size = _scrPage.frame.size;
        [_scrPage scrollRectToVisible:frame animated:YES];
        
        _pgControl.currentPage=pintCurrPage;
        // else start sliding form 1 :)
    } else {
        
        CGRect frame;
        frame.origin.x = 0;
        frame.origin.y = 0;
        frame.size = _scrPage.frame.size;
        [_scrPage scrollRectToVisible:frame animated:YES];
        
        _pgControl.currentPage=0;
    }
}

#pragma mark - Btn Tapped Survey
-(IBAction)btnTappedSurvey:(id)sender{
    /*
    SurveyViewController *objSurveyViewController;
    objSurveyViewController = [[[SurveyViewController alloc] initWithNibName:@"SurveyViewController" bundle:nil] autorelease];
    */
    
    /*
    if(g_IS_IPHONE_6PLUS_SCREEN)
        objSurveyViewController = [[[SurveyViewController alloc] initWithNibName:@"SurveyViewController6P" bundle:nil] autorelease];
    else if(g_IS_IPHONE_6_SCREEN)
        objSurveyViewController = [[[SurveyViewController alloc] initWithNibName:@"SurveyViewController6" bundle:nil] autorelease];
    else if(g_IS_IPHONE_5_SCREEN)
        objSurveyViewController = [[[SurveyViewController alloc] initWithNibName:@"SurveyViewController" bundle:nil] autorelease];
    else if(g_IS_IPHONE_4_SCREEN)
        objSurveyViewController = [[[SurveyViewController alloc] initWithNibName:@"SurveyViewController4" bundle:nil] autorelease];
    //else if(g_IS_IPAD)
        //objSurveyViewController = [[[SurveyViewController alloc] initWithNibName:@"SurveyViewControlleriPad" bundle:nil] autorelease];
    else
        objSurveyViewController = [[[SurveyViewController alloc] initWithNibName:@"SurveyViewController4" bundle:nil] autorelease];
    */
    
    //objSurveyViewController.imgPhotoPreview = imgPhotoToShare;
    //[self.navigationController pushViewController:objSurveyViewController animated:YES];
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
    [_scrPage release];
    [_pgControl release];
    
    [super dealloc];
}

@end
