//
//  TESlidingButtonSpecifics.h
//  TinderPageView
//
//  Created by Timothy Edwards on 16/10/2015.
//  Copyright © 2015 Timothy Edwards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TETinderButtonSpecifics : NSObject

@property (retain, nonatomic) UIColor *color;
@property (nonatomic) CGPoint position;
@property (nonatomic) UIOffset offset;
@property (nonatomic) CGSize size;

-(void)setSize:(CGSize)size color:(UIColor*)color offset:(UIOffset)offset;

-(CGPoint)getCalculatedPosition;

@end
