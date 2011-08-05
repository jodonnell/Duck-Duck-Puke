//
//  GameScene.h
//  DuckDuckPuke
//
//  Created by Jacob O'Donnell on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

static BOOL isShakingCheck(UIAcceleration* last, UIAcceleration* current, double threshold) {
    double
    deltaX = fabs(last.x - current.x),
    deltaY = fabs(last.y - current.y),
    deltaZ = fabs(last.z - current.z);
    
    return
    (deltaX > threshold && deltaY > threshold) ||
    (deltaX > threshold && deltaZ > threshold) ||
    (deltaY > threshold && deltaZ > threshold);
}


@interface GameScene : CCLayer {
    BOOL isShaking;
    UIAcceleration* lastAcceleration;
    CCSprite* player;
}
@property(retain) UIAcceleration* lastAcceleration;

+(id) scene;

-(void) createDuck;
-(void) checkForShaking:(UIAcceleration *)acceleration;

@end
