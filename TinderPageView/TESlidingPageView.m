//
//  ViewController.m
//  TinderPageView
//
//  Created by Timothy Edwards on 07/10/2015.
//  CopyLOL © 2015 Timothy Edwards. All rights reserved.
//

#import "TESlidingPageView.h"

#import "TESlidingPageViewIcon.h"

#import "UIColor+CrossFade.h"

@interface TESlidingPageView (){
    UIPageViewController *PVC;
    NSMutableArray *viewControllerPages;
    NSMutableArray *icons;
    CGRect windowFrame;
    
    CGPoint farLeftIconDefaultPosition;
    CGPoint leftIconDefaultPosition;
    CGPoint centerIconDefaultPosition;
    CGPoint rightIconDefaultPosition;
    CGPoint farRightIconDefaultPosition;
    
    UIView *navigationBar;
}

@end

@implementation TESlidingPageView

// check number of pages works
// todo make sure setters work
// todo setup offsets
// todo integrate color code
// todo comments

-(instancetype)initWithViewControllers:(NSArray*)viewControllers iconImages:(NSArray*)iconImages{
    self = [super init];
    [self setViewControllers:viewControllers];
    [self setIconImages:iconImages];
    return self;
}


-(void)setViewControllers:(NSArray*)viewControllers{
    viewControllerPages = [[NSMutableArray alloc] init];
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController* viewController, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([viewController isKindOfClass:[UIViewController class]]) {
            [viewControllerPages addObject:viewController];
        } else {
            [NSException raise:@"setViewControllers was passed objects other than UIViewController"
                        format:@"Ensure only subclasses of UIViewController are passed to the setViewControllers method."];
        }
    }];
}

-(void)setIconImages:(NSArray*)iconImages{
    icons = [[NSMutableArray alloc] init];
    [iconImages enumerateObjectsUsingBlock:^(UIImage *iconImage, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([iconImage isKindOfClass:[UIImage class]]) {
            TEPagingViewIcon *icon = [TEPagingViewIcon buttonWithType:UIButtonTypeRoundedRect];
            [icon setImage:iconImage forState:UIControlStateNormal];
            [icon setTag:idx];
            [icon addTarget:self action:@selector(iconPressed:) forControlEvents:UIControlEventTouchUpInside];
            [icons addObject:icon];
        } else {
            [NSException raise:@"setIconImages was passed objects other than UIImage"
                        format:@"Ensure only subclasses of UIImage are passed to the setIconImages method."];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!viewControllerPages || viewControllerPages.count==0) {
        [NSException raise:@"viewContollers property not set"
                    format:@"TESlidingPageView requires viewControllers array."];
    }
    
    if (!icons || icons.count==0) {
        [NSException raise:@"iconImages property not set"
                    format:@"TESlidingPageView requires iconImages array."];
    }
    
    [self setVariablesToDefaults];
    [self setupPageViewController];
    [self setupNavigationBar];
    [self findScrollViewDelegate];
    
}

-(void)setVariablesToDefaults{
    
    windowFrame = self.view.frame;
    
    farLeftIconDefaultPosition = CGPointMake(-windowFrame.size.width*0.5, 42);
    leftIconDefaultPosition = CGPointMake(20, 42);
    centerIconDefaultPosition = CGPointMake(windowFrame.size.width/2, 42);
    rightIconDefaultPosition = CGPointMake(windowFrame.size.width-20, 42);
    farRightIconDefaultPosition = CGPointMake(windowFrame.size.width*1.5, 42);
    
    _overscrollColor = [UIColor whiteColor];
    _navigationBarColor = [UIColor whiteColor];
    _dividerHeight = 1.0;
    _dividerColor = [UIColor blackColor];
    
    _centerIconSize = CGSizeMake(36, 36);
    _sideIconSize = CGSizeMake(22, 22);
    
    _centerIconOffset = UIOffsetZero;
    _leftIconOffset = UIOffsetZero;
    _rightIconOffset = UIOffsetZero;
    
    _centerIconColor = [UIColor blackColor];
    _sideIconColor = [UIColor lightGrayColor];
}

-(void)setupPageViewController{
    PVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                        options:nil];
    PVC.dataSource = self;
    PVC.delegate = self;
    [PVC.view setFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    [PVC setViewControllers:@[viewControllerPages[0]]
                  direction:UIPageViewControllerNavigationDirectionForward
                   animated:NO
                 completion:nil];
    [self addChildViewController:PVC];
    [[self view] addSubview:[PVC view]];
    [self.view setBackgroundColor: _overscrollColor];
}

-(void)setupNavigationBar{
    
    navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowFrame.size.width, 64)];
    [navigationBar setBackgroundColor:_navigationBarColor];
    [self.view addSubview:navigationBar];
    
    UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                               navigationBar.frame.size.height - _dividerHeight,
                                                               windowFrame.size.width,
                                                               _dividerHeight)];
    [divider setBackgroundColor:_dividerColor];
    [navigationBar addSubview:divider];
    
    
    [icons enumerateObjectsUsingBlock:^(TEPagingViewIcon *icon, NSUInteger idx, BOOL * _Nonnull stop) {
        [navigationBar addSubview:icon];
    }];
    
    [self positionIcons];
}

-(void)positionIcons{
    [icons enumerateObjectsUsingBlock:^(TEPagingViewIcon *icon, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == _selectedIndex) {
            [icon setIconSize:_centerIconSize];
            [icon setCenter:centerIconDefaultPosition];
            [icon setCenter:CGPointMake(centerIconDefaultPosition.x+_centerIconOffset.horizontal,
                                       centerIconDefaultPosition.y+_centerIconOffset.vertical)];
            [icon setTintColor:_centerIconColor];
        } else if (idx == _selectedIndex-1){
            [icon setIconSize:_sideIconSize];
            [icon setCenter:CGPointMake(leftIconDefaultPosition.x+_leftIconOffset.horizontal,
                                        leftIconDefaultPosition.y+_leftIconOffset.vertical)];
            [icon setTintColor:_sideIconColor];
        } else if (idx == _selectedIndex+1){
            [icon setIconSize:_sideIconSize];
            [icon setCenter:CGPointMake(rightIconDefaultPosition.x+_rightIconOffset.horizontal,
                                        rightIconDefaultPosition.y+_rightIconOffset.vertical)];
            [icon setTintColor:_sideIconColor];
        } else if(idx < _selectedIndex-1) {
            [icon setIconSize:_sideIconSize];
            [icon setCenter:CGPointMake(farLeftIconDefaultPosition.x+_leftIconOffset.horizontal,
                                        farLeftIconDefaultPosition.y+_leftIconOffset.vertical)];
            [icon setTintColor:_sideIconColor];
        } else if(idx > _selectedIndex+1) {
            [icon setIconSize:_sideIconSize];
            [icon setCenter:CGPointMake(farRightIconDefaultPosition.x+_rightIconOffset.horizontal,
                                        farRightIconDefaultPosition.y+_rightIconOffset.vertical)];
            [icon setTintColor:_sideIconColor];
        }
        
        if (idx == _selectedIndex) { // disable center button
            [icon setUserInteractionEnabled:NO];
        } else [icon setUserInteractionEnabled:YES];
    }];
}

-(void)findScrollViewDelegate{
    // find scrollview from subviews and set up delegate
    [PVC.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIScrollView class]] ) {
            UIScrollView *scrollView = (UIScrollView*)obj;
            [scrollView setDelegate:self];
        }
    }];
}

// when the page has finished animating, set the new index
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
        _selectedIndex = [viewControllerPages indexOfObject:PVC.viewControllers[0]]; // set current index
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // find distance scrolled and convert to unsigned
    float distanceScrolledSigned = scrollView.contentOffset.x / self.view.frame.size.width;
    distanceScrolledSigned--;
    float distanceScrolledUnsigned = fabs(distanceScrolledSigned);
    
    // take UIOffset values into consideration to calculate new CGPoint values
    CGPoint farLeftIconOffsetPosition = CGPointMake(farLeftIconDefaultPosition.x+_leftIconOffset.horizontal,
                                                    farLeftIconDefaultPosition.y+_leftIconOffset.vertical);
    CGPoint leftIconOffsetPosition = CGPointMake(leftIconDefaultPosition.x+_leftIconOffset.horizontal,
                                                    leftIconDefaultPosition.y+_leftIconOffset.vertical);
    CGPoint centerIconOffsetPosition = CGPointMake(centerIconDefaultPosition.x+_centerIconOffset.horizontal,
                                                 centerIconDefaultPosition.y+_centerIconOffset.vertical);
    CGPoint rightIconOffsetPosition = CGPointMake(rightIconDefaultPosition.x+_rightIconOffset.horizontal,
                                                 rightIconDefaultPosition.y+_rightIconOffset.vertical);
    CGPoint farRightIconOffsetPosition = CGPointMake(farRightIconDefaultPosition.x+_rightIconOffset.horizontal,
                                                 farRightIconDefaultPosition.y+_rightIconOffset.vertical);
    
    [icons enumerateObjectsUsingBlock:^(TEPagingViewIcon *icon, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // casting NSUIntegers as primitive integers to allow signed comparions with negative numbers
        if ((int)idx < (int)_selectedIndex-1){                       // far left icon
            
            [icon setIconSize:_sideIconSize];
            
            float dx = (farLeftIconOffsetPosition.x-leftIconOffsetPosition.x) * distanceScrolledSigned;
            float dy = (farLeftIconOffsetPosition.y-leftIconOffsetPosition.y) * distanceScrolledSigned;
            
            [icon setCenter:CGPointMake(farLeftIconOffsetPosition.x+dx, farLeftIconOffsetPosition.y+dy)];
            
            [icon setTintColor:_sideIconColor];
        } else if ((int)idx == (int)_selectedIndex-1) {              // left icon
            
            float dWidth = (_centerIconSize.width - _sideIconSize.width) * distanceScrolledUnsigned;
            float dHeight = (_centerIconSize.height - _sideIconSize.height) * distanceScrolledUnsigned;
            [icon setIconSize:CGSizeMake(_sideIconSize.width+dWidth, _sideIconSize.height+dHeight)];
            
            float dx = (leftIconOffsetPosition.x-centerIconOffsetPosition.x) * distanceScrolledSigned;
            float dy = (farLeftIconOffsetPosition.y-leftIconOffsetPosition.y) * distanceScrolledSigned;
            [icon setCenter:CGPointMake(leftIconOffsetPosition.x+dx, leftIconOffsetPosition.y+dy)];
            
            [icon setTintColor: [UIColor colorForFadeBetweenFirstColor:_sideIconColor
                                                           secondColor:_centerIconColor
                                                               atRatio:distanceScrolledUnsigned]];
            
        } else if ((int)idx == (int)_selectedIndex) {                // center icon
            
            float dWidth = (_sideIconSize.width - _centerIconSize.width) * distanceScrolledUnsigned;
            float dHeight = (_sideIconSize.height - _centerIconSize.height) * distanceScrolledUnsigned;
            [icon setIconSize:CGSizeMake(_centerIconSize.width+dWidth, _centerIconSize.height+dHeight)];
            
            float dx = (leftIconOffsetPosition.x-centerIconOffsetPosition.x) * distanceScrolledSigned;
            float dy = (farLeftIconOffsetPosition.y-leftIconOffsetPosition.y) * distanceScrolledSigned;
            [icon setCenter:CGPointMake(centerIconOffsetPosition.x+dx, centerIconOffsetPosition.y+dy)];
            
            [icon setTintColor: [UIColor colorForFadeBetweenFirstColor:_centerIconColor
                                                           secondColor:_sideIconColor
                                                               atRatio:distanceScrolledUnsigned]];
            
        } else if ((int)idx == (int)_selectedIndex+1) {              // right icon
            
            float dWidth = (_centerIconSize.width - _sideIconSize.width) * distanceScrolledUnsigned;
            float dHeight = (_centerIconSize.height - _sideIconSize.height) * distanceScrolledUnsigned;
            [icon setIconSize:CGSizeMake(_sideIconSize.width+dWidth, _sideIconSize.height+dHeight)];
            
            float dx = (centerIconOffsetPosition.x-rightIconOffsetPosition.x) * distanceScrolledSigned;
            float dy = (farLeftIconOffsetPosition.y-leftIconOffsetPosition.y) * distanceScrolledSigned;
            [icon setCenter:CGPointMake(rightIconOffsetPosition.x+dx, rightIconOffsetPosition.y+dy)];
            
            [icon setTintColor: [UIColor colorForFadeBetweenFirstColor:_sideIconColor
                                                           secondColor:_centerIconColor
                                                               atRatio:distanceScrolledUnsigned]];
            
        } else if ((int)idx > (int)_selectedIndex+1){                // far right icon
            
            [icon setIconSize:_sideIconSize];
            
            float dx = (rightIconOffsetPosition.x-farRightIconOffsetPosition.x) * distanceScrolledSigned;
            float dy = (farLeftIconOffsetPosition.y-leftIconOffsetPosition.y) * distanceScrolledSigned;
            
            [icon setCenter:CGPointMake(farRightIconOffsetPosition.x+dx, rightIconOffsetPosition.y+dy)];
            
            [icon setTintColor:_sideIconColor];
        }
        
        if ((int)idx == (int)_selectedIndex) { // disable center button
            [icon setUserInteractionEnabled:NO];
        } else [icon setUserInteractionEnabled:YES];
    }];
}

// data source delegate method for previous view controller
-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [viewControllerPages indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    return viewControllerPages[index-1];
}

// data source delegate method for next view controller
-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [viewControllerPages indexOfObject:viewController];
    if (index == viewControllerPages.count-1) {
        return nil;
    }
    return viewControllerPages[index+1];
}

-(void)iconPressed:(TEPagingViewIcon*)sender{
    NSUInteger index = sender.tag;
    UIViewController *vc = [viewControllerPages objectAtIndex:index];
    UIPageViewControllerNavigationDirection direction;
    if (index > _selectedIndex) {
        direction = UIPageViewControllerNavigationDirectionForward;
    } else {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    [PVC setViewControllers:@[vc] direction:direction animated:YES completion:^(BOOL finished) {
        _selectedIndex = index; // set current index after animation
    }];
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    UIViewController *vc = [viewControllerPages objectAtIndex:selectedIndex];
    [PVC setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    _selectedIndex = selectedIndex;
    [self positionIcons];
}

@end
