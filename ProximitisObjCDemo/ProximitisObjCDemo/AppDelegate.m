//
//  AppDelegate.m
//  ProximitisObjCDemo
//
//  Created by Jiří Markalous on 15/09/2019.
//  Copyright © 2019 Proximitis s.r.o. All rights reserved.
//

#import "AppDelegate.h"
#import <ProximitisFramework/ProximitisFramework-Swift.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[Proximitis shared] startWith:@"proximitis"];
    
    [Proximitis setDebugging:YES];
    
    [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
    
    return YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [Proximitis applicationDidEnterBackground];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [Proximitis applicationDidBecomeActive];
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [[Proximitis shared] performBackgroundFetchWithCompletion:^{
        completionHandler(UIBackgroundFetchResultNewData);
    }];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {

    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {

    
    [ProximitisNotificationClient notificationTappedWithResponse:response];
}



@end
