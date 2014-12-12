//
//  DBFunctionManager.m
//  iOSCodeStructure
//
//  Created by Nishant on 10/01/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import "DBFunctionManager.h"

static sqlite3_stmt *update_statement = nil;

@implementation DBFunctionManager

#pragma mark - Execute General Query
+(BOOL)executeGeneralQuery:(const char *)query{
	update_statement = nil;
	
    // Open the database. The database was prepared outside the application.
	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
	// Compile the statement if needed.
	if (update_statement == nil) {
		const char *sql = query;
		if (sqlite3_prepare_v2(appDelegate.objDBAdapter.database, sql, -1, &update_statement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(appDelegate.objDBAdapter.database));
			return FALSE; //return 0;
		}
	}
	// Bind the primary key variable.
	//sqlite3_bind_int(update_statement, 1, ID);
	
	// Execute the query.
	int success = sqlite3_step(update_statement);
	
	// Reset the statement for future use.
	sqlite3_reset(update_statement);
	
	// Handle errors.
	if(SQLITE_DONE != success) {
		NSAssert1(0, @"Error: failed to update from database with message '%s'.", sqlite3_errmsg(appDelegate.objDBAdapter.database));
		return FALSE; //return 0;
	}
	
	return TRUE; //return 1;
}

@end
