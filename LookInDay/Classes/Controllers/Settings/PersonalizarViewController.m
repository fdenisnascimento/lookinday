//
//  PersonalizarViewController.m
//  LookInDay
//
//  Created by Denis Nascimento on 10/20/15.
//  Copyright © 2015 Denis Nascimento. All rights reserved.
//

#import "PersonalizarViewController.h"

@interface PersonalizarViewController ()

@end

@implementation PersonalizarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


-(void)resetButtons
{
  self.btn1.alpha = 0.5f;
  self.btn2.alpha = 0.5f;
  self.btn3.alpha = 0.5f;
  
}
-(IBAction)setCor:(UIButton*)sender {

  sender.alpha = 1;
  
  
  switch (sender.tag) {
    case 1:
      [Constants setColor:[UIColor colorWithRed:0.455f green:0.349f blue:0.510f alpha:1.00f]];
      break;
    case 2:
      [Constants setColor:[UIColor colorWithRed:0.816f green:0.255f blue:0.384f alpha:1.00f]];
      break;
    case 3:
      [Constants setColor:[UIColor colorWithRed:0.357f green:0.604f blue:0.518f alpha:1.00f]];
      break;
      
    default:
      break;
  }

  [self.navigationController popViewControllerAnimated:YES];
  
}



@end
