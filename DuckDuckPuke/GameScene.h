//
//  GameScene.h
//  DuckDuckPuke
//
//  Created by Jacob O'Donnell on 8/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Duck.h"
#import "GADBannerView.h"
#import "RootViewController.h"

@interface GameScene : CCLayer {
    BOOL isShaking;
    UIAcceleration* lastAcceleration;
    Duck* duck;

    GADBannerView *bannerView;
    RootViewController *controller;
}
@property(retain) UIAcceleration* lastAcceleration;

+(id) scene;

-(void) checkForShaking:(UIAcceleration *)acceleration;
-(BOOL) isShakingCheck:(UIAcceleration *)current andThreshold:(double)threshold;

@end
