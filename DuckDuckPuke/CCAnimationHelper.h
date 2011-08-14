//
//  CCAnimationHelper.h
//  SpriteBatches
//
//  Created by Steffen Itterheim on 06.08.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCAnimation (Helper)

+(CCAnimation*) animationWithFrame:(NSString*)frame frameCount:(int)frameCount;
+(CCAnimation*) animationWithFrameNames:(NSArray*)frameNames;
+(void) createAnimationWithFileNames:(NSArray*)fileNames andAnimationName:(NSString*)animationName;

@end
