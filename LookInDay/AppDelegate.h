//
//  AppDelegate.h
//  LookInDay
//
//  Created by Denis Nascimento on 6/15/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THSNavigationController.h"
#import "REFrostedViewController.h"
#import "Constants.h"
#import <SDWebImage/UIImageView+WebCache.h>

@import Firebase;
@import FirebaseAuth;
@import FirebaseDatabase;
@import FirebaseStorage;

@interface AppDelegate : UIResponder <UIApplicationDelegate,REFrostedViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) THSNavigationController *navigationController;

+ (instancetype)sharedInstance;
@end

