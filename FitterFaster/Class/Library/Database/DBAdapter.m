//
//  DBAdapter.m
//  iOSCodeStructure
//
//  Created by Nishant on 10/01/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import "DBAdapter.h"

@implementation DBAdapter

@synthesize database;

#pragma mark - instance methods called once
-(DBAdapter*) init
{
	//Check and Create Database if not exists
	[self checkAndCreateDatabase];
	
	return self;
}

#pragma mark - Function to check for Database whether exists or not. If not copy it to document directory
-(void)checkAndCreateDatabase
{
	NSString *databasePath = [FunctionManager getDocumentDirectoryPath:g_Database_Name];
	//NSLog(@"%@", databasePath);
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	BOOL bolDBCreateSuccess;
	if(![fileManager fileExistsAtPath:databasePath])
	{
		NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:g_Database_Name];
		bolDBCreateSuccess = [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:&error];
		[fileManager release];
	}
	else {
		bolDBCreateSuccess=YES;
	}
	
	if (!bolDBCreateSuccess) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
	else {
		//Open DB Connection
		if(sqlite3_open([databasePath UTF8String], &database) != SQLITE_OK){
			//sqlite3_close(database);
			NSLog(@"Error on connect to database! Error = %i", sqlite3_open([databasePath UTF8String], &database));
		}
	}
	
	return;
}

@end
