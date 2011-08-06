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
//        self.shakenLevel = 0;
        [self createDuck];
    }
    return self;
}

-(void) createDuck
{
    player = [Duck duck];
    [self addChild:player z:0 tag:1];
    //[self scheduleUpdate];
}

// -(void) update:(ccTime)delta
// {
// 	// Shooting is relayed to the game scene
// 	[[GameScene sharedGameScene] shootBulletFromShip:self];
// }

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
    } else if (isShaking && ![self isShakingCheck:acceleration andThreshold:0.2]) {
        isShaking = NO;
        [self removeChildByTag:1 cleanup:YES];
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
