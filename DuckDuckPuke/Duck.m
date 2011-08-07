//
//  Duck.m
//  DuckDuckPuke
//
//  Created by Jacob O'Donnell on 8/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Duck.h"
#import "CCAnimationHelper.h"

@interface Duck (PrivateMethods)
-(id) initWithDuckImage;
@end


@implementation Duck

+(id) duck
{
	return [[[self alloc] initWithDuckImage] autorelease];
}

-(id) initWithDuckImage
{
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"ducks.plist"];

    if (self = [CCSprite spriteWithSpriteFrameName:@"daffystanding0.png"])
    {
        CCAnimation* animUpset = [CCAnimation animationWithFrame:@"daffyupset" frameCount:2 delay:0.08f];
        animUpset.delay = 0.08;
        [[CCAnimationCache sharedAnimationCache] addAnimation:animUpset name:@"daffyupset"];

        CCAnimation* anim = [CCAnimation animationWithFrame:@"daffystanding" frameCount:2 delay:0.08f];
        anim.delay = 0.08;
        [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"daffystanding"];

        CCAnimate* animate = [CCAnimate actionWithAnimation:anim];
        CCRepeatForever* repeat = [CCRepeatForever actionWithAction:animate];
        [self runAction:repeat];

        CGSize screensize = [[CCDirector sharedDirector] winSize];
        self.position = CGPointMake(screensize.width / 2, screensize.height / 2);
    }
    return self;
}

-(void) dealloc
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
}
@end
