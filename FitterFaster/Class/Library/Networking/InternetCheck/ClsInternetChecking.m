//
//  ClsInternetChecking.m
//  
//
//  Created by Mobile Developer on 22/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ClsInternetChecking.h"

@implementation ClsInternetChecking

@synthesize boolInternetActive;

-(id)init
{
	appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	[self checkInternetAvailability];
	return self;
}

-(void)checkInternetAvailability
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
	
	internetReachable = [[Reachability reachabilityForInternetConnection] retain];
	[internetReachable startNotifier];
	
	hostReachable = [[Reachability reachabilityWithHostName: @"www.google.com"] retain];
	[hostReachable startNotifier];
}

- (void) checkNetworkStatus:(NSNotification *)notice
{
	// called after network status changes
	NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
	switch (internetStatus)
	{
		case NotReachable:
		{
			NSLog(@"The internet is down.");
			self.boolInternetActive = NO;
			break;
		}
		case ReachableViaWiFi:
		{
			NSLog(@"The internet is working via WIFI.");
			self.boolInternetActive = YES;
			break;
		}
		case ReachableViaWWAN:
		{
			NSLog(@"The internet is working via WWAN.");
			self.boolInternetActive = YES;
			break;
		}
	}
	
	NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
	switch (hostStatus)
	{
		case NotReachable:
		{
			NSLog(@"A gateway to the host server is down.");
			self.boolInternetActive = NO;
			break;
		}
		case ReachableViaWiFi:
		{
			NSLog(@"A gateway to the host server is working via WIFI.");
			self.boolInternetActive = YES;
			break;			
		}
		case ReachableViaWWAN:
		{
			NSLog(@"A gateway to the host server is working via WWAN.");
			self.boolInternetActive = YES;			
			break;
		}
	}
	
	if(self.boolInternetActive)	
	{
		self.boolInternetActive= YES;
		[appDelegate removeNoInternetView];
	}
	else 
		[appDelegate showNoInterntConnection];
}

-(void)dealloc 
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
	[internetReachable release];
	[hostReachable release];
	[super dealloc];
}

@end
