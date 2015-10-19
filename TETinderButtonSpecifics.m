//
//  TESlidingButtonSpecifics.m
//  TinderPageView
//
//  Created by Timothy Edwards on 16/10/2015.
//  Copyright © 2015 Timothy Edwards. All rights reserved.
//

#import "TETinderButtonSpecifics.h"

@implementation TETinderButtonSpecifics

- (instancetype)init
{
    self = [super init];
    if (self) {
        _size = CGSizeMake(30, 30);
        _color = [UIColor lightGrayColor];
    }
    return self;
}

-(CGPoint)getCalculatedPosition{
    return CGPointMake(_position.x+_offset.horizontal, _position.y+_offset.vertical);
}

-(void)setSize:(CGSize)size color:(UIColor *)color offset:(UIOffset)offset{
    [self setSize:size];
    [self setColor:color];
    [self setOffset:offset];
}

@end
