//
//  ViewController.h
//  TinderPageView
//
//  Created by Timothy Edwards on 07/10/2015.
//  Copyright © 2015 Timothy Edwards. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TETinderButtonSpecifics.h"

@interface TETinderPageView : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>


@property (strong, nonatomic, readonly) UIPageViewController *PVC;
@property (strong, nonatomic, readonly) UIView *navigationBar;
@property (strong, nonatomic, readonly) UIView *divider;
@property (strong, nonatomic, readonly) NSArray *viewControllers;
@property (strong, nonatomic, readonly) NSArray *buttons;

@property (strong, nonatomic, readonly) TETinderButtonSpecifics *offscreenLeftButtonSpecifics;
@property (strong, nonatomic, readonly) TETinderButtonSpecifics *leftButtonSpecifics;
@property (strong, nonatomic, readonly) TETinderButtonSpecifics *centerButtonSpecifics;
@property (strong, nonatomic, readonly) TETinderButtonSpecifics *rightButtonSpecifics;
@property (strong, nonatomic, readonly) TETinderButtonSpecifics *offscreenRightButtonSpecifics;

@property (nonatomic) NSUInteger selectedIndex;

-(instancetype)initWithViewControllers:(NSArray*)viewControllers buttonImages:(NSArray*)buttonImages;

@end
