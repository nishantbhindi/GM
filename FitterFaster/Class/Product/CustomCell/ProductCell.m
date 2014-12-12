//
//  ProductCell.m
//  GW Whiteboard
//
//  Created by WebInfoways on 29/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

@synthesize view1, imgPhoto1,imgPrevOrder1,lblName1,lblPrice1,lblVolume1,lblServing1,lblSize1,lblDesc1,txtQty1,btnAddToCart1,btnCell1;
@synthesize view2, imgPhoto2,imgPrevOrder2,lblName2,lblPrice2,lblVolume2,lblServing2,lblSize2,lblDesc2,txtQty2,btnAddToCart2,btnCell2;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    self.imgPhoto1 = nil;
    [self.imgPhoto1 release];
    self.imgPrevOrder1 = nil;
    [self.imgPrevOrder1 release];
    
    [self.view1 release];
    [self.lblName1 release];
    [self.lblPrice1 release];
    [self.lblVolume1 release];
    [self.lblServing1 release];
    [self.lblSize1 release];
    [self.lblDesc1 release];
    [self.txtQty1 release];
    [self.btnAddToCart1 release];
    [self.btnCell1 release];
    
    
    self.imgPhoto2 = nil;
    [self.imgPhoto2 release];
    self.imgPrevOrder2 = nil;
    [self.imgPrevOrder2 release];
    
    [self.view2 release];
    [self.lblName2 release];
    [self.lblPrice2 release];
    [self.lblVolume2 release];
    [self.lblServing2 release];
    [self.lblSize2 release];
    [self.lblDesc2 release];
    [self.txtQty2 release];
    [self.btnAddToCart2 release];
    [self.btnCell2 release];
    
    [super dealloc];
}

@end
