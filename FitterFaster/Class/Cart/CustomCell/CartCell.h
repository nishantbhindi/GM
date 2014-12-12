//
//  CartCell.h
//  GW Whiteboard
//
//  Created by WebInfoways on 27/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartCell : UITableViewCell

@property (nonatomic,retain) IBOutlet UILabel *lblProduct;
@property (nonatomic,retain) IBOutlet UILabel *lblPrice;
@property (nonatomic,retain) IBOutlet UILabel *lblQty;
@property (nonatomic,retain) IBOutlet UILabel *lblSubTotal;

@property (nonatomic,retain) IBOutlet UITextField *txtQty;

@property (nonatomic,retain) IBOutlet UIButton *btnRemove;

@end
