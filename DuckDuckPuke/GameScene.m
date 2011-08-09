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
    }
    return self;
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
