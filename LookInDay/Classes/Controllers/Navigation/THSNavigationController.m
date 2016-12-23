//
//  RecursosNavController.m
//  Recursos
//
//  Created by Denis Nascimento on 5/15/15.
//  Copyright (c) 2015 Denis Nascimento. All rights reserved.
//

#import "THSNavigationController.h"


@interface THSNavigationController ()

@end

@implementation THSNavigationController

- (void)viewDidLoad
{
  [super viewDidLoad];
    
  [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
  if([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
   
  }
}

- (void)showMenu
{
    // Dismiss keyboard (optional)
    //
  [self.view endEditing:YES];
  [self.frostedViewController.view endEditing:YES];
  
    // Present the view controller
    //
  [self.frostedViewController presentMenuViewController];
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    // Dismiss keyboard (optional)
    //
  [self.view endEditing:YES];
  [self.frostedViewController.view endEditing:YES];
  
    // Present the view controller
    //
  [self.frostedViewController panGestureRecognized:sender];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
