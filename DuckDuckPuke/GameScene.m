//
//  GameScene.m
//  DuckDuckPuke
//
//  Created by Jacob O'Donnell on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"


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
    player = [CCSprite spriteWithFile:@"daffystanding.png"];
    [self addChild:player z:0 tag:1];

    CGSize screensize = [[CCDirector sharedDirector] winSize];
    player.position = CGPointMake(screensize.width / 2, screensize.height / 2);
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
    if (!isShaking && isShakingCheck(self.lastAcceleration, acceleration, 0.7)) {
        isShaking = YES;
    } else if (isShaking && !isShakingCheck(self.lastAcceleration, acceleration, 0.2)) {
        isShaking = NO;
        [self removeChildByTag:1 cleanup:YES];
    }
}

@end
