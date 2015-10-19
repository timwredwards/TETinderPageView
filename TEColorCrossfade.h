//
//  TEColorCrossfade.h
//  TinderPageViewExample
//
//  Created by Timothy Edwards on 19/10/2015.
//  Copyright © 2015 Timothy Edwards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TEColorCrossfade : NSObject

+(UIColor*)colorForFadeBetweenFirstColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor atRatio:(CGFloat)ratio;

@end
