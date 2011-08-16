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
#define kTagBlinkingAnimation 11
#define kTagQuackingAnimation 12

#define kBlinkInterval 220
#define kQuackInterval 4

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
        [CCAnimation createAnimationWithFileNames: 
                         [NSArray arrayWithObjects:@"duck-puke-1.png", @"duck-puke-2.png", @"duck-puke-3.png", @"duck-puke-4.png", @"duck-puke-5.png", @"duck-puke-6.png", 
                                  @"duck-puke-7.png", @"duck-puke-8.png", @"duck-puke-9.png", @"duck-puke-10.png", @"duck-puke-11.png", @"duck-puke-12.png", @"duck-puke-13.png",
                                  @"duck-puke-14.png", @"duck-puke-15.png", @"duck-puke-16.png", @"duck-puke-17.png", @"duck-puke-18.png", nil]
                     andAnimationName:@"puking"];

        [CCAnimation createAnimationWithFileNames: [NSArray arrayWithObjects:@"duck-standing.png", nil] andAnimationName:@"standing"];
        [CCAnimation createAnimationWithFileNames: [NSArray arrayWithObjects:@"duck-blink-1.png", @"duck-blink-2.png", nil] andAnimationName:@"blinking"];
        [CCAnimation createAnimationWithFileNames: [NSArray arrayWithObjects:@"duck-quack-1.png", @"duck-quack-2.png", nil] andAnimationName:@"quacking"];

        [CCAnimation createAnimationWithFileNames: [NSArray arrayWithObjects:@"duck-puke-15.png", @"duck-puke-16.png", @"duck-puke-17.png", @"duck-puke-18.png", nil] andAnimationName:@"pukeLoop"];

        CGSize screensize = [[CCDirector sharedDirector] winSize];
        self.position = CGPointMake(screensize.width / 2, screensize.height / 4.35);
    }

    return self;
}

-(void) randomBlink
{
    if (!isStanding)
        return;

    int r = arc4random() % kBlinkInterval;
    if (r == 0) {
        [self endStandingAnimation];
        [self startBlinkingAnimation];
    }
}

-(void) randomQuack
{
    if (!isStanding)
        return;

    int r = arc4random() % kQuackInterval;
    if (r == 0) {
        [self endStandingAnimation];
        [self startQuackingAnimation];
    }
}

-(void) startStandingAnimation
{
    isStanding = YES;

    CCAnimate* animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"standing"]];
    CCRepeatForever* repeat = [CCRepeatForever actionWithAction:animate];
    repeat.tag = kTagWalkingAnimation;
    [self runAction:repeat];
}

-(void) startBlinkingAnimation
{
    CCAnimate* animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"blinking"]];
    CCCallFunc* startStandingFunc = [CCCallFunc actionWithTarget:self selector:@selector(startStandingAnimation)];
    CCSequence *sequence = [CCSequence actions: animate, startStandingFunc, nil];
    sequence.tag = kTagBlinkingAnimation;

    [self runAction:sequence];
}

-(void) startQuackingAnimation
{
    CCAnimate* animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"quacking"]];
    CCCallFunc* startStandingFunc = [CCCallFunc actionWithTarget:self selector:@selector(startStandingAnimation)];
    CCSequence *sequence = [CCSequence actions: animate, startStandingFunc, nil];
    sequence.tag = kTagQuackingAnimation;

    [self runAction:sequence];
}

-(void) endStandingAnimation
{
    isStanding = NO;
    [self stopActionByTag:kTagWalkingAnimation];
}

-(void) endAnyAnimations
{
    [self endStandingAnimation];
    [self endBlinkingAnimation];
    [self endQuackingAnimation];
}

-(void) endBlinkingAnimation
{
    [self stopActionByTag:kTagBlinkingAnimation];
}

-(void) endQuackingAnimation
{
    [self stopActionByTag:kTagQuackingAnimation];
}

-(void) endPukingAnimation
{
    if (isShaking) 
    {
        [self continuePukingAnimation];
    }
    else
    {
        isPuking = NO;
        [self startStandingAnimation];
    }
}

-(void) continuePukingAnimation
{
    CCAnimate* animate = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"pukeLoop"]];

    CCCallFunc* actionCallFunc = [CCCallFunc actionWithTarget:self selector:@selector(endPukingAnimation)];
    CCSequence *sequence = [CCSequence actions: animate, actionCallFunc, nil];

    [self runAction:sequence];
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
