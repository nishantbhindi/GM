//
//  UITextView+Extras.h
//  iOSCodeStructure
//
//  Created by Nishant on 09/01/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extras)

// Change Font
-(void)changeFontToDefault;
-(void)changeFontToCustom:(NSString *)pstrFontName withSize:(CGFloat)pfltFontSize;

// Corner
-(void)roundedCornerDefault;
-(void)roundedCornerWithRadius:(CGFloat)pfltRadius
                    borderColor:(CGColorRef)pColor
                    borderWidth:(CGFloat)pfltWidth;

@end
