//
//  GameScene.m
//  DuckDuckPuke
//
//  Created by Jacob O'Donnell on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "CCAnimationHelper.h"
#import "Duck.h"

#define kTagShakeMeLabel 11

@interface GameScene (PrivateMethods)
-(void) createShakeMeLabel;
-(void) createDuck;
-(void) activateShakeMeLabel:(ccTime) delta;
-(void) shakeMeStartBlink:(ccTime) delta;
-(void) shakeMeStopBlink;
-(void) createAds;
@end


@implementation GameScene

@synthesize lastAcceleration;

+(id) scene
{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [GameScene node];
    [scene addChild:layer];
    return scene;
}

-(id) init
{
    if ((self = [super init]))
    {
        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
        
        self.isAccelerometerEnabled = YES;
        [self createDuck];
        [self createShakeMeLabel];
        [self createAds];
    }
    return self;
}

-(void) createAds
{
    CGSize size = [[CCDirector sharedDirector] winSize];

    controller = [[RootViewController alloc]init];
    controller.view.frame = CGRectMake(0,0,size.width,size.height);

    bannerView = [[GADBannerView alloc]
                     initWithFrame:CGRectMake(size.width/2-160,
                                              size.height -
                                              GAD_SIZE_320x50.height,
                                              GAD_SIZE_320x50.width,
                                              GAD_SIZE_320x50.height)];

    bannerView.adUnitID = @"a14e40bb90c10a5";
    bannerView.rootViewController = controller;

    [bannerView loadRequest:[GADRequest request]];

    [controller.view addSubview:bannerView];
    [[[CCDirector sharedDirector] openGLView]addSubview : controller.view];
}

-(void) createShakeMeLabel
{
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Shake Me!" fontName:@"Marker Felt" fontSize:40];
    CGSize size = [[CCDirector sharedDirector] winSize];
    label.position = CGPointMake(size.width / 2, size.height * 0.9);
    label.tag = kTagShakeMeLabel;
    label.visible = NO;
    [self addChild: label];
    [self schedule:@selector(activateShakeMeLabel:) interval:10.0f];
}

-(void) activateShakeMeLabel:(ccTime) delta
{
    CCLabelTTF *label = (CCLabelTTF*)[self getChildByTag:kTagShakeMeLabel];
    label.visible = YES;

    [self schedule:@selector(shakeMeStartBlink:) interval:0.3f];
}

-(void) shakeMeStartBlink:(ccTime) delta
{
    CCLabelTTF *label = (CCLabelTTF*)[self getChildByTag:kTagShakeMeLabel];
    CCBlink *blink = [CCBlink actionWithDuration:2 blinks:2];

    CCCallFunc* actionCallFunc = [CCCallFunc actionWithTarget:self selector:@selector(shakeMeStopBlink)];
    CCSequence *sequence = [CCSequence actions: blink, actionCallFunc, nil];

    [label runAction:sequence];
    [self unschedule:@selector(shakeMeStartBlink:)];
}

-(void) shakeMeStopBlink
{
    CCLabelTTF *label = (CCLabelTTF*)[self getChildByTag:kTagShakeMeLabel];
    label.visible = NO;
}

-(void) createDuck
{
    duck = [Duck duck];
    [duck startStandingAnimation];
    [self addChild:duck z:0 tag:1];
    [self scheduleUpdate];
}

-(void) update:(ccTime)delta
{
    duck.isShaking = isShaking;
}

-(void) dealloc
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    [bannerView release];
    [controller.view removeFromSuperview];
    [controller release];
    [super dealloc];
}

- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    if (self.lastAcceleration) {
        [self checkForShaking:acceleration];
    }
    self.lastAcceleration = acceleration;
}

-(void) checkForShaking:(UIAcceleration *)acceleration
{
    if (!isShaking && [self isShakingCheck:acceleration andThreshold:0.7]) {
        isShaking = YES;
        [duck endStandingAnimation];
        [duck startPukingAnimation];
    } else if (isShaking && ![self isShakingCheck:acceleration andThreshold:0.2]) {
        isShaking = NO;

        [duck startStandingAnimation];
    }
}

-(BOOL) isShakingCheck:(UIAcceleration *)current andThreshold:(double)threshold
{
    double
    deltaX = fabs(self.lastAcceleration.x - current.x),
    deltaY = fabs(self.lastAcceleration.y - current.y),
    deltaZ = fabs(self.lastAcceleration.z - current.z);
    
    return
    (deltaX > threshold && deltaY > threshold) ||
    (deltaX > threshold && deltaZ > threshold) ||
    (deltaY > threshold && deltaZ > threshold);
}

@end
