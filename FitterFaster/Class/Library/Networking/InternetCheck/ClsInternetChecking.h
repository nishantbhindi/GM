//
//  ClsInternetChecking.h
//  
//
//  Created by Mobile Developer on 22/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@class AppDelegate;

@interface ClsInternetChecking : NSObject 
{
	Reachability* internetReachable;
	Reachability* hostReachable;
	BOOL boolInternetActive;
	
	AppDelegate *appDelegate;
}

@property (nonatomic,assign) BOOL boolInternetActive;

-(void)checkInternetAvailability;
-(void)checkNetworkStatus:(NSNotification *)notice;

@end
