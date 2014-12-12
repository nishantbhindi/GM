//
//  CategoryCell.m
//  GW Whiteboard
//
//  Created by WebInfoways on 02/12/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

@synthesize imgPhoto, lblName,btnCell;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    self.imgPhoto = nil;
    [self.imgPhoto release];
    
    [self.lblName release];
    [self.btnCell release];
    
    [super dealloc];
}

@end
