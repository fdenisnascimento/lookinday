//
//  LoginViewController.m
//  MensagemDigital
//
//  Created by Denis Nascimento on 5/18/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import "LoginViewController.h"
#import "THSNavigationController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "UIViewController+REFrostedViewController.h"
#import "PostsViewController.h"
#import "THSModel.h"



@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setMenuEnabled:NO];
    if (!self.fromInterna)
        [self setStyleLogin];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Use Firebase library to configure APIs
    
    FIRUser *user = [FIRAuth auth].currentUser;
    
    if (user != nil) {
        PostsViewController *vc = [PostsViewController new];
        vc.postType = PostTypePost;
        [(THSNavigationController*)self.navigationController setViewControllers:@[vc]animated:YES];
    }else{
        self.btnFacebook.backgroundColor = [UIColor colorWithRed:0.271f green:0.392f blue:0.443f alpha:1.00f];
        self.btnFacebook.layer.cornerRadius = 5;
        
        self.btnVisitante.backgroundColor = [UIColor colorWithRed:0.208f green:0.322f blue:0.361f alpha:1.00f];
        self.btnVisitante.layer.cornerRadius = 5;
        
        
        
        //    if (self.fromInterna)
        //        [self createButtonMenu];
        
        self.title = @"LOOK IN DAY";
        
        if (self.fromInterna){
            self.btnVisitante.hidden = YES;
            self.title = @"";
        }
    }

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToVisitante:(UIButton *)sender
{
    PostsViewController *vc = [PostsViewController new];
    vc.postType = PostTypePost;
    [(THSNavigationController*)self.navigationController setViewControllers:@[vc]animated:YES];
}


- (IBAction)goToFacebook:(UIButton *)sender
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    [login logInWithReadPermissions:@[@"public_profile", @"email", @"user_friends"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        
        if (error)
        {
            NSLog(@"error:%@",error.description);
        }
        else if (result.isCancelled)
        {
            NSLog(@"result.isCancelled");
        }
        else
        {
            
            FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                             credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                             .tokenString];
            
            [[FIRAuth auth] signInWithCredential:credential
                                      completion:^(FIRUser *user, NSError *error) {
                                          NSLog(@"User:%@",user);
                                          [THSModel subscribeToChannelInBackground];
                                          PostsViewController *vc = [PostsViewController new];
                                          vc.postType = PostTypePost;
                                          [(THSNavigationController*)self.navigationController setViewControllers:@[vc]animated:YES];
                                          
                                      }];
        }
    }];
}



@end
