//
//  DBFunctionManager.h
//  iOSCodeStructure
//
//  Created by Nishant on 10/01/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBFunctionManager : NSObject {
	sqlite3 *database;
}
+(BOOL)executeGeneralQuery:(const char *)query;

@end
