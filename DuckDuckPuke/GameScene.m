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

        player = [CCSprite spriteWithFile:@"daffystanding.png"];
        [self addChild:player z:0 tag:1];

        CGSize screensize = [[CCDirector sharedDirector] winSize];
        player.position = CGPointMake(screensize.width / 2, screensize.height / 2);

    }
    return self;
}

-(void) dealloc
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}
- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    
    if (self.lastAcceleration) {
        if (!histeresisExcited && L0AccelerationIsShaking(self.lastAcceleration, acceleration, 0.7)) {
            histeresisExcited = YES;
            

        } else if (histeresisExcited && !L0AccelerationIsShaking(self.lastAcceleration, acceleration, 0.2)) {
            histeresisExcited = NO;
            [self removeChildByTag:1 cleanup:YES];
        }
    }
    
    self.lastAcceleration = acceleration;
}

@end
