//
//  NSMutableArray+Extras.h
//  iOSCodeStructure
//
//  Created by Nishant on 02/01/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Extras)

// Random Number
+(NSMutableArray*)getRandomNos:(NSUInteger)totRandomNos startRange:(NSUInteger)pIntStartFrom endRange:(NSUInteger)pIntEndTo;

// Move Object
-(void)moveObjectFromIndex:(NSUInteger)origIndex toIndex:(NSUInteger)newIndex;

// Shuffle
-(void)shuffleArray;

// Reverse
-(void)reverseArray;

@end
