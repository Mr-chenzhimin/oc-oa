//
//  AppDelegate.m
//  OA
//
//  Created by dengfan on 13-12-7.
//  Copyright (c) 2013年 dengfan. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyBoardManager.h"
#import "LoginViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    
    
    [IQKeyBoardManager installKeyboardManager];
    
    
    
    NSString * messageAlert = [Utils getCacheForKey:@"messageAlert"];
    if(messageAlert == nil){
        [Utils cache:@"0" forKey:@"messageAlert"];
        messageAlert = @"0";
    }
    
    if([messageAlert isEqualToString:@"0"]){
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)    {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];        [[UIApplication sharedApplication] registerForRemoteNotifications];
        }    else    {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
             (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
        }
        
    }else{
 
    }
    
    NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"msgTritone" ofType:@"caf"];       //创建音乐文件路径
    NSURL *musicURL = [[NSURL alloc] initFileURLWithPath:musicFilePath];
    thePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    [thePlayer prepareToPlay];
    [thePlayer setVolume:1];   //设置音量大小
    thePlayer.numberOfLoops = 0;//设置音乐播放次数  -1为一直循环
    
    // Push register
    
//    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
    return YES;
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
	NSLog(@"Push notification token %@", deviceToken);
    
    NSString * deviceTokenStr = [[[[deviceToken description]
                                   stringByReplacingOccurrencesOfString:@"<"withString:@""]
                                  stringByReplacingOccurrencesOfString:@">" withString:@""]
                                 stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    [Utils cache:deviceTokenStr forKey:@"oa_device_id"];
    NSLog(@"Push notification token \n%@", deviceTokenStr);
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	NSLog(@"Push notification registration failed: %@", [error localizedDescription]);
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    //NSString *itemName = [notif.userInfo objectForKey:ToDoItemKey];
    //[viewController displayItem:itemName];  // custom method
    //application.applicationIconBadgeNumber = notification.applicationIconBadgeNumber-1;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
   // [UIApplication sharedApplication].applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1 ;
    
    NSString *text = [NSString stringWithFormat:@"From Push Notification!"];
    
    NSLog(@"Push  text \n%@", text);
    NSString * notif_getcount = @"notif_getcount";
    NSNotificationCenter *nc1 = [NSNotificationCenter defaultCenter];
    [nc1 postNotificationName:notif_getcount object:nil userInfo:nil];
    
    NSString * notif_name = @"receive_new_message_list";
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:notif_name object:nil userInfo:nil];
    
    NSString * messageAlert = [Utils getCacheForKey:@"messageAlert"];
    
    if(messageAlert != nil && [messageAlert isEqualToString:@"0"]){
        
        [thePlayer play];
        
    }else{
        
    }
    
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
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:5];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *timestamp = [formatter stringFromDate:[[NSDate alloc] init]];
    
    NSString * login_time_flag = [Utils getCacheForKey:@"login_time_flag"];
    if(login_time_flag == nil){
        
        [Utils cache:timestamp forKey:@"login_time_flag"];
        
    }else if(![login_time_flag isEqualToString:timestamp]){
        //退出登陆
        [Utils cache:timestamp forKey:@"login_time_flag"];
        
        [Utils cache:@"" forKey:@"tokenId"];
        [Utils cache:@"" forKey:@"deptName"];
        [Utils cache:@"" forKey:@"userName"];
        [Utils cache:@"" forKey:@"password"];
        
        
        [Toast showWithText:@"登陆超时,请重新登陆" bottomOffset:100 duration:2.2];
        
        
        NSString * notif_name = @"notif_login";
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:notif_name object:nil userInfo:nil];
    }
    
    
    
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
