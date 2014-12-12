//
//  DBAdapter.h
//  iOSCodeStructure
//
//  Created by Nishant on 10/01/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AppDelegate;

@interface DBAdapter : NSObject {
	//database related properties
	sqlite3 *database;
	
	//Appdelegate
	AppDelegate *appDelegate;
}
@property (nonatomic) sqlite3 *database;

//instance methods called once
-(id)init;

//Function to check for Database whether exists or not. If not copy it to document directory
-(void)checkAndCreateDatabase;

@end
