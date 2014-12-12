//
//  QRCodeAdapter.h
//  CodeSafe
//
//  Created by WebInfoways on 10/09/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QRCode.h"

@interface QRCodeAdapter : NSObject {
	//Appdelegate
	AppDelegate *appDelegate;
}

//Sample Methods of Select/Insert/Update/Delete to Copy
-(int)insertQRCode:(QRCode *)pobjQRCode;

-(int)checkExistRecord:(QRCode *)pobjQRCode;

-(void)getHistoryQRCode:(NSMutableArray *)pArrQRCode;


-(void)selectQRCodeById:(int)pintQRCodeId :(NSMutableArray *)pArrQRCode;
-(BOOL)updateQRCode:(QRCode *)pobjQRCode;
-(BOOL)deleteQRCodeById:(int)pintQRCodeId;

-(int)checkForFavourite:(QRCode *)pobjQRCode;

-(void)getFavouriteQRCode:(NSMutableArray *)pArrQRCode;
-(BOOL)makeQRCodeToFavourite:(QRCode *)pobjQRCode;

@end
