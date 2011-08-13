//
//  Duck.m
//  DuckDuckPuke
//
//  Created by Jacob O'Donnell on 8/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Duck.h"
#import "CCAnimationHelper.h"

#define kTagWalkingAnimation 10

@interface Duck (PrivateMethods)
-(id) initWithDuckImage;
@end

@implementation Duck

@synthesize isShaking;
@synthesize isPuking;

+(id) duck
{
    return [[[self alloc] initWithDuckImage] autorelease];
}

-(id) initWithDuckImage
{
    CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
    [frameCache addSpriteFramesWithFile:@"duckpuke.plist"];

    if ((self = [super initWithSpriteFrameName:@"duckpuke0.png"]))
    {
        CCAnimation* animUpset = [CCAnimation animationWithFrame:@"duckpuke" frameCount:19 delay:0.08f];
        animUpset.delay = 0.08;
        [[CCAnimationCache sharedAnimationCache] addAnimation:animUpset name:@"daffyupset"];

        CCAnimation* anim = [CCAnimation animationWithFrame:@"duckpuke" frameCount:1 delay:0.08f];
        anim.delay = 0.08;
        [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"daffystanding"];

        CGSize screensize = [[CCDirector sharedDirector] winSize];
        self.position = CGPointMake(screensize.width / 2, screensize.height / 2);
    }

    return self;
}

-(void) startStandingAnimation
{
    CCAnimate* animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"daffystanding"]];
    CCRepeatForever* repeat = [CCRepeatForever actionWithAction:animate];
    repeat.tag = kTagWalkingAnimation;
    [self runAction:repeat];
}

-(void) endStandingAnimation
{
    [self stopActionByTag:kTagWalkingAnimation];
}

-(void) endPukingAnimation
{
    isPuking = NO;
    if (isShaking)
        [self startPukingAnimation];
    else
        [self startStandingAnimation];
}

-(void) startPukingAnimation
{
    isPuking = YES;
    CCAnimate* animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"daffyupset"]];

    CCCallFunc* actionCallFunc = [CCCallFunc actionWithTarget:self selector:@selector(endPukingAnimation)];
    CCSequence *sequence = [CCSequence actions: animate, actionCallFunc, nil];

    [self runAction:sequence];
}

-(void) dealloc
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [super dealloc];
}
@end
