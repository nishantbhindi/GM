//
//  CartCell.m
//  GW Whiteboard
//
//  Created by WebInfoways on 27/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "CartCell.h"

@implementation CartCell

@synthesize lblProduct,lblPrice,lblQty,lblSubTotal;
@synthesize txtQty,btnRemove;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) dealloc {
    [self.lblProduct release];
    [self.lblPrice release];
    [self.lblQty release];
    [self.lblSubTotal release];
    [self.txtQty release];
    [self.btnRemove release];
    
    [super dealloc];
}

@end
