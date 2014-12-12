#import "FunctionManager.h"

@implementation FunctionManager

#pragma mark -
#pragma mark Device Functions
+(BOOL)isRetinaSupport{
    if([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        return [[UIScreen mainScreen] scale] == 2.0 ? YES : NO;
    
    return NO;
}
+(BOOL)isIOS5
{
    NSString *strOS5 = @"5.0";
    NSString *strCurrSysVer = [[UIDevice currentDevice] systemVersion];
    
    //strCurrSysVer = @"5.0.1";
    if ([strCurrSysVer compare:strOS5 options:NSNumericSearch] == NSOrderedAscending) //lower than 4
    {
        return NO;
    }
    else if ([strCurrSysVer compare:strOS5 options:NSNumericSearch] == NSOrderedDescending) //5.0.1 and above
    {
        return YES;
    }
    else //IOS 5
    {
        return YES;
    }
    
    return NO;
}
+(BOOL)isSimulator
{
	NSString *strDeviceType = [UIDevice currentDevice].model;
	BOOL myBool = !([strDeviceType rangeOfString:@"Simulator"].location == NSNotFound);
	return myBool;
}

#pragma mark - UIAlertView Functions
+(void)showMessage:(NSString *)pstrTitle withMessage:(NSString *)pstrMsg withDelegage:(id)pIDDelegate{
    /*UIAlertView *objAlertMsg = [[UIAlertView alloc] initWithTitle:pstrTitle
                                                           message:pstrMsg
                                                          delegate:pIDDelegate
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];*/
    
    //@""
    UIAlertView *objAlertMsg = [[UIAlertView alloc] initWithTitle:pstrTitle
                                                          message:pstrMsg
                                                         delegate:pIDDelegate
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
    [objAlertMsg setTag:-999];
    
    [objAlertMsg show];
    [objAlertMsg release];
}
+(void)showMessageWithConfirm:(NSString *)pstrTitle withMessage:(NSString *)pstrMsg withTag:(NSInteger)pintTag withDelegage:(id)pIDDelegate{
    UIAlertView *objAlertMsg = [[UIAlertView alloc] initWithTitle:pstrTitle
                                                           message:pstrMsg
                                                          delegate:pIDDelegate
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:@"Yes",@"No",nil];
    objAlertMsg.tag = pintTag;
    [objAlertMsg show];
    [objAlertMsg release];
}
+(void)showMessageWithButtons:(NSString *)pstrTitle withMessage:(NSString *)pstrMsg withOtherButtons:(NSString *)pstrBtns withTag:(NSInteger)pintTag withDelegage:(id)pIDDelegate{
    UIAlertView *objAlertMsg = [[UIAlertView alloc] initWithTitle:pstrTitle
                                                           message:pstrMsg
                                                          delegate:pIDDelegate
                                                 cancelButtonTitle:@"Cancel"
                                                 otherButtonTitles:nil];
    
    NSArray *arrBtns = [pstrBtns componentsSeparatedByString:@","];
    for(int i=0;i<[arrBtns count];i++)
        [objAlertMsg addButtonWithTitle:[arrBtns objectAtIndex:i]];
    
    objAlertMsg.tag = pintTag;
    [objAlertMsg show];
    [objAlertMsg release];
}

#pragma mark - UIAlertView Functions
+(void)showActionSheet:(NSString *)pstrTitle withCancelTitle:(NSString *)pstrTitleCancel withDestructiveTitle:(NSString *)pstrTitleDestructive  withOtherButtonTitles:(NSString *)pstrOtherButtonTitles withDelegage:(id)pIDDelegate withViewController:(UIViewController*)pViewController withTag:(NSInteger)pintTag{
    
    UIActionSheet *objActionSheet = [[UIActionSheet alloc]
                            initWithTitle:pstrTitle
                            delegate:pIDDelegate
                            cancelButtonTitle:nil
                            destructiveButtonTitle:nil
                            otherButtonTitles:nil];
    objActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    objActionSheet.tag = pintTag;
    
	NSArray *arrButtonTitles = [pstrOtherButtonTitles componentsSeparatedByString:@","];
    for(int i=0; i<[arrButtonTitles count]; i++)
        [objActionSheet addButtonWithTitle:[arrButtonTitles objectAtIndex:i]];
    
	
	[objActionSheet addButtonWithTitle:pstrTitleCancel];
	objActionSheet.cancelButtonIndex = objActionSheet.numberOfButtons-1;
    
	[objActionSheet showInView:pViewController.view];
	[objActionSheet release];
    
    /*
    UIActionSheet *objActionSheet = [[[UIActionSheet alloc] init] autorelease];
    objActionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    objActionSheet.delegate = pIDDelegate;
    objActionSheet.title = pstrTitle;
    objActionSheet.cancelButtonIndex = [objActionSheet addButtonWithTitle:pstrTitleCancel];
    objActionSheet.destructiveButtonIndex = [objActionSheet addButtonWithTitle:pstrTitleDestructive];
    
    NSArray *arrButtonTitles = [pstrOtherButtonTitles componentsSeparatedByString:@","];
    for(int i=0; i<[arrButtonTitles count]; i++)
        [objActionSheet addButtonWithTitle:[arrButtonTitles objectAtIndex:i]];

    [objActionSheet showInView:pViewController.view];
     */
}

#pragma mark - NSUserDefault Functions
+(void)addUserToNSUserDefaults:(User *)pobjValue forKey:(NSString *)pstrKey
{
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:pobjValue];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:pstrKey];
    [defaults synchronize];
}
+(User *)fetchUserFromNSUserDefaults:(NSString *)pstrKey
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:pstrKey];
    User *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}
+(void)addToNSUserDefaults:(id)pobjValue forKey:(NSString *)pstrKey{
    NSUserDefaults *objUserDefaults = [NSUserDefaults standardUserDefaults];
    [objUserDefaults setObject:pobjValue forKey:pstrKey];
    [objUserDefaults synchronize];
}
+(void)addArrayToNSUserDefaults:(id)pObject forKey:(NSString*)pForKey{
	NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
	[defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:pObject] forKey:pForKey];
	[defaults synchronize];
}
+(id)fetchFromNSUserDefaults:(NSString *)pstrKey{
    NSUserDefaults *objUserDefaults = [NSUserDefaults standardUserDefaults];
    return [objUserDefaults objectForKey:pstrKey];
}
+(void)removeFromNSUserDefaults:(NSString *)pstrKey{
    NSUserDefaults *objUserDefaults = [NSUserDefaults standardUserDefaults];
    [objUserDefaults removeObjectForKey:pstrKey];
    [objUserDefaults synchronize];
}
+(NSMutableArray *)fetchArrayFromNSUserDefaults:(NSString *)pstrKey{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:pstrKey];
    NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return arr;
}

#pragma mark - String Functions
#pragma mark Get Full Web URL
+(NSString*)getFullWebURL:(NSString*)pstrPageName
{
	return [NSString stringWithFormat:@"%@%@",g_WebserviceUrl,pstrPageName];
}
#pragma mark Get String Value from Char - For Database
+(NSString *)getStringValueFromChar:(char *)pchrValue{
    if (pchrValue == NULL)
        return @"";
    else
        return [NSString stringWithUTF8String: pchrValue];
}
+(NSString *)checkAndgetStringValue:(NSString *)pstrValue withDefaultValue:(NSString *)pstrDefaultValue{
	if([pstrValue isEmptyString] || pstrValue==nil || pstrValue == NULL)
    	return pstrDefaultValue;
	else
		return pstrValue;
}
#pragma mark Get Unique Name By Date
+(NSString *)getUniqueNameByDate
{
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSString *strDateString = [dateFormatter stringFromDate:[NSDate date]];
	
	strDateString = [strDateString stringByReplacingOccurrencesOfString:@" " withString:@""];
	strDateString = [strDateString stringByReplacingOccurrencesOfString:@"-" withString:@""];
	strDateString = [strDateString stringByReplacingOccurrencesOfString:@":" withString:@""];
	//strDateString = [strDateString stringByAppendingFormat:@"%@.jpg",dateString];
	
	//NSLog(@"Unique Id = %@",strDateString);
	return strDateString;
}
#pragma mark Base64 from NSData
+(NSString*)getBase64fromData:(NSData*)pobjNSData
{
    const uint8_t* input = (const uint8_t*)[pobjNSData bytes];
    NSInteger length = [pobjNSData length];
	
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
	
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
			
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
		
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
	
    return [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] autorelease];
}

#pragma mark - String/Date Functions
+(NSString *)getFormatedDateWithTimeZone:(NSString *)pstrDate withDisplayFormat:(NSString *)pstrDisplayFormat withTimeZone:(NSString *)pstrTimeZone
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:pstrTimeZone]];
	[dateFormatter setDateFormat:pstrDisplayFormat];
	NSDate* date = [dateFormatter dateFromString:pstrDate];
	NSString *strDateString = [dateFormatter stringFromDate:date];
	//NSLog(@"Date = %@", strDateString);
	[dateFormatter release];
	return strDateString;
}
+(NSString *)getFormatedDate:(NSString *)pstrDate withDateFormat:(NSString *)pstrDateFormat withDisplayFormat:(NSString *)pstrDisplayFormat
{
	NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	//[df setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
	[dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
	[dateFormatter setDateFormat:pstrDateFormat];
	NSDate* date = [dateFormatter dateFromString:pstrDate]; // NOTE -0700 is the only change
	[dateFormatter setDateFormat:pstrDisplayFormat];
	NSString *strDate = [dateFormatter stringFromDate:date];
	return strDate;
}
+(NSString*)getStringFromDate:(NSDate*)pdtDate withFormat:(NSString*)pstrDateFormat
{
	NSDateFormatter *dtFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dtFormatter setDateFormat:pstrDateFormat];
	return [dtFormatter stringFromDate:pdtDate];
}
+(NSDate*)getDateFromString:(NSString*)pstrDate withFormat:(NSString*)pstrDateFormat
{
	NSDateFormatter *dtFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dtFormatter setDateFormat:pstrDateFormat];
	return [dtFormatter dateFromString:pstrDate];
}
+(NSString*)getLocalDateTimeFromUTC:(NSString*)pstrDate withFormat:(NSString*)pstrDateFormat withDisplayFormat:(NSString*)pstrDisplayFormat
{
    NSDate* sourceDate = [self getDateFromString:pstrDate withFormat:pstrDateFormat];  //g_DateTimeFormatDisplay
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate* destinationDate = [[[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate] autorelease];
    return [self getStringFromDate:destinationDate withFormat:pstrDisplayFormat]; //g_DateTimeFormatDisplay
}
+(NSDate *)getDate:(NSDate *)fromDate daysAgo:(NSUInteger)days
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = -1*days;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *previousDate = [calendar dateByAddingComponents:dateComponents
                                                     toDate:fromDate
                                                    options:0];
    return previousDate;
}
+(NSDate *)getDate:(NSDate *)fromDate daysAhead:(NSUInteger)days
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = days;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *previousDate = [calendar dateByAddingComponents:dateComponents
                                                     toDate:fromDate
                                                    options:0];
    return previousDate;
}

#pragma mark Date Difference
+(NSString *)getDateDifference:(NSString *)pstrDate
{
    /*
    //Get Local TimeZone
    NSTimeZone* localTimeZone = [NSTimeZone localTimeZone];
    NSString* localAbbreviation = [localTimeZone abbreviation];
    
    NSTimeZone* timeZoneFromAbbreviation = [NSTimeZone timeZoneWithAbbreviation:localAbbreviation];
    NSString* timeZoneIdentifier = timeZoneFromAbbreviation.name;
    
    // get the current date in LocalTimeZone
    NSDate *date = [NSDate date];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate: date];
    date = [NSDate dateWithTimeInterval: seconds sinceDate: date];
    
    //convert string from webService to NSDate
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:timeZoneIdentifier]];
    [dateFormat2 setDateFormat:@"yyyy-MM-dd HH:mm:ss.0"];
    NSDate *dateFromWebServiceString = [[NSDate alloc] init];
    dateFromWebServiceString = [dateFormat2 dateFromString:pstrDate];
    
    //Calculate difference in WebService Time and System Time
    NSTimeInterval timeDifference = [date timeIntervalSinceDate:dateFromWebServiceString];
    
    if(timeDifference < 0)  // Server time is 2 minutes ahead of device time.   So as soon as post is done it gives -2 minutes ago instead of 0 minutes ago
    {
        timeDifference = 0;
    }
    
    int iminutes = timeDifference / 60;
    int ihours = iminutes / 60;
    int idays = iminutes / 1440;
    
    iminutes = iminutes - ihours * 60 ;
    ihours = ihours - idays *24 ;// this ives correct no of days than the looping in while several times
    
    NSLog(@"%d, %d, %d", idays, ihours, iminutes);
	
	return @"";
    */
    
    NSString *strDateDifference = @"";
	
	NSDateFormatter *df1 = [[[NSDateFormatter alloc] init] autorelease];
    [df1 setDateFormat:g_DateTimeFormatDefaultGPS];
    NSDate *dtPostDate = [df1 dateFromString:pstrDate];
	
	NSDateFormatter *df2 = [[[NSDateFormatter alloc] init] autorelease];
    [df2 setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSDate *dtCurrDate = [df2 dateFromString:[[NSDate date] description]];
	
	//NSLog(@"Post Date=%@",dtPostDate);
	//NSLog(@"Curr Date=%@",dtCurrDate);
	
	NSTimeInterval secondsBetween = [dtCurrDate timeIntervalSinceDate:dtPostDate];
	int numberOfDays = secondsBetween / 86400;
	//NSLog(@"There are %d days in between the two dates.", numberOfDays);
	
	if(numberOfDays > 0){
		//For Days
		if(numberOfDays==1){
			strDateDifference = [NSString stringWithFormat:@"About %d day ago", numberOfDays];
		}
		else if(numberOfDays<30){
			strDateDifference = [NSString stringWithFormat:@"About %d days ago", numberOfDays];
		}
		else {
			//For Months
			int numberOfMonths = numberOfDays / 30;
			if(numberOfMonths==1){
				strDateDifference = [NSString stringWithFormat:@"About %d month ago", numberOfMonths];
			}
			else {
				strDateDifference = [NSString stringWithFormat:@"About %d months ago", numberOfMonths];
			}
		}
	}
	else {
		int numberOfHours = secondsBetween / 3600;
		
		if(numberOfHours>0){
			//For Hours
			if(numberOfHours==1){
				strDateDifference = [NSString stringWithFormat:@"About %d hour ago", numberOfHours];
			}
			else {
				strDateDifference = [NSString stringWithFormat:@"About %d hours ago", numberOfHours];
			}
		}
		else {
			//For Minutes
			int numberOfMinutes = secondsBetween / 60;
			if(numberOfMinutes==1){
				strDateDifference = [NSString stringWithFormat:@"About %d minute ago", numberOfMinutes];
			}
			else {
				strDateDifference = [NSString stringWithFormat:@"About %d minutes ago", numberOfMinutes];
			}
		}
	}
	
	strDateDifference = [strDateDifference stringByAppendingString:@""];
	
	return strDateDifference;
}
#pragma mark Date Difference for Facebook/Twitter
+(NSString *)getDateDifferenceForFB:(NSString *)pstrDate
{
	NSString *strDateDifference = @"";
	
	NSDateFormatter *df1 = [[[NSDateFormatter alloc] init] autorelease];
    [df1 setDateFormat:g_DateFormat_Facebook];
    NSDate *dtPostDate = [df1 dateFromString:pstrDate];
	
	NSDateFormatter *df2 = [[[NSDateFormatter alloc] init] autorelease];
    [df2 setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSDate *dtCurrDate = [df2 dateFromString:[[NSDate date] description]];
	
	//NSLog(@"Post Date=%@",dtPostDate);
	//NSLog(@"Curr Date=%@",dtCurrDate);
	
	NSTimeInterval secondsBetween = [dtCurrDate timeIntervalSinceDate:dtPostDate];
	int numberOfDays = secondsBetween / 86400;
	//NSLog(@"There are %d days in between the two dates.", numberOfDays);
	
	if(numberOfDays > 0){
		//For Days
		if(numberOfDays==1){
			strDateDifference = [NSString stringWithFormat:@"About %d day ago", numberOfDays];
		}
		else if(numberOfDays<30){
			strDateDifference = [NSString stringWithFormat:@"About %d days ago", numberOfDays];
		}
		else {
			//For Months
			int numberOfMonths = numberOfDays / 30;
			if(numberOfMonths==1){
				strDateDifference = [NSString stringWithFormat:@"About %d month ago", numberOfMonths];
			}
			else {
				strDateDifference = [NSString stringWithFormat:@"About %d months ago", numberOfMonths];
			}
		}
	}
	else {
		int numberOfHours = secondsBetween / 3600;
		
		if(numberOfHours>0){
			//For Hours
			if(numberOfHours==1){
				strDateDifference = [NSString stringWithFormat:@"About %d hour ago", numberOfHours];
			}
			else {
				strDateDifference = [NSString stringWithFormat:@"About %d hours ago", numberOfHours];
			}
		}
		else {
			//For Minutes
			int numberOfMinutes = secondsBetween / 60;
			if(numberOfMinutes==1){
				strDateDifference = [NSString stringWithFormat:@"About %d minute ago", numberOfMinutes];
			}
			else {
				strDateDifference = [NSString stringWithFormat:@"About %d minutes ago", numberOfMinutes];
			}
		}
	}
	
	strDateDifference = [strDateDifference stringByAppendingString:@" via facebook"];
	
	return strDateDifference;
}
+(NSString *)getDateDifferenceForTwitter:(NSString *)pstrDate
{
	NSString *strDateDifference = @"";
	
	NSDateFormatter *df1 = [[[NSDateFormatter alloc] init] autorelease];
	[df1 setDateFormat:g_DateFormat_Twitter];
    NSDate *dtPostDate = [df1 dateFromString:pstrDate];
	
	NSDateFormatter *df2 = [[[NSDateFormatter alloc] init] autorelease];
    [df2 setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSDate *dtCurrDate = [df2 dateFromString:[[NSDate date] description]];
	
	//NSLog(@"Post Date=%@",dtPostDate);
	//NSLog(@"Curr Date=%@",dtCurrDate);
	
	NSTimeInterval secondsBetween = [dtCurrDate timeIntervalSinceDate:dtPostDate];
	int numberOfDays = secondsBetween / 86400;
	//NSLog(@"There are %d days in between the two dates.", numberOfDays);
	
	if(numberOfDays > 0){
		//For Days
		if(numberOfDays==1){
			strDateDifference = [NSString stringWithFormat:@"About %d day ago", numberOfDays];
		}
		else if(numberOfDays<30){
			strDateDifference = [NSString stringWithFormat:@"About %d days ago", numberOfDays];
		}
		else {
			//For Months
			int numberOfMonths = numberOfDays / 30;
			if(numberOfMonths==1){
				strDateDifference = [NSString stringWithFormat:@"About %d month ago", numberOfMonths];
			}
			else {
				strDateDifference = [NSString stringWithFormat:@"About %d months ago", numberOfMonths];
			}
		}
	}
	else {
		int numberOfHours = secondsBetween / 3600;
		
		if(numberOfHours>0){
			//For Hours
			if(numberOfHours==1){
				strDateDifference = [NSString stringWithFormat:@"About %d hour ago", numberOfHours];
			}
			else {
				strDateDifference = [NSString stringWithFormat:@"About %d hours ago", numberOfHours];
			}
		}
		else {
			//For Minutes
			int numberOfMinutes = secondsBetween / 60;
			if(numberOfMinutes==1){
				strDateDifference = [NSString stringWithFormat:@"About %d minute ago", numberOfMinutes];
			}
			else {
				strDateDifference = [NSString stringWithFormat:@"About %d minutes ago", numberOfMinutes];
			}
		}
	}
	
	strDateDifference = [strDateDifference stringByAppendingString:@" via twitter"];
	
	return strDateDifference;
}

#pragma mark - Get Full URL
+(NSString*)getFullURL:(NSString*)pstrPageName
{
	return [NSString stringWithFormat:@"%@%@",g_WebserviceUrl,pstrPageName];
}

#pragma mark - File Functions - Document/Cache Directory Functions
+(void)createDocumentDirectory:(NSString*)pStrDirectoryName
{
    NSString *dataPath = [self getDocumentDirectoryPath:pStrDirectoryName];
    
	if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
		[[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:NULL];
}
+(NSString*)getDocumentDirectoryPath:(NSString*)pStrPathName
{
	NSString *strPath = @"";
	if(pStrPathName)
		strPath = [[kAppDirectoryPath objectAtIndex:0] stringByAppendingPathComponent:pStrPathName];
	
	return strPath;
}
+(void)createCacheDirectory:(NSString*)pStrCacheDirectoryName
{
    NSString *dataPath = [self getCacheDirectoryPath:pStrCacheDirectoryName];
    
	if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
		[[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:NULL];
}
+(NSString*)getCacheDirectoryPath:(NSString*)pstrPathName
{
	NSString *strPath = @"";
	if(pstrPathName)
		strPath = [[kAppCachePath objectAtIndex:0] stringByAppendingPathComponent:pstrPathName];
	
	return strPath;
}
+(NSURL*)getCacheDirectoryUrlPath:(NSString*)pstrFileName
{
	return [NSURL fileURLWithPath:[self getCacheDirectoryPath:pstrFileName]];
}

#pragma mark Get Image File Functions
+(void)getImageFileFromMainBundle:(NSMutableArray*)pArrImageFile ofType:(NSString*)pStrIamgeType
{
	[pArrImageFile removeAllObjects];
	pArrImageFile = [NSMutableArray arrayWithArray:[[NSBundle mainBundle] pathsForResourcesOfType:[NSString stringWithFormat:@".%@", pStrIamgeType] inDirectory:nil]];
}
+(void)getImageFileFromDocumentDirectory:(NSMutableArray*)pArrImageFile fromFolder:(NSString*)pStrIamgeFolder ofType:(NSString*)pStrIamgeType
{
	[pArrImageFile removeAllObjects];
	NSError *error = nil;
	NSArray *dirContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self getDocumentDirectoryPath:pStrIamgeFolder] error:&error];
	if (!error) {
		//NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self ENDSWITH '.jpg'"];
		//NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self ENDSWITH '.png'"];
		NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"self ENDSWITH '.%@'", pStrIamgeType]];
		NSArray *imagesOnly = [dirContents filteredArrayUsingPredicate:predicate];
		pArrImageFile = [NSMutableArray arrayWithArray:imagesOnly];
	} else {
#ifdef DEBUG
		NSLog(@"error: %@", [error localizedDescription]);
#endif
	}
}
+(NSString*)getFilenameFromUrl:(NSString*)pStrUrl
{
	NSArray *arrayFileData = [pStrUrl componentsSeparatedByString:@"/"];
	NSString *strFileName = [arrayFileData objectAtIndex:[arrayFileData count]-1];
    return strFileName;
}
+(NSString*)getFilenameWithoutExtension:(NSString*)pStrFilename;
{
	NSArray *arrayFileData = [pStrFilename componentsSeparatedByString:@"."];
	NSString *strFileName = [arrayFileData objectAtIndex:0];
    return strFileName;
}
#pragma mark Save/Delete Image File Functions
+(BOOL)saveFileFromUrl:(NSString *)pstrFileUrl withFolderName:(NSString *)pstrFolderName withData:(NSMutableData *)pMutableData
{
	BOOL success = NO;
	
	NSString *strFileName = [self getFilenameFromUrl:pstrFileUrl];
	NSString *strFilePath = [self getDocumentDirectoryPath:pstrFolderName];
	strFilePath = [strFilePath stringByAppendingPathComponent: strFileName];
	
	if(pstrFileUrl)
	{
		pstrFileUrl = [pstrFileUrl stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
		NSURL *FILE_URL = [NSURL URLWithString:pstrFileUrl];
		NSMutableData *receivedData = [NSData dataWithContentsOfURL:FILE_URL];
		if(receivedData)
		{
			success = YES;
			if([receivedData writeToFile:strFilePath atomically:YES])
			{
				success = YES;
				//NSLog(@"Saved file: %@",strFilePath);
			}
			else
			{
				success = NO;
				//NSLog(@"Failed to save IMAGE to: %@",strFilePath);
			}
		}
	}
	return success;
}
+(BOOL)deleteFile:(NSString *)pstrFilename fromDocumentDirectory:(NSString *)pstrDirectoryName
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL success = NO;
	
	NSString *strFilePath = [self getDocumentDirectoryPath:pstrDirectoryName];
	strFilePath = [strFilePath stringByAppendingPathComponent: pstrFilename];
    
	success = [fileManager fileExistsAtPath:strFilePath];
	
    if (success)
        [fileManager removeItemAtPath:strFilePath error:NULL];
	
	if(success)
	{
		return YES;
		//NSLog(@"Deleted");
	}
	else
	{
		return NO;
		//NSLog(@"Fail To delete");
	}
}
+(BOOL)deleteFileFromPath:(NSString *)pstrFilePath
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	BOOL success = NO;
	
	success = [fileManager fileExistsAtPath:pstrFilePath];
	
    if (success)
        [fileManager removeItemAtPath:pstrFilePath error:NULL];
	
	if(success)
	{
		return YES;
		//NSLog(@"Deleted");
	}
	else
	{
		return NO;
		//NSLog(@"Fail To delete");
	}
}

#pragma mark - Sound Functions
+(void)playTapSound
{
	CFURLRef soundFileURLRef = CFBundleCopyResourceURL(CFBundleGetBundleWithIdentifier(CFSTR("com.apple.UIKit")),CFSTR ("Tock"),CFSTR ("aiff"),NULL);
	SystemSoundID soundID;
	AudioServicesCreateSystemSoundID(soundFileURLRef, &soundID);
	AudioServicesPlaySystemSound(soundID);
}
+(void)playSound:(NSString *)pstrSoundName ofType:(NSString *)pstrSoundType
{
	//Sound Type = "caf" tested
	SystemSoundID soundID;
	NSString *strSoundPath = [[NSBundle mainBundle] pathForResource:pstrSoundName ofType:pstrSoundType];
	CFURLRef strSoundUrl = (CFURLRef) [NSURL fileURLWithPath:strSoundPath];
	AudioServicesCreateSystemSoundID(strSoundUrl, &soundID);
	AudioServicesPlaySystemSound(soundID);
}
+(void)playContinuousMusic:(NSString *)pstrSoundName ofType:(NSString *)pstrSoundType withVolume:(float)pfltVolume withNoOfTime:(NSInteger)pintLoopNo Obj:(AVAudioPlayer *)pPlayObject delegate:(id)pIDDelegate
{
	//Sound Type = "caf" tested
	//pintLoopNo = "-1" for continuous play
	if(!pPlayObject){
		NSString* resourcePath = [[NSBundle mainBundle] pathForResource:pstrSoundName ofType:pstrSoundType];
		//NSLog(@"Path to play: %@", resourcePath);
		NSError* err;
		pPlayObject = [[[AVAudioPlayer alloc] initWithContentsOfURL:
                        [NSURL fileURLWithPath:resourcePath] error:&err] autorelease];
		if( err ){
			NSLog(@"Failed with reason: %@", [err localizedDescription]);
		}
		else{
			pPlayObject.delegate = pIDDelegate;
			[pPlayObject play];
			[pPlayObject setVolume:pfltVolume];
			[pPlayObject setNumberOfLoops:pintLoopNo];
		}
	}
	else{
		[pPlayObject play];
	}
}
+(void)pauseContinuousMusic:(AVAudioPlayer *)pPlayObject
{
	//NSLog(@"Player paused at time: %f", pPlayObject.currentTime);
	[pPlayObject pause];
}
+(void)stopContinuousMusic:(AVAudioPlayer *)pPlayObject
{
	//NSLog(@"Player stopped at time: %f", pPlayObject.currentTime);
	[pPlayObject stop];
}

#pragma mark - Camera Availability Functions
+(BOOL)isCameraDeviceAvailable
{
	BOOL bolCameraAvailable=NO;
	if([UIImagePickerController	isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront] || [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
			bolCameraAvailable = YES;
	}
	return bolCameraAvailable;
}
+(BOOL)isFrontCameraDeviceAvailable
{
	BOOL bolCameraAvailable=NO;
	if([UIImagePickerController	isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront])
			bolCameraAvailable = YES;
	}
	return bolCameraAvailable;
}
+(BOOL)isRearCameraDeviceAvailable
{
	BOOL bolCameraAvailable=NO;
	if([UIImagePickerController	isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
			bolCameraAvailable = YES;
	}
	return bolCameraAvailable;
}
+(UIImagePickerControllerCameraDevice)getAvailableCameraFront
{
	UIImagePickerControllerCameraDevice availableDevice = NSNotFound;
	
	if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront])
		availableDevice = UIImagePickerControllerCameraDeviceFront;
	
	return availableDevice;
}
+(UIImagePickerControllerCameraDevice)getAvailableCameraRear
{
	UIImagePickerControllerCameraDevice availableDevice = NSNotFound;
	
	if([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
		availableDevice = UIImagePickerControllerCameraDeviceRear;
	
	return availableDevice;
}

#pragma mark - Calling Functions
+(void)callNumber:(NSString *)pstrContactNo
{
	NSString *strDeviceModel = [UIDevice currentDevice].model;
	if(![strDeviceModel isEqualToString:@"iPhone"])
	{
		/*NSString *strMessage = [NSString stringWithFormat:@"%@ 'tel:%@' %@",msgCallTitle,pstrContactNo,msgCallMessage];
        [self showMessage:nil withMessage:strMessage withDelegage:nil];*/
        [self showMessage:@"" withMessage:msgCallNotSupport withDelegage:nil];  //nil
	}
	else
	{
		//pstrContactNo = [NSString stringWithFormat:@"tel://%@",pstrContactNo];
        pstrContactNo = [NSString stringWithFormat:@"tel:%@",pstrContactNo];
		NSString *strDialedContact = [pstrContactNo stringByReplacingOccurrencesOfString:@" " withString:@""];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:strDialedContact]];
	}
}

#pragma mark - Email Functions
+(void)sendEmail:(NSString *)pstrSubject mailBody:(NSString *)pstrMailBody isBodyHTML:(BOOL)pbolIsBodyHTML toRecipientList:(NSArray *)toRecipientsEmails ccRecipientList:(NSArray *)ccRecipientsEmails bccRecipientList:(NSArray *)bccRecipientsEmails withImage:(UIImage*)pImage imageType:(NSString*)pstrImageType viewController:(UIViewController*)pViewController delegate:(id)pIDDelegate
{
	//----Add delegate in respective controller for dismiss----//
	
	BOOL bolCanSendMail = TRUE;
	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			MFMailComposeViewController *objMailPicker = [[MFMailComposeViewController alloc] init];
			objMailPicker.mailComposeDelegate = pIDDelegate;
			[objMailPicker.navigationBar setTintColor:[UIColor blackColor]];
			
			[objMailPicker setSubject:pstrSubject];
			[objMailPicker setMessageBody:pstrMailBody isHTML:pbolIsBodyHTML];
			
			if([toRecipientsEmails count]>0)
				[objMailPicker setToRecipients:toRecipientsEmails];
			if([ccRecipientsEmails count]>0)
				[objMailPicker setCcRecipients:ccRecipientsEmails];
			if([bccRecipientsEmails count]>0)
				[objMailPicker setBccRecipients:bccRecipientsEmails];
			
			//Attach an image to the email
			if(pImage){
				if([pstrImageType isEqualToString:@"png"]){
					NSData *imageData = UIImagePNGRepresentation(pImage);
					[objMailPicker addAttachmentData:imageData mimeType:@"image/png" fileName:@"MyImage"];
				}
				else if([pstrImageType isEqualToString:@"jpg"]){
					NSData *imageData = UIImageJPEGRepresentation(pImage, 1.0);
					[objMailPicker addAttachmentData:imageData mimeType:@"image/jpg" fileName:@"MyImage"];
				}
			}
			
			
			//[self.navController presentModalViewController:objMailPicker animated:YES];			//if passing argument (UINavigationController *)
			//[self.tabBarController presentModalViewController:objMailPicker animated:YES];		//if passing argument (UITabBarController *)
			//[pViewController presentModalViewController:objMailPicker animated:YES];
            [pViewController presentViewController:objMailPicker animated:YES completion:nil];
			[objMailPicker release];
		}
		else
		{
			bolCanSendMail = FALSE;
		}
	}
	else
	{
		bolCanSendMail = FALSE;
	}
	
	
	if(!bolCanSendMail)
	{
		NSString *strToEmail = @"";
		if([toRecipientsEmails count]>0)
			strToEmail = [toRecipientsEmails objectAtIndex:0];
		
		NSString *strMailString = [NSString stringWithFormat:@"mailto:?to=%@&subject=%@&body=%@",
								   [strToEmail stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
								   [pstrSubject stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],
								   [pstrMailBody  stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
		
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:strMailString]];
	}
}

#pragma mark - SMS Functions
+(void)sendSMS:(NSString *)pstrSMSBody toRecipientList:(NSArray *)toRecipients withImage:(UIImage*)pImage imageType:(NSString*)pstrImageType viewController:(UIViewController*)pViewController delegate:(id)pIDDelegate
{
	//----Add delegate in respective controller for dismiss----//
	
	MFMessageComposeViewController *objMessageController = [[[MFMessageComposeViewController alloc] init] autorelease];
    if([MFMessageComposeViewController canSendText])
    {
        objMessageController.body = pstrSMSBody;
        objMessageController.messageComposeDelegate = pIDDelegate;
		
		if([toRecipients count]>0)
			objMessageController.recipients = toRecipients;
		
		//[pViewController presentModalViewController:objMessageController animated:YES];
        [pViewController presentViewController:objMessageController animated:YES completion:nil];
		//[self performSelector:@selector(performSMS:withViewController:) withObject:objMessageController withObject:pViewController afterDelay:0.1];
    }
}
+(void)performSMS:(id)pObject withViewController:(UIViewController*)pViewController
{
	MFMessageComposeViewController *objMessageController = (MFMessageComposeViewController *)pObject;
	//[pViewController presentModalViewController:objMessageController animated:YES];
    [pViewController presentViewController:objMessageController animated:YES completion:nil];
}

#pragma mark - UIWebView Functions
+(void)stopWebViewBounce:(UIWebView *)pobjWebView
{
	[pobjWebView setOpaque:NO];
	pobjWebView.backgroundColor = [UIColor clearColor];
	
	for (id subview in pobjWebView.subviews)
        if ([[subview class] isSubclassOfClass: [UIScrollView class]])
            ((UIScrollView *)subview).bounces = NO;
}
+(void)openUrlinApp:(UIWebView *)pobjWebView withStringUrl:(NSString *)pstrUrl
{
    [pobjWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:pstrUrl]]];
}
+(void)webviewFailToLoad:(UIWebView *)pobjWebView withError:(NSError *)error
{
	if ([error code] == -999) {
	}
	else if([error code] == -1009 || [[error localizedDescription] isEqualToString:@"no Internet connection"]){
		[pobjWebView loadHTMLString:@"<body><br><font size=5 color=red>No Internet Connection!<br>Internet access is required to use this application. If this problem persists, please check your network settings.</font></body>" baseURL:nil];
	}
	else if([error code] == -1001 || [[error localizedDescription] isEqualToString:@"timed out"]){
		[pobjWebView loadHTMLString:@"<body><br><font size=5 color=red>Request Timed Out.</font></body>" baseURL:nil];
	}else if([error code] == -1004 || [[error localizedDescription] isEqualToString:@"can’t connect to host"]){
		[pobjWebView loadHTMLString:@"<body><br><font size=5 color=red>Can’t connect to host.</font></body>" baseURL:nil];
	}
	else if (error != NULL) {
		[pobjWebView loadHTMLString:@"<body><br><font size=5 color=red>Error loading page, Please try again later.</font></body>" baseURL:nil];
    }
	else{
	}
}
#pragma mark Open Url in Safari
+(void)openUrlinSafari:(NSString *)pstrUrl
{
    if (![[UIApplication sharedApplication] openURL:[NSURL URLWithString:pstrUrl]])
    {
        // there was an error trying to open the URL.
        [self showMessage:@"" withMessage:msgURLInvalidToOpen withDelegage:nil];    //nil
    }
}

#pragma mark - Rate App
+(void)rateApplication:(NSString*)pStrAppID
{
    /*
    NSString *str = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa";
    str = [NSString stringWithFormat:@"%@/wa/viewContentsUserReviews?", str];
    str = [NSString stringWithFormat:@"%@type=Purple+Software&id=", str];
    
    // Here is the app id from itunesconnect
    str = [NSString stringWithFormat:@"%@%@", str,pStrAppID];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    */
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/app/id%@",pStrAppID]]];
}
+(void)openInItunes:(NSString *)pStrAppName
{
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms://itunes.com/apps/%@",pStrAppName]]];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.com/apps/%@",pStrAppName]]];
}

#pragma mark - Image Functions
+(UIImage *)imageScaleAndCropToMaxSize:(UIImage *)pImage withSize:(CGSize)pNewSize
{
	CGFloat largestSize = (pNewSize.width > pNewSize.height) ? pNewSize.width : pNewSize.height;
	CGSize imageSize = [pImage size];
	
	// Scale the image while mainting the aspect and making sure the
	// the scaled image is not smaller then the given new size. In
	// other words we calculate the aspect ratio using the largest
	// dimension from the new size and the small dimension from the
	// actual size.
	CGFloat ratio;
	if (imageSize.width > imageSize.height)
		ratio = largestSize / imageSize.height;
	else
		ratio = largestSize / imageSize.width;
	
	CGRect rect = CGRectMake(0.0, 0.0, ratio * imageSize.width, ratio * imageSize.height);
	UIGraphicsBeginImageContext(rect.size);
	[pImage drawInRect:rect];
	UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	
	// Crop the image to the requested new size maintaining
	// the inner most parts of the image.
	CGFloat offsetX = 0;
	CGFloat offsetY = 0;
	imageSize = [scaledImage size];
	if (imageSize.width < imageSize.height)
		offsetY = (imageSize.height / 2) - (imageSize.width / 2);
	else
		offsetX = (imageSize.width / 2) - (imageSize.height / 2);
	
	CGRect cropRect = CGRectMake(offsetX, offsetY, imageSize.width - (offsetX * 2), imageSize.height - (offsetY * 2));
	
	CGImageRef croppedImageRef = CGImageCreateWithImageInRect([scaledImage CGImage], cropRect);
	UIImage *newImage = [UIImage imageWithCGImage:croppedImageRef];
	CGImageRelease(croppedImageRef);
	
	return newImage;
}
+(UIImage *)imageScaleAndCropWithFixWidth:(UIImage *)pImage withWidth:(CGFloat)pfltWidth
{
	CGFloat largestSize = pfltWidth;
	CGSize imageSize = [pImage size];
	
	// Scale the image while mainting the aspect and making sure the
	// the scaled image is not smaller then the given new size. In
	// other words we calculate the aspect ratio using the largest
	// dimension from the new size and the small dimension from the
	// actual size.
	CGFloat ratio;
    
    if (imageSize.width>largestSize)
        ratio = largestSize / imageSize.width;
	else
        ratio=1;
    
	CGRect rect = CGRectMake(0.0, 0.0, ratio * imageSize.width, ratio * imageSize.height);
	UIGraphicsBeginImageContext(rect.size);
	[pImage drawInRect:rect];
	UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	
	// Crop the image to the requested new size maintaining
	// the inner most parts of the image.
	CGFloat offsetX = 0;
	CGFloat offsetY = 0;
	imageSize = [scaledImage size];
	
	CGRect cropRect = CGRectMake(offsetX, offsetY, imageSize.width - (offsetX * 2), imageSize.height - (offsetY * 2));
	
	CGImageRef croppedImageRef = CGImageCreateWithImageInRect([scaledImage CGImage], cropRect);
	UIImage *newImage = [UIImage imageWithCGImage:croppedImageRef];
	CGImageRelease(croppedImageRef);
	
	return newImage;
}
+(UIImage *)imageWithImage:(UIImage *)pImage scaledToSize:(CGSize)psizNewSize
{
	// Create a graphics image context
    UIGraphicsBeginImageContext(psizNewSize);
	// Tell the old image to draw in this new context, with the desired
    // new size
    [pImage drawInRect:CGRectMake(0, 0, psizNewSize.width, psizNewSize.height)];
	// Get the new image from the context
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	// End the context
    UIGraphicsEndImageContext();
	// Return the new image.
    return newImage;
}
+(UIImage *)imageWithImageWithQuality:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a bitmap context.
    //UIGraphicsBeginImageContextWithOptions(newSize, YES, [UIScreen mainScreen].scale);
    UIGraphicsBeginImageContextWithOptions(newSize, YES, image.scale);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+(void)setImageCorner:(UIImageView *)pImgView radius:(float)pfltRadios
{
	pImgView.layer.masksToBounds = YES;
	pImgView.layer.cornerRadius = pfltRadios;
}
+(void)setImageBorder:(UIImageView *)pImgView width:(float)pfltWidth color:(UIColor *)pColor
{
    [pImgView.layer setBorderColor: [pColor CGColor]];
    [pImgView.layer setBorderWidth: pfltWidth];
}

#pragma mark - TextBox Functions
+(void)setTextFieldCorner:(UITextField *)pTextField radius:(float)pfltRadios
{
	pTextField.layer.masksToBounds = YES;
	pTextField.layer.cornerRadius = pfltRadios;
}
+(void)setTextBoxBorder:(UITextField *)pTxtBox width:(float)pfltWidth color:(UIColor *)pColor
{
    [pTxtBox.layer setBorderColor: [pColor CGColor]];
    [pTxtBox.layer setBorderWidth: pfltWidth];
}

#pragma mark - UITableView
+(void)setDefaultTableViewStyle:(UITableView *)tblView delegate:(id)parent
{
	tblView.delegate = parent;
	tblView.dataSource = parent;
	tblView.backgroundColor = [UIColor clearColor];
	tblView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[tblView flashScrollIndicators];
	tblView.bounces = NO;
}

#pragma mark - Show Hide label on record count.
+(void)checkRecordAvailable:(NSMutableArray *)pArrTemp withTable:(UITableView *)pTblTemp withLabel:(UILabel *)pLabel
{
	if(pArrTemp.count > 0)
		pLabel.hidden = YES;
	else
		pLabel.hidden = NO;
	
	[pTblTemp reloadData];
}

#pragma mark - View Up/Down according to text input
+(void)scrollViewUp:(float)pUpvalue withDuration:(float)pDuration withView:(UIView *)pView
{
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:pDuration];
	CGRect rect = pView.frame;
    rect.origin.y -= pUpvalue;
    pView.frame = rect;
    [UIView commitAnimations];
}
+(void)scrollViewDown:(float)pDownvalue withDuration:(float)pDuration withView:(UIView *)pView
{
	[UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:pDuration];
	CGRect rect = pView.frame;
    rect.origin.y += pDownvalue;
    pView.frame = rect;
    [UIView commitAnimations];
}

#pragma mark - Remove All SubViews
+(void)removeAllSubViews:(id)pObj
{
	NSArray *Array = [pObj subviews];
	for(int index = 0; index < [Array count]; index++)
	{
		[[Array objectAtIndex:index] removeFromSuperview];
	}
}

#pragma mark - Go Back Button Tap events
+(void)gotoBack:(UIViewController*)pViewController
{
	[pViewController.navigationController popViewControllerAnimated:YES];
}
+(void)gotoRoot:(UIViewController*)pViewController
{
	[pViewController.navigationController popToRootViewControllerAnimated:YES];
}
+(void)gotoBackWithIndex:(UIViewController*)pViewController withIndexNo:(int)pintIndexNo
{
	[pViewController.navigationController popToViewController:[[pViewController.navigationController viewControllers] objectAtIndex:[[pViewController.navigationController viewControllers] count] - pintIndexNo] animated:TRUE];
}

#pragma mark - Push-Pop
+(void)pushWithAnimation:(UIViewController*)pViewController withPushController:(UIViewController*)pPushViewController withAnimationNo:(int)pintAnimationNo{
    switch (pintAnimationNo) {
        case 1:
        {
            ////ANIMATION////
            CATransition* transition = [CATransition animation];
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            transition.duration = 0.3f;
            transition.type =  @"cube";
            transition.subtype = @"fromRight";
            [pViewController.navigationController.view.layer removeAllAnimations];
            [pViewController.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            
            [pViewController.navigationController pushViewController:pPushViewController animated:NO];
            ////ANIMATION END////
        }
            break;
        case 2:
        {
            CATransition* transition = [CATransition animation];
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            transition.duration = 0.3f;
            transition.type =  @"rotate";
            transition.subtype = @"180cw";
            [pViewController.navigationController.view.layer removeAllAnimations];
            [pViewController.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            
            [pViewController.navigationController pushViewController:pPushViewController animated:NO];
        }
            break;
        case 3:
        {
            CATransition* transition = [CATransition animation];
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            transition.duration = 0.3f;
            transition.type =  @"rippleEffect"; //suckEffect
            transition.subtype = @"fromRight";
            /*CAFilter *filter = [CAFilter filterWithName:@"suckEffect"];
             [filter setValue:[NSValue valueWithCGPoint:CGPointMake(160, 240)] forKey:@"inputPosition"];
             transition.filter = filter;*/
            [pViewController.navigationController.view.layer removeAllAnimations];
            [pViewController.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            
            [pViewController.navigationController pushViewController:pPushViewController animated:NO];
        }
            break;
        case 4:
        {
            CATransition* transition = [CATransition animation];
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            transition.duration = 0.3f;
            transition.type =  @"cameraIris";
            transition.subtype = @"fromRight";
            [pViewController.navigationController.view.layer removeAllAnimations];
            [pViewController.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            
            [pViewController.navigationController pushViewController:pPushViewController animated:NO];
        }
            break;
        default:
        {
            ////ANIMATION////
            CATransition* transition = [CATransition animation];
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            transition.duration = 0.3f;
            transition.type =  @"cube";
            transition.subtype = @"fromRight";
            [pViewController.navigationController.view.layer removeAllAnimations];
            [pViewController.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            
            [pViewController.navigationController pushViewController:pPushViewController animated:NO];
            ////ANIMATION END////
        }
            break;
    }
}
+(void)popWithAnimation:(UIViewController*)pViewController withAnimationNo:(int)pintAnimationNo{
    switch (pintAnimationNo) {
        case 1:
        {
            ////ANIMATION////
            CATransition* transition = [CATransition animation];
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            transition.duration = 0.3f;
            transition.type =  @"cube";
            transition.subtype = @"fromLeft";
            [pViewController.navigationController.view.layer removeAllAnimations];
            [pViewController.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            
            [pViewController.navigationController popViewControllerAnimated:NO];
            ////ANIMATION END////
        }
            break;
        case 2:
        {
            CATransition* transition = [CATransition animation];
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            transition.duration = 0.3f;
            transition.type =  @"rotate";
            transition.subtype = @"180ccw";
            [pViewController.navigationController.view.layer removeAllAnimations];
            [pViewController.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            
            [pViewController.navigationController popViewControllerAnimated:NO];
        }
            break;
        case 3:
        {
            CATransition* transition = [CATransition animation];
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            transition.duration = 0.3f;
            transition.type =  @"rippleEffect"; //suckEffect
            transition.subtype = @"fromLeft";
            /*CAFilter *filter = [CAFilter filterWithName:@"suckEffect"];
             [filter setValue:[NSValue valueWithCGPoint:CGPointMake(160, 240)] forKey:@"inputPosition"];
             transition.filter = filter;*/
            [pViewController.navigationController.view.layer removeAllAnimations];
            [pViewController.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            
            [pViewController.navigationController popViewControllerAnimated:NO];
        }
            break;
        case 4:
        {
            CATransition* transition = [CATransition animation];
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            transition.duration = 0.3f;
            transition.type =  @"cameraIris";
            transition.subtype = @"fromLeft";
            [pViewController.navigationController.view.layer removeAllAnimations];
            [pViewController.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            
            [pViewController.navigationController popViewControllerAnimated:NO];
        }
            break;
        default:
        {
            ////ANIMATION////
            CATransition* transition = [CATransition animation];
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            transition.duration = 0.3f;
            transition.type =  @"cube";
            transition.subtype = @"fromLeft";
            [pViewController.navigationController.view.layer removeAllAnimations];
            [pViewController.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            
            [pViewController.navigationController popViewControllerAnimated:NO];
            ////ANIMATION END////
        }
            break;
    }
}

#pragma mark - Add Gesture
+(void)addGesture:(UIViewController*)pViewController{
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:pViewController action:@selector(showMenu:)] autorelease];
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [pViewController.view addGestureRecognizer:rightSwipeGestureRecognizer];
    
    UISwipeGestureRecognizer* leftSwipeGestureRecognizer = [[[UISwipeGestureRecognizer alloc] initWithTarget:pViewController action:@selector(hideMenu:)] autorelease];
    leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [pViewController.view addGestureRecognizer:leftSwipeGestureRecognizer];
    
    //Note: implement "showMenu" and "hideMenu" in respective view controller
}

#pragma mark - Remove Inner Shadhow of Popover
+ (void)removeInnerShadowOfPopover{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    //NSLog(@"%@", window.subviews);
    for (UIView *windowSubView in window.subviews) {
        if ([NSStringFromClass([windowSubView class]) isEqualToString:@"UIDimmingView"]) {
            for (UIView *dimmingViewSubviews in windowSubView.subviews) {
                for (UIView *popoverSubview in dimmingViewSubviews.subviews) {
                    if([NSStringFromClass([popoverSubview class]) isEqualToString:@"UIView"]) {
                        for (UIView *subviewA in popoverSubview.subviews) {
                            if ([NSStringFromClass([subviewA class]) isEqualToString:@"UILayoutContainerView"]) {
                                subviewA.layer.cornerRadius = 0;
                            }
                            for (UIView *subviewB in subviewA.subviews) {
                                if ([NSStringFromClass([subviewB class]) isEqualToString:@"UIImageView"] ) {
                                    [subviewB removeFromSuperview];
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#pragma mark - Random Data
+(NSNumber*)getRandomNumber:(NSUInteger)from to:(NSUInteger)to
{
	NSInteger intRandomNo = (int)from + arc4random() % (to-from+1);
	return [NSNumber numberWithInt:intRandomNo];
}
+(NSInteger)getRandomInteger:(NSUInteger)from to:(NSUInteger)to
{
	NSInteger intRandomNo = (int)from + arc4random() % (to-from+1);
	return intRandomNo;
}

#pragma mark - Display and Hide loading view
+(void)displayLoadingView:(UIView*)pViewToAddLoading withMessage:(NSString*)pstrMessage appDelegate:(AppDelegate*)pAppDelegate viewController:(UIViewController*)pViewController
{
	pViewController.tabBarController.tabBar.userInteractionEnabled = NO;
    //pAppDelegate.objCustomTabBar.tabBar.userInteractionEnabled = NO;
	[pViewToAddLoading addSubview:pAppDelegate.viewLoading];
	pAppDelegate.lblLoadingMessage.text = pstrMessage;
	[pAppDelegate.viewLoading setCenter:CGPointMake(pViewToAddLoading.frame.size.width/2, pViewToAddLoading.frame.size.height/2)];
    
	[pViewController.view setUserInteractionEnabled:NO];
	[pViewToAddLoading setUserInteractionEnabled:NO];
}
+(void)hideLoadingView:(UIView*)pViewToRemoveLoading appDelegate:(AppDelegate*)pAppDelegate viewController:(UIViewController*)pViewController;
{
	pViewController.tabBarController.tabBar.userInteractionEnabled = YES;
    //pAppDelegate.objCustomTabBar.tabBar.userInteractionEnabled = YES;
	[pAppDelegate.viewLoading removeFromSuperview];
	[pViewController.view setUserInteractionEnabled:YES];
	[pViewToRemoveLoading setUserInteractionEnabled:YES];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
