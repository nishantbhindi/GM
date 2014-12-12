//---------------PROJECT WISE---------------//

//Webservice Url
#define g_WebserviceUrl                         @"http://webplanex.co.in/projects/gw_whiteboard/api/index.php?"
#define g_WebserviceImageUploadUrl              @"http://webplanex.co.in/projects/gw_whiteboard/api/index.php?"

//#define g_WebserviceUrlPostCode                 @"http://ws.postcoder.com/pcw/%@/street/uk/%@?format=json"
#define g_WebserviceUrlPostCode                 @"http://ws.postcoder.com/pcw/%@/address/uk/%@?format=json"
#define g_PostCode_ApiKey                       @"PCWCT-ZVKB4-N2CYH-YBW7Z"

#define g_WebserviceUrlPostCodeValidate         @"http://ws.postcoder.com/pcw/%@/codepoint/validatepostcode/%@?format=json"

/*
 http://ws.postcoder.com/pcw/PCW45-12345-12345-1234X/codepoint/validatepostcode/NR14%207PZ?format=json
 http://ws.postcoder.com/pcw/PCW45-12345-12345-1234X/street/uk/NR14%207PZ?format=json
 http://ws.postcoder.com/pcw/PCW45-12345-12345-1234X/street/uk/34r3fw?format=json
 http://ws.postcoder.com/pcw/PCWCT-ZVKB4-N2CYH-YBW7Z/street/uk/sfdsf?format=json
 http://ws.postcoder.com/pcw/PCWCT-ZVKB4-N2CYH-YBW7Z/codepoint/validatepostcode/W1A1AX?format=json
 
 W1N 4DJ, EC1A 1BB, CR03RL, W1A1AX
 
 //http://ws.postcoder.com/pcw/PCW45-12345-12345-1234X/codepoint/validatepostcode/NR14%207PZ?format=json
 */

//Web-Sevice PageName
#define g_Pagename_Api                          @""              //?,   api.php
#define g_Pagename_Registration                 @"registration.php"
#define g_Pagename_Login                        @"login.php"

#define g_Database_Name                         @"GWWhiteboard.sqlite3"   //testDB.sqlite3


////////////////GENERAL////////////////

//Device Compatibility
#define g_IS_IPHONE             ( [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] )
#define g_IS_IPOD               ( [[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"] )
#define g_IS_IPAD               ( [[[UIDevice currentDevice] model] isEqualToString:@"iPad"] )

#define g_IS_IPHONE_4_SCREEN        [[UIScreen mainScreen] bounds].size.height >= 480.0f && [[UIScreen mainScreen] bounds].size.height < 568.0f
#define g_IS_IPHONE_5_SCREEN        [[UIScreen mainScreen] bounds].size.height >= 568.0f && [[UIScreen mainScreen] bounds].size.height < 667.0f
#define g_IS_IPHONE_6_SCREEN        [[UIScreen mainScreen] bounds].size.height >= 667.0f && [[UIScreen mainScreen] bounds].size.height < 736.0f
#define g_IS_IPHONE_6PLUS_SCREEN    [[UIScreen mainScreen] bounds].size.height >= 736.0f && [[UIScreen mainScreen] bounds].size.height < 1024.0f
//IPHONE 6        = 750 x 1334 (@2x) for portrait       //375 x 667
//IPHONE 6 PLUS   = 1242 x 2208 (@2x) for portrait      //414 x 736

//OS Version
#define g_IS_iOS7               ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 7 && [[[UIDevice currentDevice] systemVersion] floatValue] < 8 )
#define g_IS_iOS8               ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 8 )
//#define g_IS_iOS7               ( SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0") && SYSTEM_VERSION_LESS_THAN(@"8.0") )
//#define g_IS_iOS8               ( SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0") && SYSTEM_VERSION_LESS_THAN(@"9.0") )


//Other Defaults
#define g_Default_Timeout_Seconds				600		//Timeout
#define g_Default_DeviceType					1		//iPhone
#define g_Default_CharactorLimit				149		//Charactor Limit
#define g_Default_PasswordMinLength				6		//Password Minimum Length
#define g_Default_Animation_Duration			0.5		//Animation Duration
#define g_Default_Image_Corner_Radious			5.0		//Image
#define g_Default_Duration_URLRedirect			4.0		//Wait for Redirect URL

#define g_Default_API_Call                      15.0    //First API Call When No Records in List
#define g_Default_API_Call_Duration             30.0    //API Call to Work
#define g_Default_API_Call_Record_Per_Page      5       //Record per Page - for Calling

#define g_Default_Separator                     @"$$$"  //Multiple phones/emails Seperator (Ex. e1@e.com###e2@e.com, 1234560789###1593572486)
#define g_Default_Separator_2                   @"="    //Contact Record Parameter Seperator (Ex. 1=1234560789=e1@e.com)
#define g_Default_Separator_3                   @"|"    //Contact Record Seperator (Ex. 1=1234560789=e1@e.com|2=1593572486=e2@e.com)

//Document Directory
#define kAppDirectoryPath       NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
//Cache Directory
#define kAppCachePath           NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)

//Conversion
#define M_PI                        3.14159265358979323846264338327950288   /* pi */

#define DegreesToRadians(degrees)   (degrees * M_PI / 180)
#define RadiansToDegrees(radians)   (radians * 180/M_PI)

//Google Map
#define g_GoogleGeoCodingString     @"http://maps.google.com/maps/geo?q=%f,%f&output=csv"
#define g_Default_Latitude          23.012231
#define g_Default_Longitude         72.511569

#define	g_MeterToMile               0.000621371192

//Color
#define UIColorFromHEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]
#define RGB(r, g, b)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a)        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

//DateTime Format
#define g_DateTimeFormatDefaultAMPM		@"yyyy-MM-dd HH:mm"
#define g_DateTimeFormatDefaultGPS		@"yyyy-MM-dd HH:mm:ss"
#define g_DateTimeFormatDefault			@"yyyy-MM-dd HH:mm:ss Z"	//yyyy-MM-dd'T'HH:mm:ss.S   //yyyy-MM-dd HH:mm:ss
#define g_DateTimeFormatDefaultZone     @"yyyy-MM-dd HH:mm:ss ZZZZ"	//yyyy-MM-dd'T'HH:mm:ss.S
#define g_DateFormatDefault				@"yyyy-MM-dd"			//dd/MM/yyyy //eee MMM dd HH:mm:ss ZZZZ yyyy //eee MMM dd hh:mm:ss a //MMM YYYY //yyyy-MM-dd
#define g_DayFormatCalendar				@"dd"
#define g_TimeFormatDefault				@"HH:mm"
#define g_TimeFormatFullDefault			@"HH:mm:ss"

#define g_DateFormatDisplay2            @"MMMM dd, yyyy"

#define g_DateTimeFormatDisplay			@"dd MMMM yyyy HH:mm" //yyyy-MM-dd'T'HH:mm:ss.S    //yyyy-MM-dd HH:mm:ss
#define g_DateTimeFormatDisplayAMPM     @"dd MMMM yyyy hh:mm a" //yyyy-MM-dd'T'HH:mm:ss.S    //yyyy-MM-dd HH:mm:ss
#define g_DateFormatDisplay				@"dd MMMM yyyy"          //MM/dd/yyyy    //dd/MM/yyyy //eee MMM dd HH:mm:ss ZZZZ yyyy  //eee MMM dd hh:mm:ss a  //MMM YYYY //yyyy-MM-dd
#define g_TimeFormatDisplay				@"hh:mm a"             //HH:mm a

#define g_DateFormat_Facebook			@"yyyy-MM-dd'T'HH:mm:ssZZZ"
#define g_DateFormat_Twitter			@"eee MMM dd HH:mm:ss ZZZZ yyyy"

//Font-Family
#define g_Font_Name_Default				@"Helvetica Neue"
#define g_Font_Size_Title_Default		18.0
#define g_Font_Size_Default				14.0

#define g_Font_Name_Default_Control		@"Helvetica Neue"   //Arial
#define g_Font_Size_Default_Control		13.0

//Alert
#define g_Alert_DisplayTime				@"2"        //In Second
#define g_Alert_Extra_Height			@"70"

//Size
#define g_Size_Width_Default			20000

//Color
#define g_ColorPlaceholderDefault		[UIColor lightGrayColor]
#define g_ColorDefault					[UIColor grayColor]
#define g_ColorYes						[UIColor greenColor]
#define g_ColorNo						[UIColor redColor]
#define g_ColorComplete					[UIColor greenColor]
#define g_ColorCancel					[UIColor redColor]

//Cell Content
#define g_CellHeight_Simple_Default		44.0f
#define g_Cell_Content_Margin			10.0f
#define g_Cell_Content_Width			320.0f

//TextView Content
#define g_TextView_Content_Margin		-8.0f
#define g_TextView_Content_Width		200.0f

//Border
#define g_Border_Radius_Default         10.0
#define g_Border_Width_Default			1.0

//For Success/Failure/Duplicate Response
#define g_Response_Success				1
#define g_Response_Failure				2
#define g_Response_Duplicate			3

//For Default Selection
#define kPlaceholder_PostCode           @"Post Code"

#define g_Default_SelectText			@"Title"   //Select
#define g_Default_SelectID				0
#define g_Default_IntegerValue			0

#define g_Default_PasswordLength		6

//Tab-ID
#define g_TabID_Tab1            0
#define g_TabID_Tab2            1
#define g_TabID_Tab3            2
#define g_TabID_Tab4            3
#define g_TabID_Tab5            4
