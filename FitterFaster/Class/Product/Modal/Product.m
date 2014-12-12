//
//  Product.m
//  GW Whiteboard
//
//  Created by WebInfoways on 29/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "Product.h"

@implementation Product

@synthesize intProductID;
@synthesize strTitle,strPrice,strCurrency;
@synthesize strVolume,strServing,strSize;
@synthesize intAvailableQty,intCartQty;
@synthesize strPhotoUrl,imgPhoto,imgPhotoData,bolPhotoAvailable;
@synthesize strIsPrevOrder,strRowTotal,strDesc;

-(void)dealloc{
    [self.strTitle release];
    [self.strPrice release];
    [self.strCurrency release];
    
    [self.strVolume release];
    [self.strServing release];
    [self.strSize release];
    
    [self.strPhotoUrl release];
    [self.imgPhoto release];
    [self.imgPhotoData release];
    
    [self.strIsPrevOrder release];
    [self.strRowTotal release];
    [self.strDesc release];
    
    [super dealloc];
}

@end
