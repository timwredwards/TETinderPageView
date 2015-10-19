//
//  TEColorCrossfade.m
//  TinderPageViewExample
//
//  Created by Timothy Edwards on 19/10/2015.
//  Copyright © 2015 Timothy Edwards. All rights reserved.
//
//  Borrowed from https://github.com/cbpowell/UIColor-CrossFade


#import "TEColorCrossfade.h"

@implementation TEColorCrossfade

+(UIColor*)colorForFadeBetweenFirstColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor atRatio:(CGFloat)ratio {
    
    if (CGColorGetColorSpace(firstColor.CGColor) != CGColorGetColorSpace(secondColor.CGColor))
    {
        firstColor = [TEColorCrossfade colorConvertedToRGBA:firstColor];
        secondColor = [TEColorCrossfade colorConvertedToRGBA:secondColor];
    }
    
    // Grab color components
    const CGFloat *firstColorComponents = CGColorGetComponents(firstColor.CGColor);
    const CGFloat *secondColorComponents = CGColorGetComponents(secondColor.CGColor);
    
    // Interpolate between colors
    CGFloat interpolatedComponents[CGColorGetNumberOfComponents(firstColor.CGColor)] ;
    for (NSUInteger i = 0; i < CGColorGetNumberOfComponents(firstColor.CGColor); i++)
    {
        interpolatedComponents[i] = firstColorComponents[i] * (1 - ratio) + secondColorComponents[i] * ratio;
    }
    
    // Create interpolated color
    CGColorRef interpolatedCGColor = CGColorCreate(CGColorGetColorSpace(firstColor.CGColor), interpolatedComponents);
    UIColor *interpolatedColor = [UIColor colorWithCGColor:interpolatedCGColor];
    CGColorRelease(interpolatedCGColor);
    
    return interpolatedColor;
}

+(UIColor *)colorConvertedToRGBA:(UIColor *)colorToConvert {
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat alpha;
    
    // Convert color to RGBA with a CGContext. UIColor's getRed:green:blue:alpha: doesn't work across color spaces. Adapted from http://stackoverflow.com/a/4700259
    
    alpha = CGColorGetAlpha(colorToConvert.CGColor);
    
    CGColorRef opaqueColor = CGColorCreateCopyWithAlpha(colorToConvert.CGColor, 1.0f);
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[CGColorSpaceGetNumberOfComponents(rgbColorSpace)];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel, 1, 1, 8, 4, rgbColorSpace, (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGContextSetFillColorWithColor(context, opaqueColor);
    CGColorRelease(opaqueColor);
    CGContextFillRect(context, CGRectMake(0.f, 0.f, 1.f, 1.f));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    
    red = resultingPixel[0] / 255.0f;
    green = resultingPixel[1] / 255.0f;
    blue = resultingPixel[2] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
