//
//  UITextViewPlaceHolder.h
//  iOSCodeStructure
//
//  Created by Nishant on 09/01/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITextViewPlaceHolder : UITextView {
    NSString *placeholderText;
    UIColor *placeholderColor;
    
@private
    UILabel *placeHolderLabel;
}

@property (nonatomic, retain) UILabel *placeHolderLabel;
@property (nonatomic, retain) NSString *placeholderText;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;
//-(void)textChanged;

@end
