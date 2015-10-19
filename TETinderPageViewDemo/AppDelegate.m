//
//  AppDelegate.m
//  TinderPageView
//
//  Created by Timothy Edwards on 07/10/2015.
//  Copyright © 2015 Timothy Edwards. All rights reserved.
//

#import "AppDelegate.h"

#import "TETinderPageView.h"

@interface AppDelegate (){
    TETinderPageView *pageView;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIViewController *page1 = [[UIViewController alloc] init];
    [page1.view setBackgroundColor:[UIColor lightGrayColor]];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    [button setCenter:page1.view.center];
    [button setBackgroundColor:[UIColor blackColor]];
    [button setTitle:@"Go To Page 3" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
//    [page1.view addSubview:button];
    
    UIViewController *page2 = [[UIViewController alloc] init];
    [page2.view setBackgroundColor:[UIColor orangeColor]];
    
    UIViewController *page3 = [[UIViewController alloc] init];
    [page3.view setBackgroundColor:[UIColor blueColor]];
    
    NSArray *viewControllers = @[page1, page2, page3];
    NSArray *images = @[[UIImage imageNamed:@"0.png"], [UIImage imageNamed:@"1.png"], [UIImage imageNamed:@"2.png"]];
    pageView = [[TETinderPageView alloc] initWithViewControllers:viewControllers buttonImages:images];
    
    // side icons
    [pageView.offscreenLeftButtonSpecifics setColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0]];
    [pageView.leftButtonSpecifics setColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0]];
    [pageView.rightButtonSpecifics setColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0]];
    [pageView.offscreenRightButtonSpecifics setColor:[UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0]];
    
    // center icon
    [pageView.centerButtonSpecifics setColor:[[UIColor alloc] initWithRed:255.0/255.0 green:106.0/255.0 blue:79.0/255.0 alpha:1.0]];
    [pageView.centerButtonSpecifics setSize:CGSizeMake(35, 35)];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = pageView;
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)buttonPressed{
    [pageView setSelectedIndex:2];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
