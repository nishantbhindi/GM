#import <Foundation/Foundation.h>
#import <AssetsLibrary/ALAsset.h>

@class AppDelegate;
@class User;

@interface FunctionManager : NSObject

// Device Functions
+(BOOL)isRetinaSupport;
+(BOOL)isIOS5;
+(BOOL)isSimulator;

// UIAlertView Functions
+(void)showMessage:(NSString *)pstrTitle withMessage:(NSString *)pstrMsg withDelegage:(id)pIDDelegate;
+(void)showMessageWithConfirm:(NSString *)pstrTitle withMessage:(NSString *)pstrMsg withTag:(NSInteger)pintTag withDelegage:(id)pIDDelegate;
+(void)showMessageWithButtons:(NSString *)pstrTitle withMessage:(NSString *)pstrMsg withOtherButtons:(NSString *)pstrBtns withTag:(NSInteger)pintTag withDelegage:(id)pIDDelegate;

// UIActionSheet Functions
+(void)showActionSheet:(NSString *)pstrTitle withCancelTitle:(NSString *)pstrTitleCancel withDestructiveTitle:(NSString *)pstrTitleDestructive  withOtherButtonTitles:(NSString *)pstrOtherButtonTitles withDelegage:(id)pIDDelegate withViewController:(UIViewController*)pViewController withTag:(NSInteger)pintTag;

// NSUserDefault Functions
+(void)addUserToNSUserDefaults:(User *)pobjValue forKey:(NSString *)pstrKey;
+(User *)fetchUserFromNSUserDefaults:(NSString *)pstrKey;
+(void)addToNSUserDefaults:(id)pobjValue forKey:(NSString *)pstrKey;
+(void)addArrayToNSUserDefaults:(id)pObject forKey:(NSString*)pForKey;
+(id)fetchFromNSUserDefaults:(NSString *)pstrKey;
+(void)removeFromNSUserDefaults:(NSString *)pstrKey;
+(NSMutableArray *)fetchArrayFromNSUserDefaults:(NSString *)pstrKey;

// String Functions
// Get Full Web URL
+(NSString*)getFullWebURL:(NSString*)pstrPageName;
// Get String Value from Char - For Database
+(NSString *)getStringValueFromChar:(char *)pchrValue;
+(NSString *)checkAndgetStringValue:(NSString *)pstrValue withDefaultValue:(NSString *)pstrDefaultValue;
// Get Unique Name By Date
+(NSString *)getUniqueNameByDate;
// Base64 from NSData
+(NSString*)getBase64fromData:(NSData*)theData;

// String/Date Functions
+(NSString *)getFormatedDateWithTimeZone:(NSString *)pstrDate withDisplayFormat:(NSString *)pstrDisplayFormat withTimeZone:(NSString *)pstrTimeZone;
+(NSString *)getFormatedDate:(NSString *)pstrDate withDateFormat:(NSString *)pstrDateFormat withDisplayFormat:(NSString *)pstrDisplayFormat;
+(NSString*)getStringFromDate:(NSDate*)pDate withFormat:(NSString*)pstrDateFormat;
+(NSDate*)getDateFromString:(NSString*)pstrDate withFormat:(NSString*)pstrDateFormat;
+(NSString*)getLocalDateTimeFromUTC:(NSString*)pstrDate withFormat:(NSString*)pstrDateFormat withDisplayFormat:(NSString*)pstrDisplayFormat;
+(NSDate *)getDate:(NSDate *)fromDate daysAgo:(NSUInteger)days;
+(NSDate *)getDate:(NSDate *)fromDate daysAhead:(NSUInteger)days;
// Date Difference
+(NSString *)getDateDifference:(NSString *)pstrDate;
// Date Difference for Facebook/Twitter
+(NSString *)getDateDifferenceForFB:(NSString *)pstrDate;
+(NSString *)getDateDifferenceForTwitter:(NSString *)pstrDate;

// Get Full URL
+(NSString*)getFullURL:(NSString*)pstrPageName;

// File Functions - Document/Cache Directory Functions
+(void)createDocumentDirectory:(NSString*)pStrDirectoryName;
+(NSString*)getDocumentDirectoryPath:(NSString*)pStrPathName;
+(void)createCacheDirectory:(NSString*)pStrCacheDirectoryName;
+(NSString*)getCacheDirectoryPath:(NSString*)pStrPathName;
+(NSURL*)getCacheDirectoryUrlPath:(NSString*)pstrFileName;

// Get Image File Functions
+(void)getImageFileFromMainBundle:(NSMutableArray*)pArrImageFile ofType:(NSString*)pStrIamgeType;
+(void)getImageFileFromDocumentDirectory:(NSMutableArray*)pArrImageFile fromFolder:(NSString*)pStrIamgeFolder ofType:(NSString*)pStrIamgeType;
+(NSString*)getFilenameFromUrl:(NSString*)pStrUrl;
+(NSString*)getFilenameWithoutExtension:(NSString*)pStrFilename;

// Save/Delete Image File Functions
+(BOOL)saveFileFromUrl:(NSString *)pstrFileUrl withFolderName:(NSString *)pstrFolderName withData:(NSMutableData *)pMutableData;
+(BOOL)deleteFile:(NSString *)pstrFilename fromDocumentDirectory:(NSString *)pstrDirectoryName;
+(BOOL)deleteFileFromPath:(NSString *)pstrFilePath;

// Sound Functions
+(void)playTapSound;
+(void)playSound:(NSString *)pstrSoundName ofType:(NSString *)pstrSoundType;
+(void)playContinuousMusic:(NSString *)pstrSoundName ofType:(NSString *)pstrSoundType withVolume:(float)pfltVolume withNoOfTime:(NSInteger)pintLoopNo Obj:(AVAudioPlayer *)pPlayObject delegate:(id)pIDDelegate;
+(void)pauseContinuousMusic:(AVAudioPlayer *)pPlayObject;
+(void)stopContinuousMusic:(AVAudioPlayer *)pPlayObject;

// Camera Availability Functions
+(BOOL)isCameraDeviceAvailable;
+(BOOL)isFrontCameraDeviceAvailable;
+(BOOL)isRearCameraDeviceAvailable;
+(UIImagePickerControllerCameraDevice)getAvailableCameraFront;
+(UIImagePickerControllerCameraDevice)getAvailableCameraRear;

// Calling Functions
+(void)callNumber:(NSString *)pstrContactNo;

// Email Functions
+(void)sendEmail:(NSString *)pstrSubject mailBody:(NSString *)pstrMailBody isBodyHTML:(BOOL)pbolIsBodyHTML toRecipientList:(NSArray *)toRecipientsEmails ccRecipientList:(NSArray *)ccRecipientsEmails bccRecipientList:(NSArray *)bccRecipientsEmails withImage:(UIImage*)pImage imageType:(NSString*)pstrImageType viewController:(UIViewController*)pViewController delegate:(id)pIDDelegate;

// SMS Functions
+(void)sendSMS:(NSString *)pstrSMSBody toRecipientList:(NSArray *)toRecipients withImage:(UIImage*)pImage imageType:(NSString*)pstrImageType viewController:(UIViewController*)pViewController delegate:(id)pIDDelegate;
+(void)performSMS:(id)pObject withViewController:(UIViewController*)pViewController;

// UIWebView Functions
+(void)stopWebViewBounce:(UIWebView *)pobjWebView;
+(void)openUrlinApp:(UIWebView *)pobjWebView withStringUrl:(NSString *)pstrUrl;
+(void)webviewFailToLoad:(UIWebView *)pobjWebView withError:(NSError *)error;

// Open Url in Safari
+(void)openUrlinSafari:(NSString *)pstrUrl;

// Rate App
+(void)rateApplication:(NSString*)pStrAppID;
+(void)openInItunes:(NSString *)pStrAppName;

// Image Functions
+(UIImage *)imageScaleAndCropToMaxSize:(UIImage *)pImage withSize:(CGSize)pNewSize;
+(UIImage *)imageScaleAndCropWithFixWidth:(UIImage *)pImage withWidth:(CGFloat)pfltWidth;
+(UIImage *)imageWithImage:(UIImage *)pImage scaledToSize:(CGSize)psizNewSize;
+(UIImage *)imageWithImageWithQuality:(UIImage*)image scaledToSize:(CGSize)newSize;
+(void)setImageCorner:(UIImageView *)pImgView radius:(float)pfltRadios;
+(void)setImageBorder:(UIImageView *)pImgView width:(float)pfltWidth color:(UIColor *)pColor;

// TextBox Functions
+(void)setTextFieldCorner:(UITextField *)pTextField radius:(float)pfltRadios;
+(void)setTextBoxBorder:(UITextField *)pTxtBox width:(float)pfltWidth color:(UIColor *)pColor;

// UITableView
+(void)setDefaultTableViewStyle:(UITableView *)tblView delegate:(id)parent;
// Show Hide Label on Record Count.
+(void)checkRecordAvailable:(NSMutableArray *)pArrTemp withTable:(UITableView *)pTblTemp withLabel:(UILabel *)pLabel;

// View Up/Down
+(void)scrollViewUp:(float)pUpvalue withDuration:(float)pDuration withView:(UIView *)pView;
+(void)scrollViewDown:(float)pDownvalue withDuration:(float)pDuration withView:(UIView *)pView;

// Remove All SubViews
+(void)removeAllSubViews:(id)pObj;

// Go Back
+(void)gotoBack:(UIViewController*)pViewController;
+(void)gotoRoot:(UIViewController*)pViewController;
+(void)gotoBackWithIndex:(UIViewController*)pViewController withIndexNo:(int)pintIndexNo;

// Push-Pop
+(void)pushWithAnimation:(UIViewController*)pViewController withPushController:(UIViewController*)pPushViewController withAnimationNo:(int)pintAnimationNo;
+(void)popWithAnimation:(UIViewController*)pViewController withAnimationNo:(int)pintAnimationNo;

// Add Gesture
+(void)addGesture:(UIViewController*)pViewController;

// Remove Inner Shadhow of Popover
+ (void)removeInnerShadowOfPopover;

// Random Data
+(NSNumber*)getRandomNumber:(NSUInteger)from to:(NSUInteger)to;
+(NSInteger)getRandomInteger:(NSUInteger)from to:(NSUInteger)to;

// Display and Hide loading view
+(void)displayLoadingView:(UIView*)pViewToAddLoading withMessage:(NSString*)pstrMessage appDelegate:(AppDelegate*)pAppDelegate viewController:(UIViewController*)pViewController;
+(void)hideLoadingView:(UIView*)pViewToRemoveLoading appDelegate:(AppDelegate*)pAppDelegate viewController:(UIViewController*)pViewController;

@end
