# TETinderPageView

<h3>Overview</h3>
This is the public repo for TETinderPageView, an emulation of the page-view style controller used in Tinder. 
<br>
<br>
![](/img/demo.gif)

<h3>Installation</h3>
The controller can be easily installed to a project using the amazing [Cocoapods](https://cocoapods.org). Simply add this line to your podfile and run ```pod install```:
<br>
<br>
 ```pod 'TETinderPageView'```

Alternatively, you can install manually by downloading or cloning the repo and adding the files in the lib directory to your project.

<h3>Usage</h3>

<h5>Instantiate the controller</h5>
```
NSArray *viewControllers = @[viewController1, viewController2, viewController3];
NSArray *buttonImages = @[UIImage1, UIImage2, UIImage3];
TETinderPageView *pageView = [[TETinderPageView alloc] initWithViewControllers:viewControllers
                                                                  buttonImages:buttonImages];
[self.navigationController pushViewController:pageView animated:NO];
```

<h5>Button Specifics</h5>

The TETinderPageView class has 5 button "specifics" that you can edit. These outline the size, x/y offset and color of the icons as they pass through the navigation bar. The specifics are named as follows:

```
offscreenLeftButtonSpecifics;
leftButtonSpecifics;
centerButtonSpecifics;
rightButtonSpecifics;
offscreenRightButtonSpecifics;
```

<h5>Setting Button Size</h5>
```
[pageView.centerButtonSpecifics setSize:CGSizeMake(20, 20)];
```

<h5>Setting Button Color</h5>
```
[pageView.centerButtonSpecifics setColor:[UIColor redColor]];
```

<h5>Setting Button Offset</h5>
```
[pageView.centerButtonSpecifics setOffset:UIOffsetMake(10, 10)];
```

<h5>Setting Selected Page Index</h5>
```
[pageView setSelectedIndex:2];
```

<h5>Styling the Navigation Bar & Divider</h5>
The navigation bar and divider in the controller is simply UIViews that can be manipulated like any other view.

```
UIView *navigationBar = pageView.navigationBar;
[navigationBar setBackgroundColor:[UIColor lightGrayColor]];

UIView *divider = pageView.divider;
[divider setHidden:YES];
```

<h3>Requirements</h3>

Supports iOS 8.0+<br>
Requires ARC to be enabled

<h3>Contributions</h3>
If you encounter problems or have a feature request please open an issue! We welcome pull requests, so if you feel like contributing get involved!

<h3>Author</h3>
Developed and maintained by Tim Edwards ([@timwredwards](https://twitter.com/timwredwards))
