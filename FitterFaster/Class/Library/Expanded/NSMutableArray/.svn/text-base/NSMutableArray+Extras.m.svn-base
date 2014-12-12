//
//  NSMutableArray+Extras.m
//  iOSCodeStructure
//
//  Created by Nishant on 02/01/13.
//  Copyright (c) 2013 Nishant. All rights reserved.
//

#import "NSMutableArray+Extras.h"

@implementation NSMutableArray (Extras)

#pragma mark - Random Number
+(NSMutableArray*)getRandomNos:(NSUInteger)totRandomNos startRange:(NSUInteger)pIntStartFrom endRange:(NSUInteger)pIntEndTo
{
	NSMutableArray *arrRandomNos = [[NSMutableArray alloc] initWithCapacity:totRandomNos];
	
	NSUInteger intAddedItems = 0;
	while (intAddedItems!=totRandomNos)
	{
		NSNumber *randomNumber = [FunctionManager getRandomNumber:pIntStartFrom to:pIntEndTo];
		if(![arrRandomNos containsObject:randomNumber])
		{
			[arrRandomNos addObject:randomNumber];
			intAddedItems++;
		}
	}
	
	return arrRandomNos;
}
#pragma mark - Move Object
-(void)moveObjectFromIndex:(NSUInteger)origIndex toIndex:(NSUInteger)newIndex
{
    if (newIndex != origIndex) {
        id object = [self objectAtIndex:origIndex];
        [object retain];
        [self removeObjectAtIndex:origIndex];
        if (newIndex >= [self count]) {
            [self addObject:object];
        } else {
            [self insertObject:object atIndex:newIndex];
        }
        [object release];
    }
}
#pragma mark - Shuffle
-(void)shuffleArray
{
    for (int i = ([self count]-1); i >= 1; --i)
    {
        int j = arc4random() % i;
        id tempObject = [[self objectAtIndex:j] retain];
        [self replaceObjectAtIndex:j withObject: [self objectAtIndex:i]];
        [self replaceObjectAtIndex:i withObject:tempObject];
        [tempObject release];
    }
}
#pragma mark - Reverse
-(void)reverseArray
{
    int count = [self count];
    
    for (int i = 0; i < count / 2; ++i)
    {
        int j = count - i - 1;
        
        id tempObject = [[self objectAtIndex:i] retain];
        
        [self replaceObjectAtIndex:i withObject:[self objectAtIndex:j]];
        [self replaceObjectAtIndex:j withObject:tempObject];
        
        [tempObject release];
    }
}

@end
