//
//  Duck.h
//  DuckDuckPuke
//
//  Created by Jacob O'Donnell on 8/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Duck : CCSprite {
    BOOL isShaking;
    BOOL isPuking;
    BOOL isStanding;
}

@property BOOL isShaking;
@property BOOL isPuking;

+(id) duck;

-(void) startPukingAnimation;
-(void) continuePukingAnimation;
-(void) endPukingAnimation;

-(void) startStandingAnimation;
-(void) endStandingAnimation;

-(void) startBlinkingAnimation;
-(void) endBlinkingAnimation;

-(void) startQuackingAnimation;
-(void) endQuackingAnimation;

-(void) endAnyAnimations;

-(void) randomBlink;
-(void) randomQuack;

@end
