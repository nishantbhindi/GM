//
//  QRCodeAdapter.m
//  CodeSafe
//
//  Created by WebInfoways on 10/09/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import "QRCodeAdapter.h"

static sqlite3_stmt *select_statement = nil;
static sqlite3_stmt *insert_statement = nil;
static sqlite3_stmt *update_statement = nil;
//static sqlite3_stmt *delete_statement = nil;

@implementation QRCodeAdapter

#pragma mark - Sample Methods of Select/Insert/Update/Delete to Copy
-(int)insertQRCode:(QRCode *)pobjQRCode{
	// Open the database. The database was prepared outside the application.
	appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	const char *insertSql;
	insertSql = nil;
	insert_statement = nil;
	
	if(insert_statement == nil)
	{
		insertSql = "INSERT INTO tblQRCode (Content, Format, Type, Time, Metadata, Image, Favourite, DisplayText) VALUES(?,?,?,?,?,?,?,?)";
		if(sqlite3_prepare_v2(appDelegate.objDBAdapter.database, insertSql, -1, &insert_statement, NULL) != SQLITE_OK){
			NSAssert1(0, @"Error: failed to prepare insert statement with message '%s'.", sqlite3_errmsg(appDelegate.objDBAdapter.database));
			return 0;
		}
		
		sqlite3_bind_text(insert_statement, 1, [pobjQRCode.strContent UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_text(insert_statement, 2, [pobjQRCode.strFormat UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insert_statement, 3, [pobjQRCode.strType UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insert_statement, 4, [pobjQRCode.strTime UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insert_statement, 5, [pobjQRCode.strMetadata UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insert_statement, 6, [pobjQRCode.strImage UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_int(insert_statement, 7, pobjQRCode.intIsFavourite);
		sqlite3_bind_text(insert_statement, 8, [pobjQRCode.strDisplayText UTF8String], -1, SQLITE_TRANSIENT);
        
		//sqlite3_bind_double(insert_statement, 5, pobjQRCode.fltLatitude);
		//sqlite3_bind_double(insert_statement, 6, pobjQRCode.fltLongitude);
	}
	//Insert the values into DB
	if(sqlite3_step(insert_statement) != SQLITE_DONE)
	{
		NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(appDelegate.objDBAdapter.database));
		return 0;
	}
	else
	{
		// SQLite provides a method which retrieves the value of the most recently auto-generated primary key sequence
		// in the database. To access this functionality, the table should have a column declared of type
		// "INTEGER PRIMARY KEY"
		int primaryKey = sqlite3_last_insert_rowid(appDelegate.objDBAdapter.database);
		return primaryKey;
	}
	
	//Reset the add statement.
	sqlite3_reset(insert_statement);
	
	return 0;
}
#pragma mark -
-(void)selectQRCodeById:(int)pintQRCodeId :(NSMutableArray *)pArrQRCode{
   	// Open the database. The database was prepared outside the application.
	appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	select_statement = nil;
	NSString *strSelectQuery = [NSString stringWithFormat:@"SELECT Id, Content, Format, Type, Time, Metadata, Image, Favourite FROM tblQRCode WHERE Id=%d", pintQRCodeId];
	const char *sqlStatement = [strSelectQuery UTF8String];
	
	if(sqlite3_prepare_v2(appDelegate.objDBAdapter.database, sqlStatement, -1, &select_statement, NULL) == SQLITE_OK)
	{
		// Loop through the results and add them to the feeds array
		while(sqlite3_step(select_statement) == SQLITE_ROW)
		{
			QRCode *objQRCode = [[QRCode alloc] init];
			objQRCode.intQRCodeID = sqlite3_column_int(select_statement, 0);
			objQRCode.strContent = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 1)];
			objQRCode.strFormat = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 2)];
            objQRCode.strType = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 3)];
            objQRCode.strTime = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 4)];
            objQRCode.strMetadata = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 5)];
            objQRCode.strImage = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 6)];
			objQRCode.intIsFavourite = sqlite3_column_int(select_statement, 7);
			[pArrQRCode addObject:objQRCode];
			[objQRCode release];
		}
	}
	// Release the compiled statement from memory
	sqlite3_finalize(select_statement);
	select_statement = nil;
}
-(BOOL)updateQRCode:(QRCode *)pobjQRCode{
	// Open the database. The database was prepared outside the application.
	appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	const char *updateSql;
	updateSql = nil;
	update_statement = nil;
    
	if (update_statement == nil) {
		static char *sql = "UPDATE tblQRCode SET Content=?, Format=?, Type=?, Time=?, Metadata=?, Image=?, Favourite=? where Id=?";
		if (sqlite3_prepare_v2(appDelegate.objDBAdapter.database, sql, -1, &update_statement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(appDelegate.objDBAdapter.database));
			return FALSE;
		}
	}
	
	sqlite3_bind_text(update_statement, 1, [pobjQRCode.strContent UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(update_statement, 2, [pobjQRCode.strFormat UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(update_statement, 3, [pobjQRCode.strType UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(update_statement, 4, [pobjQRCode.strTime UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(update_statement, 5, [pobjQRCode.strMetadata UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_text(update_statement, 6, [pobjQRCode.strImage UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_int(update_statement, 7, pobjQRCode.intIsFavourite);
	
	sqlite3_bind_int(update_statement, 8, pobjQRCode.intQRCodeID);
	
	if (sqlite3_step(update_statement) == SQLITE_ERROR) {
		NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(appDelegate.objDBAdapter.database));
		return FALSE;
	} else {
		return TRUE;
	}
	// All data for the book is already in memory, but has not be written to the database
	// Mark as hydrated to prevent empty/default values from overwriting what is in memory
	
	// Because we want to reuse the statement, we "reset" it instead of "finalizing" it.
	sqlite3_reset(update_statement);
	
	return FALSE;
}
-(BOOL)deleteQRCodeById:(int)pintQRCodeId{
	NSString *sqlString;
	const char *sql;
	sqlString = @"DELETE FROM tblQRCode WHERE Id = %d";
	sqlString = [NSString stringWithFormat:sqlString, pintQRCodeId];
	sql = [sqlString UTF8String];
	return [DBFunctionManager executeGeneralQuery:sql];
}

#pragma mark - Check Exists Record
-(int)checkExistRecord:(QRCode *)pobjQRCode{
    int intRecordExists = 0;
    
    // Open the database. The database was prepared outside the application.
	appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	select_statement = nil;
	NSString *strSelectQuery = [NSString stringWithFormat:@"SELECT Id FROM tblQRCode where Content=\"%@\" and Format=\"%@\" and Type=\"%@\" and Metadata=\"%@\"", pobjQRCode.strContent,pobjQRCode.strFormat,pobjQRCode.strType,pobjQRCode.strMetadata];
	const char *sqlStatement = [strSelectQuery UTF8String];
	
	if(sqlite3_prepare_v2(appDelegate.objDBAdapter.database, sqlStatement, -1, &select_statement, NULL) == SQLITE_OK)
	{
		// Loop through the results and add them to the feeds array
		while(sqlite3_step(select_statement) == SQLITE_ROW)
		{
			intRecordExists = 1;
		}
	}
	// Release the compiled statement from memory
	sqlite3_finalize(select_statement);
	select_statement = nil;
    
    return intRecordExists;
}
#pragma mark -
-(int)checkForFavourite:(QRCode *)pobjQRCode{
    int intIsFavourite = 0;
    
    // Open the database. The database was prepared outside the application.
	appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	select_statement = nil;
	NSString *strSelectQuery = [NSString stringWithFormat:@"SELECT Id FROM tblQRCode where Content=\"%@\" and Format=\"%@\" and Type=\"%@\" and Metadata=\"%@\" and Favourite=1", pobjQRCode.strContent,pobjQRCode.strFormat,pobjQRCode.strType,pobjQRCode.strMetadata];
	const char *sqlStatement = [strSelectQuery UTF8String];
	
	if(sqlite3_prepare_v2(appDelegate.objDBAdapter.database, sqlStatement, -1, &select_statement, NULL) == SQLITE_OK)
	{
		// Loop through the results and add them to the feeds array
		while(sqlite3_step(select_statement) == SQLITE_ROW)
		{
			intIsFavourite = 1;
		}
	}
	// Release the compiled statement from memory
	sqlite3_finalize(select_statement);
	select_statement = nil;
    
    return intIsFavourite;
}

#pragma mark - Fetch History/Favourite QR Code
-(void)getHistoryQRCode:(NSMutableArray *)pArrQRCode{
   	// Open the database. The database was prepared outside the application.
	appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	select_statement = nil;
	NSString *strSelectQuery = [NSString stringWithFormat:@"SELECT Id, Content, Format, Type, Time, Metadata, Image, Favourite, DisplayText FROM tblQRCode WHERE  Favourite=0 ORDER BY Time DESC"];
	const char *sqlStatement = [strSelectQuery UTF8String];
	
	if(sqlite3_prepare_v2(appDelegate.objDBAdapter.database, sqlStatement, -1, &select_statement, NULL) == SQLITE_OK)
	{
		// Loop through the results and add them to the feeds array
		while(sqlite3_step(select_statement) == SQLITE_ROW)
		{
			QRCode *objQRCode = [[QRCode alloc] init];
			objQRCode.intQRCodeID = sqlite3_column_int(select_statement, 0);
			objQRCode.strContent = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 1)];
			objQRCode.strFormat = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 2)];
            objQRCode.strType = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 3)];
            objQRCode.strTime = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 4)];
            objQRCode.strMetadata = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 5)];
            objQRCode.strImage = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 6)];
			objQRCode.intIsFavourite = sqlite3_column_int(select_statement, 7);
            objQRCode.strDisplayText = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 8)];
			[pArrQRCode addObject:objQRCode];
			[objQRCode release];
		}
	}
	// Release the compiled statement from memory
	sqlite3_finalize(select_statement);
	select_statement = nil;
}
#pragma mark -
-(void)getFavouriteQRCode:(NSMutableArray *)pArrQRCode{
   	// Open the database. The database was prepared outside the application.
	appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	select_statement = nil;
	NSString *strSelectQuery = [NSString stringWithFormat:@"SELECT Id, Content, Format, Type, Time, Metadata, Image, Favourite FROM tblQRCode WHERE  Favourite=1 ORDER BY Time DESC"];
	const char *sqlStatement = [strSelectQuery UTF8String];
	
	if(sqlite3_prepare_v2(appDelegate.objDBAdapter.database, sqlStatement, -1, &select_statement, NULL) == SQLITE_OK)
	{
		// Loop through the results and add them to the feeds array
		while(sqlite3_step(select_statement) == SQLITE_ROW)
		{
			QRCode *objQRCode = [[QRCode alloc] init];
			objQRCode.intQRCodeID = sqlite3_column_int(select_statement, 0);
			objQRCode.strContent = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 1)];
			objQRCode.strFormat = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 2)];
            objQRCode.strType = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 3)];
            objQRCode.strTime = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 4)];
            objQRCode.strMetadata = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 5)];
            objQRCode.strImage = [FunctionManager getStringValueFromChar:(char *)sqlite3_column_text(select_statement, 6)];
			objQRCode.intIsFavourite = sqlite3_column_int(select_statement, 7);
			[pArrQRCode addObject:objQRCode];
			[objQRCode release];
		}
	}
	// Release the compiled statement from memory
	sqlite3_finalize(select_statement);
	select_statement = nil;
}
-(BOOL)makeQRCodeToFavourite:(QRCode *)pobjQRCode{
	// Open the database. The database was prepared outside the application.
	appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	
	const char *updateSql;
	updateSql = nil;
	update_statement = nil;
    
	if (update_statement == nil) {
		static char *sql = "UPDATE tblQRCode SET Favourite=? where Id=?";
		if (sqlite3_prepare_v2(appDelegate.objDBAdapter.database, sql, -1, &update_statement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(appDelegate.objDBAdapter.database));
			return FALSE;
		}
	}
	
    sqlite3_bind_int(update_statement, 1, pobjQRCode.intIsFavourite);
    sqlite3_bind_int(update_statement, 2, pobjQRCode.intQRCodeID);
	
	if (sqlite3_step(update_statement) == SQLITE_ERROR) {
		NSAssert1(0, @"Error: failed to insert into the database with message '%s'.", sqlite3_errmsg(appDelegate.objDBAdapter.database));
		return FALSE;
	} else {
		return TRUE;
	}
	// All data for the book is already in memory, but has not be written to the database
	// Mark as hydrated to prevent empty/default values from overwriting what is in memory
	
	// Because we want to reuse the statement, we "reset" it instead of "finalizing" it.
	sqlite3_reset(update_statement);
	
	return FALSE;
}

@end
