//
//  AppDelegate.m
//  Cuisine
//
//  Created by Yeehan Chan on 9/30/15.
//  Copyright © 2015 Yeehan Chan. All rights reserved.
//

#import "AppDelegate.h"
#import "loginPageViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
    
    
    NSURLCredential *credential;
    NSDictionary *credentials;
    extern NSString *urlString;
    NSURL *url = [NSURL URLWithString:urlString];
//   NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/authenticate",urlString]];
    NSURLProtectionSpace* loginProtectionSpace = [[NSURLProtectionSpace alloc]initWithHost:url.host port:[url.port integerValue] protocol:url.scheme realm:nil authenticationMethod:NSURLAuthenticationMethodHTTPDigest];
    
    credentials = [[NSURLCredentialStorage sharedCredentialStorage] credentialsForProtectionSpace:loginProtectionSpace];
 //   credential = [credentials.objectEnumerator nextObject];
    

    NSLog(@"print credentials %@", credentials);
    UIViewController * initialView = [[UIViewController alloc]init];

    if(credentials != NULL){
        NSLog(@"login");
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController *tabBar = [sb instantiateViewControllerWithIdentifier:@"tabBar"];
        initialView = tabBar;
    }
    else{
        NSLog(@"no credential!");
        loginPageViewController *login = [[loginPageViewController alloc]init];
        initialView = login;
    }
    self.window.rootViewController = initialView;
    
    return YES;
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
