//
//  ProductCell.h
//  GW Whiteboard
//
//  Created by WebInfoways on 29/11/14.
//  Copyright (c) 2014 Test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UITableViewCell

@property(nonatomic,retain) IBOutlet UIView *view1;
@property(nonatomic,retain) IBOutlet UIImageView *imgPhoto1;
@property(nonatomic,retain) IBOutlet UIImageView *imgPrevOrder1;
@property(nonatomic,retain) IBOutlet UILabel *lblName1;
@property(nonatomic,retain) IBOutlet UILabel *lblPrice1;
@property(nonatomic,retain) IBOutlet UILabel *lblVolume1;
@property(nonatomic,retain) IBOutlet UILabel *lblServing1;
@property(nonatomic,retain) IBOutlet UILabel *lblSize1;
@property(nonatomic,retain) IBOutlet UILabel *lblDesc1;
@property(nonatomic,retain) IBOutlet UITextField *txtQty1;
@property(nonatomic,retain) IBOutlet UIButton *btnAddToCart1;

@property(nonatomic,retain) IBOutlet UIButton *btnCell1;

@property(nonatomic,retain) IBOutlet UIView *view2;
@property(nonatomic,retain) IBOutlet UIImageView *imgPhoto2;
@property(nonatomic,retain) IBOutlet UIImageView *imgPrevOrder2;
@property(nonatomic,retain) IBOutlet UILabel *lblName2;
@property(nonatomic,retain) IBOutlet UILabel *lblPrice2;
@property(nonatomic,retain) IBOutlet UILabel *lblVolume2;
@property(nonatomic,retain) IBOutlet UILabel *lblServing2;
@property(nonatomic,retain) IBOutlet UILabel *lblSize2;
@property(nonatomic,retain) IBOutlet UILabel *lblDesc2;
@property(nonatomic,retain) IBOutlet UITextField *txtQty2;
@property(nonatomic,retain) IBOutlet UIButton *btnAddToCart2;

@property(nonatomic,retain) IBOutlet UIButton *btnCell2;

@end
