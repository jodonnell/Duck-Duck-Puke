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
    [frameCache addSpriteFramesWithFile:@"duck.plist"];

    if ((self = [super initWithSpriteFrameName:@"duck-standing.png"]))
    {
        [CCAnimation createAnimationWithFileNames: [NSArray arrayWithObjects:@"duck-puke-1.png", @"duck-puke-2.png", @"duck-puke-3.png", @"duck-puke-4.png", @"duck-puke-5.png", @"duck-puke-6.png", @"duck-puke-7.png", @"duck-puke-8.png", @"duck-puke-9.png", @"duck-puke-10.png", @"duck-puke-11.png", @"duck-puke-12.png", @"duck-puke-13.png", @"duck-puke-14.png", @"duck-puke-15.png", @"duck-puke-16.png", @"duck-puke-17.png", @"duck-puke-18.png", nil] andAnimationName:@"puking"];

        [CCAnimation createAnimationWithFileNames: [NSArray arrayWithObjects:@"duck-standing.png", nil] andAnimationName:@"standing"];

        CGSize screensize = [[CCDirector sharedDirector] winSize];
        self.position = CGPointMake(screensize.width / 2, screensize.height / 2);
    }

    return self;
}

-(void) startStandingAnimation
{
    CCAnimate* animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"standing"]];
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
    CCAnimate* animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"puking"]];

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
