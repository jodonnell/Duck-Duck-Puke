//
//  GameScene.h
//  DuckDuckPuke
//
//  Created by Jacob O'Donnell on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Duck.h"

@interface GameScene : CCLayer {
    BOOL isShaking;
    UIAcceleration* lastAcceleration;
    Duck* duck;
}
@property(retain) UIAcceleration* lastAcceleration;

+(id) scene;

-(void) createDuck;
-(void) checkForShaking:(UIAcceleration *)acceleration;
-(BOOL) isShakingCheck:(UIAcceleration *)current andThreshold:(double)threshold;

@end
