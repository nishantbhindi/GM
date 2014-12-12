//
//  UITextView+Extras.m
//  iOSCodeStructure
//
//  Created by Nishant on 09/01/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import "UITextView+Extras.h"
#import <QuartzCore/QuartzCore.h>

@implementation UITextView (Extras)

#pragma mark - Change Font
-(void)changeFontToDefault{
    self.font=[UIFont fontWithName:g_Font_Name_Default size:g_Font_Size_Default];
}
-(void)changeFontToCustom:(NSString *)pstrFontName withSize:(CGFloat)pfltFontSize{
    self.font=[UIFont fontWithName:pstrFontName size:pfltFontSize];
}

#pragma mark - Change Corner
-(void)roundedCornerDefault{
    [self roundedCornerWithRadius:g_Border_Radius_Default
                      borderColor:[g_ColorDefault CGColor]
                      borderWidth:g_Border_Width_Default];
}
-(void)roundedCornerWithRadius:(CGFloat)pfltRadius
                   borderColor:(CGColorRef)pColor
                   borderWidth:(CGFloat)pfltWidth{
    self.layer.cornerRadius = pfltRadius;
    self.layer.borderColor = pColor;
    self.layer.borderWidth = pfltWidth;
    self.clipsToBounds = YES;
}

@end
