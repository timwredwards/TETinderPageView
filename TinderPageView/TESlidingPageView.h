//
//  ViewController.h
//  TinderPageView
//
//  Created by Timothy Edwards on 07/10/2015.
//  Copyright © 2015 Timothy Edwards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TESlidingPageView : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UIColor *navigationBarColor;
@property (strong, nonatomic) UIColor *overscrollColor;

@property (strong, nonatomic) UIColor *dividerColor;
@property (nonatomic) CGFloat dividerHeight;

@property (strong, nonatomic) UIColor *centerIconColor;
@property (strong, nonatomic) UIColor *sideIconColor;

@property (nonatomic) UIOffset centerIconOffset;
@property (nonatomic) UIOffset leftIconOffset;
@property (nonatomic) UIOffset rightIconOffset;

@property (nonatomic) CGSize centerIconSize;
@property (nonatomic) CGSize sideIconSize;

@property (nonatomic) NSUInteger selectedIndex;

@property (nonatomic) BOOL bounces;


-(void)setViewControllers:(NSArray*)viewControllers;
-(void)setIconImages:(NSArray*)iconImages;
-(instancetype)initWithViewControllers:(NSArray*)viewControllers iconImages:(NSArray*)iconImages;

@end
