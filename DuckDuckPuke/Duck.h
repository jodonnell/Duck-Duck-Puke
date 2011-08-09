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
    
}

+(id) duck;
-(void) startStandingAnimation;
-(void) startPukingAnimation;


@end