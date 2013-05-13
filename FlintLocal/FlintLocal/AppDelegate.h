//
//  AppDelegate.h
//  FlintLocal
//
//  Created by Andrew Lenox on 9/27/12.
//  Copyright (c) 2012 Andrew Lenox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

extern NSString *const FBSessionStateChangedNotification;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;
-(void)closeSession;

@end
