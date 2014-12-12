//
//  Product.h
//  GW Whiteboard
//
//  Created by WebInfoways on 29/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject {
    int intProductID;
    
    NSString *strTitle;
    NSString *strPrice;
    NSString *strCurrency;
    
    NSString *strVolume;
    NSString *strServing;
    NSString *strSize;
    
    int intAvailableQty;
    int intCartQty;
    
    NSString *strPhotoUrl;
    UIImage *imgPhoto;
    NSData *imgPhotoData;
    BOOL bolPhotoAvailable;
    
    NSString *strIsPrevOrder;
    NSString *strRowTotal;
    
    NSString *strDesc;
}
@property(nonatomic) int intProductID;

@property(nonatomic, retain) NSString *strTitle;
@property(nonatomic, retain) NSString *strPrice;
@property(nonatomic, retain) NSString *strCurrency;

@property(nonatomic, retain) NSString *strVolume;
@property(nonatomic, retain) NSString *strServing;
@property(nonatomic, retain) NSString *strSize;

@property(nonatomic) int intAvailableQty;
@property(nonatomic) int intCartQty;

@property(nonatomic,retain) NSString *strPhotoUrl;
@property(nonatomic,retain) UIImage *imgPhoto;
@property(nonatomic,retain) NSData *imgPhotoData;
@property(nonatomic) BOOL bolPhotoAvailable;

@property(nonatomic, retain) NSString *strIsPrevOrder;
@property(nonatomic, retain) NSString *strRowTotal;
@property(nonatomic, retain) NSString *strDesc;

@end
