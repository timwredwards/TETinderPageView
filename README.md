# TETinderPageView

## Overview
This is the public repo for TETinderPageView, an emulation of the page-view style controller used in Tinder.

![](https://github.com/timwredwards/TETinderPageView/blob/master/img/demo.gif?raw=true)

## Installation
The controller can be easily installed to a project using the amazing [Cocoapods](https://cocoapods.org). Simply add  `pod 'TETinderPageView'` to your podfile and run `pod install`.

Alternatively, you can install manually by downloading or cloning the repo and adding the files in the lib directory to your project.

## Usage

### Instantiate the controller
```
NSArray *viewControllers = @[viewController1, viewController2, viewController3];
NSArray *buttonImages = @[UIImage1, UIImage2, UIImage3];
TETinderPageView *pageView = [[TETinderPageView alloc] initWithViewControllers:viewControllers buttonImages:buttonImages];
[self.navigationController pushViewController:pageView animated:NO];
```

### Button Specifics
The TETinderPageView class has 5 button "specifics" that you can edit. These outline the size, x/y offset and color of the icons as they pass through the navigation bar. The specifics are named as follows:
```
offscreenLeftButtonSpecifics
leftButtonSpecifics
centerButtonSpecifics
rightButtonSpecifics
offscreenRightButtonSpecifics
```

### Setting Button Size
`[pageView.centerButtonSpecifics setSize:CGSizeMake(20, 20)];`

### Setting Button Color
`[pageView.centerButtonSpecifics setColor:[UIColor redColor]];`

### Setting Button Offset
`[pageView.centerButtonSpecifics setOffset:UIOffsetMake(10, 10)];`

### Setting Selected Page Index
`[pageView setSelectedIndex:2];`

### Styling the Navigation Bar & Divider
The navigation bar and divider in the controller is simply UIViews that can be manipulated like any other view.
```
UIView *navigationBar = pageView.navigationBar;
[navigationBar setBackgroundColor:[UIColor lightGrayColor]];

UIView *divider = pageView.divider;
[divider setHidden:YES];
```

## Requirements

Supports iOS 8.0+
Requires ARC to be enabled

## Author
Developed and maintained by Tim Edwards ([@timwredwards](https://twitter.com/timwredwards))
