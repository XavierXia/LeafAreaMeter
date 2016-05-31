//
//  AppDelegate.m
//  bs
//
//  Created by Jackie on 13-10-5.
//  Copyright (c) 2013年 Jackie. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "DisplayViewController.h"

@implementation AppDelegate
@synthesize window;
@synthesize viewController;
@synthesize tabBarController;

- (void)dealloc
{
    [window release];
    [viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    //创建一个标签栏控制器
    tabBarController = [[UITabBarController alloc] init];
    DisplayViewController *DataViewController = [[DisplayViewController alloc] init];
    DataViewController.title = @"数据记录表";
    
    //声明导航控制器
    UINavigationController *navContorll = [[UINavigationController alloc]init];
    
    //将视图控制器和导航控制器 放到标签栏控制器的数组中
    tabBarController.viewControllers = [NSArray arrayWithObjects:navContorll, DataViewController, nil];
    [DataViewController release];
    
    //声明一个视图控制器
    viewController = [[ViewController alloc] init];
    viewController.title=@"主界面";

    [navContorll pushViewController:viewController animated:NO];
    [viewController release];
 //   [window addSubview:navContorll.view];
    //把标签栏控制器的view放在window下
    [window addSubview:tabBarController.view];
    
    [window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
