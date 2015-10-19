//
//  ViewController.m
//  TinderPageView
//
//  Created by Timothy Edwards on 07/10/2015.
//  CopyLOL © 2015 Timothy Edwards. All rights reserved.
//

#import "TETinderPageView.h"

#import "TETinderButton.h"

#import "TEColorCrossfade.h"

@implementation TETinderPageView

- (instancetype)initWithViewControllers:(NSArray *)viewControllers buttonImages:(NSArray *)buttonImages {
    self = [super init];
    if (self) {
        // view controllers for the page view are setup
        [self setViewControllers:viewControllers];
        // buttons for the nav bar are setup
        [self setButtonImages:buttonImages];
        // views and specifics are instantiated
        [self initViews];
    }
    return self;
}

-(void)setViewControllers:(NSArray*)viewControllers{
    NSMutableArray *viewControllersTemp = [[NSMutableArray alloc] init];
    [viewControllers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIViewController class]]) {
            [viewControllersTemp addObject:obj];
        } else {
            @throw [NSException exceptionWithName:@"Wrong class"
                                           reason:@"Object passed to setViewControllers not a subclass of UIViewController" userInfo:nil];
        }
    }];
    _viewControllers = [NSArray arrayWithArray:viewControllersTemp];
}

-(void)setButtonImages:(NSArray*)buttonImages{
    NSMutableArray *buttonsTemp = [[NSMutableArray alloc] init];
    [buttonImages enumerateObjectsUsingBlock:^(UIImage *buttonImage, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([buttonImage isKindOfClass:[UIImage class]]) {
            TETinderButton *button = [TETinderButton buttonWithType:UIButtonTypeRoundedRect];
            [button setImage:buttonImage forState:UIControlStateNormal];
            [button setTag:idx];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [buttonsTemp addObject:button];
        } else {
            @throw [NSException exceptionWithName:@"Wrong class"
                                           reason:@"Object passed to setButtonImages not a subclass of UIImage" userInfo:nil];
        }
    }];
    _buttons = [NSArray arrayWithArray:buttonsTemp];
}

-(void)initViews{
    _PVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                           navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                         options:nil];
    
    _PVC.dataSource = self;
    _PVC.delegate = self;
    [_PVC setViewControllers:@[_viewControllers[0]]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
    [self addChildViewController:_PVC];
    
    _navigationBar = [[UIView alloc] init];
    _divider = [[UIView alloc] init];
    
    _offscreenLeftButtonSpecifics = [[TETinderButtonSpecifics alloc] init];
    _leftButtonSpecifics = [[TETinderButtonSpecifics alloc] init];
    _centerButtonSpecifics = [[TETinderButtonSpecifics alloc] init];
    _rightButtonSpecifics = [[TETinderButtonSpecifics alloc] init];
    _offscreenRightButtonSpecifics = [[TETinderButtonSpecifics alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // error checking
    if (!_viewControllers || _viewControllers.count==0) {
        @throw [NSException exceptionWithName:@"Property not set"
                                       reason:@"Showed view without setting viewControllers" userInfo:nil];
    }
    
    if (!_buttons || _buttons.count==0) {
        @throw [NSException exceptionWithName:@"Property not set"
                                       reason:@"Showed view without setting buttons" userInfo:nil];
    }
    
    // after main view is loaded, set values, add subviews
    [self processViews];
    // iterate over page view subviews to find scroll view and set delegate
    [self findScrollViewDelegate];
}

-(void)processViews{
    // button specifics
    _offscreenLeftButtonSpecifics.position = CGPointMake(-self.view.frame.size.width*0.5, 42);
    _leftButtonSpecifics.position = CGPointMake(25, 42);
    _centerButtonSpecifics.position = CGPointMake(self.view.frame.size.width/2, 42);
    _rightButtonSpecifics.position = CGPointMake(self.view.frame.size.width-25, 42);
    _offscreenRightButtonSpecifics.position = CGPointMake(self.view.frame.size.width*1.5, 42);
    
    // self
    [self.view setBackgroundColor: [UIColor whiteColor]];
    
    // PVC
    [[self view] addSubview:_PVC.view];
    [_PVC.view setFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    // nav bar
    [self.view addSubview:_navigationBar];
    [_navigationBar setFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [_navigationBar setBackgroundColor:[UIColor whiteColor]];
    
    // divider
    [_navigationBar addSubview:_divider];
    [_divider setFrame:CGRectMake(0, _navigationBar.frame.size.height-1, _navigationBar.frame.size.width, 1)];
    [_divider setBackgroundColor:[UIColor blackColor]];
    
    [self processButtons];
}

-(void)processButtons{
    // buttons
    [_buttons enumerateObjectsUsingBlock:^(TETinderButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
        [_navigationBar addSubview:button];
        if (idx == _selectedIndex) {
            [button setButtonSize:_centerButtonSpecifics.size];
            [button setCenter:_centerButtonSpecifics.getCalculatedPosition];
            [button setTintColor:_centerButtonSpecifics.color];
        } else if (idx == _selectedIndex-1){
            [button setButtonSize:_leftButtonSpecifics.size];
            [button setCenter:_leftButtonSpecifics.getCalculatedPosition];
            [button setTintColor:_leftButtonSpecifics.color];
        } else if (idx == _selectedIndex+1){
            [button setButtonSize:_rightButtonSpecifics.size];
            [button setCenter:_rightButtonSpecifics.getCalculatedPosition];
            [button setTintColor:_rightButtonSpecifics.color];
        } else if(idx < _selectedIndex-1) {
            [button setButtonSize:_offscreenLeftButtonSpecifics.size];
            [button setCenter:_offscreenLeftButtonSpecifics.getCalculatedPosition];
            [button setTintColor:_offscreenLeftButtonSpecifics.color];
        } else if(idx > _selectedIndex+1) {
            [button setButtonSize:_offscreenRightButtonSpecifics.size];
            [button setCenter:_offscreenRightButtonSpecifics.getCalculatedPosition];
            [button setTintColor:_offscreenRightButtonSpecifics.color];
        }
        
        if (idx == _selectedIndex) { // disable center button
            [button setUserInteractionEnabled:NO];
        } else [button setUserInteractionEnabled:YES];
    }];
}

-(void)findScrollViewDelegate{
    // find scrollview from subviews and set up delegate
    [_PVC.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIScrollView class]] ) {
            UIScrollView *scrollView = (UIScrollView*)obj;
            [scrollView setDelegate:self];
        }
    }];
}

// when the page has finished animating, set the new index
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {
        _selectedIndex = [_viewControllers indexOfObject:_PVC.viewControllers[0]]; // set current index
    }
}

// when page view is scrolled, move/resize/recolor buttons
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    // find distance scrolled as signed 0-1 float value
    float distanceScrolled = scrollView.contentOffset.x / self.view.frame.size.width;
    distanceScrolled--;
    
    [_buttons enumerateObjectsUsingBlock:^(TETinderButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ((int)idx == (int)_selectedIndex) { // disable center button
            [button setUserInteractionEnabled:NO];
        } else [button setUserInteractionEnabled:YES];
        
        if (distanceScrolled > 0) { // if going left
            if ((int)idx == (int)_selectedIndex-1) {              // left button
                [self processSlidingButton:button previousSpecifics:_leftButtonSpecifics nextSpecifics:_offscreenLeftButtonSpecifics distanceScrolled:distanceScrolled];
            } else if ((int)idx == (int)_selectedIndex) {                // center button
                [self processSlidingButton:button previousSpecifics:_centerButtonSpecifics nextSpecifics:_leftButtonSpecifics distanceScrolled:distanceScrolled];
            } else if ((int)idx == (int)_selectedIndex+1) {              // right button
                [self processSlidingButton:button previousSpecifics:_rightButtonSpecifics nextSpecifics:_centerButtonSpecifics distanceScrolled:distanceScrolled];
            } else if ((int)idx == (int)_selectedIndex+2){                // offscreen right button
                [self processSlidingButton:button previousSpecifics:_offscreenRightButtonSpecifics nextSpecifics:_rightButtonSpecifics distanceScrolled:distanceScrolled];
            }
        } else { // if going right
            if ((int)idx == (int)_selectedIndex-2) {
                [self processSlidingButton:button previousSpecifics:_offscreenLeftButtonSpecifics nextSpecifics:_leftButtonSpecifics distanceScrolled:-distanceScrolled];
            } else if ((int)idx == (int)_selectedIndex-1) {              // left button
                [self processSlidingButton:button previousSpecifics:_leftButtonSpecifics nextSpecifics:_centerButtonSpecifics distanceScrolled:-distanceScrolled];
            } else if ((int)idx == (int)_selectedIndex) {                // center button
                [self processSlidingButton:button previousSpecifics:_centerButtonSpecifics nextSpecifics:_rightButtonSpecifics distanceScrolled:-distanceScrolled];
            } else if ((int)idx == (int)_selectedIndex+1) {              // right button
                [self processSlidingButton:button previousSpecifics:_rightButtonSpecifics nextSpecifics:_offscreenRightButtonSpecifics distanceScrolled:-distanceScrolled];
            }
        }
    }];
}

-(void)processSlidingButton:(TETinderButton*)button
          previousSpecifics:(TETinderButtonSpecifics*)previousSpecifics
              nextSpecifics:(TETinderButtonSpecifics*)nextSpecifics
           distanceScrolled:(float)distanceScrolled{
    
    float distanceScrolledUnsigned = fabs(distanceScrolled);
    
    float dW = (nextSpecifics.size.width - previousSpecifics.size.width) * distanceScrolledUnsigned;
    float dH = (nextSpecifics.size.height - previousSpecifics.size.height) * distanceScrolledUnsigned;
    [button setButtonSize:CGSizeMake(previousSpecifics.size.width+dW, previousSpecifics.size.height+dH)];
    
    float dx = (nextSpecifics.getCalculatedPosition.x-previousSpecifics.getCalculatedPosition.x) * distanceScrolled;
    float dy = (nextSpecifics.getCalculatedPosition.y-previousSpecifics.getCalculatedPosition.y) * distanceScrolled;
    [button setCenter:CGPointMake(previousSpecifics.getCalculatedPosition.x+dx, previousSpecifics.getCalculatedPosition.y+dy)];
    
    [button setTintColor: [TEColorCrossfade colorForFadeBetweenFirstColor:previousSpecifics.color secondColor:nextSpecifics.color atRatio:distanceScrolledUnsigned]];
}

// data source delegate method for previous view controller
-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [_viewControllers indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    return _viewControllers[index-1];
}

// data source delegate method for next view controller
-(UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [_viewControllers indexOfObject:viewController];
    if (index == _viewControllers.count-1) {
        return nil;
    }
    return _viewControllers[index+1];
}

-(void)buttonPressed:(TETinderButton*)sender{
    NSUInteger index = sender.tag;
    UIViewController *vc = [_viewControllers objectAtIndex:index];
    UIPageViewControllerNavigationDirection direction;
    if (index > _selectedIndex) {
        direction = UIPageViewControllerNavigationDirectionForward;
    } else {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    [_PVC setViewControllers:@[vc] direction:direction animated:YES completion:^(BOOL finished) {
        _selectedIndex = index; // set current index after animation
    }];
}

-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    UIViewController *vc = [_viewControllers objectAtIndex:selectedIndex];
    [_PVC setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    _selectedIndex = selectedIndex;
    [self processViews];
}

@end
