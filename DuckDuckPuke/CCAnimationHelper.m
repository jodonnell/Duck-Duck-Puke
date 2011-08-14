//
//  CCAnimationHelper.m
//  SpriteBatches
//
//  Created by Steffen Itterheim on 06.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "CCAnimationHelper.h"

@implementation CCAnimation (Helper)

+(CCAnimation*) animationWithFrame:(NSString*)frame frameCount:(int)frameCount
{
	NSMutableArray* frames = [NSMutableArray arrayWithCapacity:frameCount];
        CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
	for (int i = 0; i < frameCount; i++)
	{
		NSString* file = [NSString stringWithFormat:@"%@%i.png", frame, i];
		CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
		[frames addObject:frame];
	}
	
	return [CCAnimation animationWithFrames:frames];
}

+(CCAnimation*) animationWithFrameNames:(NSArray*)frameNames
{
    int frameCount = [frameNames count];
    NSMutableArray* frames = [NSMutableArray arrayWithCapacity:frameCount];
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    for (int i = 0; i < frameCount; i++)
    {
        NSString* file = [frameNames objectAtIndex:i];
        CCSpriteFrame* frame = [frameCache spriteFrameByName:file];
        [frames addObject:frame];
    }
	
    return [CCAnimation animationWithFrames:frames];
}

+(void) createAnimationWithFileNames:(NSArray*)fileNames andAnimationName:(NSString*)animationName
{
    CCAnimation* anim = [CCAnimation animationWithFrameNames:fileNames];
    anim.delay = 0.08;
    [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:animationName];
}


@end
